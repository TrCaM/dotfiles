#!/bin/bash
# POMODORO in YA TerMINAL ;)

function pomoc {
  cycles=${1:-4}
  dur=${2:-25}
  break=${3:-5}
  printf "🍅 🍅 Pomodoro Cycle starts.... \n\n"
  eval "(mpg123 Downloads/sounds/MGS-alert.mp3 > /dev/null 2>&1)"
  let "var=cycles"
  for cycle in {1..$var}
  do
    echo -e "\033[0m"
    printf "🚦Cycle $cycle: \n"
    if [ $cycle = $cycles ]
    then
      eval "(pomo -d $dur 'Study sessions completed 🤙🤙')"
    else 
      eval "(pomo -d $dur 'Take a break ⏸' && pomo -d $break '🕔 🕔 Cycle $(($cycle + 1)) starts:')"
    fi
  done
  eval "(mpg123 Downloads/sounds/telephone-ring.mp3 > /dev/null 2>&1)"
}

function pomo {
    RED='\033[0;31m'
    NC='\033[0m' # No Color
    ORANGE='\033[0;33m'


    if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
        echo "usage: pomo       25 minute cycle"
        echo -e "   or: pomo [break]['_message_']  see options below\n"
        echo "Options:"
        echo "  d: timer duration in minutes"
        echo "  s: 05 minute break"
        echo "  l:  15 minute break"
        echo "  message: Your message to display"
        return
    fi

    if [[ "$1" == "-v" ]] || [[ "$1" == "--version" ]]; then
        echo -e "${ORANGE}POMODORO TIMER BY RUKY"
        echo "  v: 1"
        echo "  twitter: @justruky"
        echo "  blog: rukshn.github.io"
        echo -e "  email: arkruka[@]gmail.com"
        return
    fi

    TITLE="POMODORO TIMER"
    MESSAGE="$3"
    ICON="face-cool"
    BEEP="echo haha"
    TIMER=1500

    while :
    do
        case "$1" in
        -d | --duration)
            BEEP="(mpg123 Downloads/sounds/MGS-alert.mp3 > /dev/null 2>&1)"
            TIMER=$(($2 *60))
            shift 2
            ;;
        -l | --long-break)
            MESSAGE="Long break over, back to work"
            TIMER=900
            shift
            ;;
        -s | --short-break)
            BEEP="mpg123 Downloads/sounds/MGS-alert.mp3 > /dev/null 2>&1"
            MESSAGE="Short break over, back to work"
            TIMER=$(($2* 60))
            #TIMER=300
            shift
            ;;
        -*)
          echo "Error: Unknown option: $1" >&2
          return 1
          ;;
        *)  # No more options
          break
          ;;
        esac
    done

    if [ -n "$3" ]; then
        MESSAGE="$3"
    elif [ -z "$MESSAGE" ]; then
        MESSAGE="Time to take a break"
    fi

    echo -e "${RED}TIMER SET FOR $(($TIMER/60)) MINUTES"

    # LINUX users
    if [[ "$(uname)" == "Linux" ]]; then
        eval "(termdown $TIMER && notify-send '$TITLE' '$MESSAGE' --icon=$ICON && $BEEP &)"
    # MAC users
    elif [[ "$(uname)" == "Darwin" ]]; then
        eval "(termdown $TIMER && terminal-notifier -message '$MESSAGE' -title 'Pomodoro' --subtitle '$TITLE' && $BEEP &)"
    else
        echo "Sorry! Only Linux or Mac";
    fi
}

_alarm() {
    if [[ "$(uname)" == "Linux" ]]; then
        #mpg123 /home/gon/Downloads/sounds/Game-show-wrong-answer-sound/Game-show-wrong-answer-sound.mp3
    elif [[ "$(uname)" == "Darwin" ]]; then
        say -v bells 'beep'
    fi
}

