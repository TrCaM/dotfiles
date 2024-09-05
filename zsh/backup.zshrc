# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#
# Prerequisite:
#    - zgen
#    - PowerLevel 10k
#    - ZSH
# TODO: Write script to install automatically install missing tools
#   - Make + Stow
#   - TMUX
#   - Move the dotfiles to the correct places
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust \
    zdharma-continuum/fast-syntax-highlighting \
    zdharma-continuum/history-search-multi-word \
    hlissner/zsh-autopair \
    zsh-users/zsh-history-substring-search \
    zsh-users/zsh-completions \
    zsh-users/zsh-autosuggestions \
    jocelynmallon/zshmarks

zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit load agkozak/zsh-z

### End of Zinit's installer chunk
zinit snippet OMZ::plugins/compleat
zinit snippet OMZ::plugins/colored-man-pages
zinit snippet OMZ::plugins/colorize
zinit snippet OMZ::plugins/command-not-found
# zinit snippet OMZ::plugins/copydir
zinit snippet OMZ::plugins/copyfile
zinit snippet OMZ::plugins/cp
zinit snippet OMZ::plugins/dircycle
zinit snippet OMZ::plugins/encode64
zinit snippet OMZ::plugins/extract
zinit snippet OMZ::plugins/history


bindkey -v
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^f" forward-word
bindkey "^b" backward-word
bindkey "^k" kill-line
bindkey "^d" delete-char
bindkey "^y" accept-and-hold
bindkey "^w" backward-kill-word
bindkey "^u" backward-kill-line

# Source defined functions.
[[ -f ~/.zsh_functions ]] && source ~/.zsh_functions

# Source local customizations.
[[ -f ~/.zsh_rclocal ]] && source ~/.zsh_rclocal

[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases

# Source exports and aliases.
[[ -f ~/.zsh_exports ]] && source ~/.zsh_exports

source <(fzf --zsh)

# Source nnn config so that we can CD on quit
[[ -f ~/.nnn_config.zsh ]] && source ~/.nnn_config.zsh

if [ -f /usr/share/nnn/quitcd/quitcd.bash_sh_zsh ]; then
    source /usr/share/nnn/quitcd/quitcd.bash_sh_zsh
fi

# Google Stuff
source /etc/bash_completion.d/hgd

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
(( ! ${+functions[p10k]} )) || p10k finalize

export iterm2_hostname=caot
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[[ -f /etc/bash_completion.d/g4d ]] && source /etc/bash_completion.d/g4d

function gcert() {
  if [[ -n $TMUX ]]; then
    eval $(tmux show-environment -s)
  fi

  command gcert "$@"
}

SAVEHIST=100000
# History eternal
HISTSIZE=100000
HISTFILE=~/.zsh_history

[[ -f ~/.40-blaze.sh ]] && source ~/.40-blaze.sh

# ---------------------- P10K Fig Prompt -----------------------------------
# See https://g3doc.corp.google.com/company/users/julienbc/cmdline/index.md?cl=head

# Common global variables that specify what to cache where.
FIG_CACHE_BASE_DIR=/tmp/fig-cache
FIG_STATE_INDICATOR_FILES=(".hg/blackbox.log" ".citc/manifest.rawproto")
FIG_STATUS_FILE="status.txt"
FIG_STATE_HASH_FILE="state.hash"
# Lines from .blackbox.log matching the following pattern will be ignored for
# hash computation and thus will prevent the status being updated. Add commands
# in here that do not change the Fig state.
BLACKBOX_IGNORE=">.*(xl|ll|figstatus|status|diff|root|exportedcl|preloading|debugfetchconfig)"

# Returns the root directory of the current Fig client. Should only be called
# from within a Fig client.
function get_fig_client_root() {
  local root_dir="${PWD%/google3*}"
  echo "$root_dir"
}

# Returns the name of the current Fig client. Should only be called from within
# a Fig client.
function get_fig_client_name() {
  local root_dir="$( get_fig_client_root )"
  local client_name="${root_dir##/google/*/}"
  echo "$client_name"
}

# Returns the directory where we cache the status for the current Fig client.
function get_fig_client_cache_dir() {
  [ ! -d "$FIG_CACHE_BASE_DIR" ] && mkdir "$FIG_CACHE_BASE_DIR"
  client_name=$( get_fig_client_name )
  client_cache_dir="$FIG_CACHE_BASE_DIR/$client_name"
  # Make sure the cache dir exists.
  [ ! -d "$client_cache_dir" ] && mkdir "$client_cache_dir"
  echo "$client_cache_dir"
}

# Returns the hash of the file state of the current Fig client.
function get_fig_client_state_hash() {
  local state_hash=""
  local -a state_files
  for file in ${FIG_STATE_INDICATOR_FILES}; do
    file="$( get_fig_client_root )/${file}"
    if [ -f "$file" ]; then
      if [[ "$file" =~ ".*blackbox.log" ]]; then
        state_hash="${state_hash}\n$( egrep -v "${BLACKBOX_IGNORE}" "$file" | \
                                      md5sum )"
      else
        state_hash="${state_hash}\n$( md5sum "$file" )"
      fi
    fi
  done
  echo "$state_hash"
}

# Returns 0 if the status cache for the current Fig client is outdated and
# needs to be updated and 1 otherwise. Should only be called from within a Fig
# client.
function should_update_fig_status_cache() {
  local state_hash="$( get_fig_client_state_hash )"
  local cached_state_hash="emptycache"
  local cached_state_hash_file
  cached_state_hash_file="$( get_fig_client_cache_dir )/$FIG_STATE_HASH_FILE"
  if [ -f "$cached_state_hash_file" ]; then
    cached_state_hash=$(<"$cached_state_hash_file")
  fi
  if [ "$cached_state_hash" != "$state_hash" ]; then
    # Update cache since the state hash has changed.
    return 0
  fi

  # Do not update cache.
  return 1
}

# Updates the status cache for the current Fig client. Should only be called
# from within a Fig client.
function update_fig_status_cache() {
  local status_file="$( get_fig_client_cache_dir )/$FIG_STATUS_FILE"
  hg figstatus >! "$status_file"

  local state_hash="$( get_fig_client_state_hash )"
  local cached_state_hash_file
  cached_state_hash_file="$( get_fig_client_cache_dir )/$FIG_STATE_HASH_FILE"
  echo "$state_hash" >! "$cached_state_hash_file"
}

# Returns a multi-line output of the status of the current Fig client by either
# looking the status up in the cache file if the cache is current or loading it
# directly from Fig and updating the cache. Should only be called from within a
# Fig client.
function fig_status() {
  if should_update_fig_status_cache; then
    update_fig_status_cache
  fi
  local status_file="$( get_fig_client_cache_dir )/$FIG_STATUS_FILE"
  cat "$status_file"
}

# Returns whether the current directory is (likely) a Fig-on-CITC client.
function is_fig_client() {
  if [[ "$PWD" =~ /google/src/cloud/$USER/* ]] && \
     [[ -d ${PWD%%/google3*}/.hg ]]; then
    return 0
  fi
  return 1
}

# Returns a pseudo-template string that can be used by get_fig_prompt to create
# a ZSH Fig prompt.
#
# The prompt returned by get_fig_prompt can be easily customized by overriding
# this function.
#
# Template Arguments:
#   FIG_PROMPT_MODIFIED: Replaced with $modified
#   FIG_PROMPT_ADDED: Replaced with $added
#   FIG_PROMPT_DELETED: Replaced with $deleted
#   FIG_PROMPT_UNKNOWN: Replaced with $unknown
#   FIG_PROMPT_UNEXPORTED: Replaced with $unexported
#   FIG_PROMPT_OBSOLETE: Replaced with $obsolete
#   FIG_PROMPT_CL: Replaced with $cl
#   FIG_PROMPT_DESCRIPTION: Replaced with $description
#   FIG_PROMPT_CHANGENAME: Replaced with $changename
#   FIG_PROMPT_HAS_SHELVE: Replaced with $has_shelve
function get_fig_prompt_template() {
  echo -n '%b:%B%F{white}['
  echo -n '%F{yellow}FIG_PROMPT_MODIFIED%F{green}FIG_PROMPT_ADDED'
  echo -n '%F{red}FIG_PROMPT_DELETED%F{cyan}FIG_PROMPT_UNKNOWN'
  echo -n '%F{magenta}FIG_PROMPT_HAS_SHELVE%F{white}FIG_PROMPT_CHANGENAME'
  echo -n '%F{green}FIG_PROMPT_UNEXPORTED%F{red}FIG_PROMPT_OBSOLETE'
  echo -n '%F{white}]%b'
}

# Returns a string that can be used in a ZSH prompt to display the status of
# the current Fig client.
function get_fig_prompt() {
  if ! is_fig_client; then
    return 0
  fi
  figstatus=("${(@f)$( fig_status )}")
  modified=$figstatus[1]
  added=$figstatus[2]
  deleted=$figstatus[3]
  unknown=$figstatus[4]
  unexported=$figstatus[5]
  obsolete=$figstatus[6]
  cl=$figstatus[7]
  description=$figstatus[8]
  # Remove description string (it's usually too long and is in the terminal
  # title anyway).
  description=""
  # Uncomment this to truncate the description string
  # description=$description[1,10]
  branch=$figstatus[9]
  if [ -z "$branch" ]; then
    branch="$cl"
  fi
  changename=$figstatus[13]
  if [ -z "$changename" ]; then
    changename="$branch"
  fi
  has_shelve=""
  # POSIX-compatible way to check whether shelved-directory is non-empty.
  shelve_dir="$( get_fig_client_root )/.hg/shelved/"
  if [ -d "$shelve_dir" ] && /bin/ls -1qA "$shelve_dir" | grep -q .; then
    has_shelve="!"
  fi

  local tpl="$(get_fig_prompt_template)"
  tpl="${tpl//FIG_PROMPT_MODIFIED/$modified}"
  tpl="${tpl//FIG_PROMPT_ADDED/$added}"
  tpl="${tpl//FIG_PROMPT_DELETED/$deleted}"
  tpl="${tpl//FIG_PROMPT_UNKNOWN/$unknown}"
  tpl="${tpl//FIG_PROMPT_UNEXPORTED/$unexported}"
  tpl="${tpl//FIG_PROMPT_OBSOLETE/$obsolete}"
  tpl="${tpl//FIG_PROMPT_CL/$cl}"
  tpl="${tpl//FIG_PROMPT_DESCRIPTION/$description}"
  tpl="${tpl//FIG_PROMPT_CHANGENAME/$changename}"
  tpl="${tpl//FIG_PROMPT_HAS_SHELVE/$has_shelve}"
  echo "$tpl"
}

typeset -Ag FIG_STATUS_INDICES
FIG_STATUS_INDICES[modified]=1
FIG_STATUS_INDICES[added]=2
FIG_STATUS_INDICES[deleted]=3
FIG_STATUS_INDICES[unknown]=4
FIG_STATUS_INDICES[unexported]=5
FIG_STATUS_INDICES[obsolete]=6
FIG_STATUS_INDICES[cl]=7
FIG_STATUS_INDICES[description]=8
FIG_STATUS_INDICES[branch]=9
FIG_STATUS_INDICES[changename]=13

# Returns the value of the specified property in the current Fig repository.
# While not as fast as get_fig_prompt, allows for personal configuration of the
# prompt string in a user's zshrc.
#
# TODO(cclausen): This would be far more convenient (and likely quicker) if we
# could pass around an associative array instead of reparsing the output for
# each property being used.
#
# Example usage:
#   function my_hg_prompt {
#     echo "$(fig_prop "modified") $(fig_prop "cl") $(fig_prop "description")"
#   }
#   PROMPT='%n@%m[$(my_hg_prompt)] %#'
#
# Prompt output:
#   user@host[? 181818181 Excerpt from CL description] %
#
# Valid properties (from figstatus):
#  modified
#  added
#  deleted
#  unknown
#  unexported
#  obsolete
#  cl
#  description
#  branch
function fig_prop() {
  if ! is_fig_client; then
    return 0
  fi

  figstatus=("${(@f)$( fig_status )}")
  echo "${figstatus[$FIG_STATUS_INDICES[$1]]}"
}

# Template Arguments:
#   FIG_PROMPT_MODIFIED: Replaced with $modified
#   FIG_PROMPT_ADDED: Replaced with $added
#   FIG_PROMPT_DELETED: Replaced with $deleted
#   FIG_PROMPT_UNKNOWN: Replaced with $unknown
#   FIG_PROMPT_UNEXPORTED: Replaced with $unexported
#   FIG_PROMPT_OBSOLETE: Replaced with $obsolete
#   FIG_PROMPT_CL: Replaced with $cl
#   FIG_PROMPT_DESCRIPTION: Replaced with $description
#   FIG_PROMPT_CHANGENAME: Replaced with $changename
#   FIG_PROMPT_HAS_SHELVE: Replaced with $has_shelve
function get_fig_prompt_template() {
  echo -n '%F{yellow}FIG_PROMPT_MODIFIED %F{green}FIG_PROMPT_ADDED'
  echo -n ' %F{red}FIG_PROMPT_DELETED %F{magenta}FIG_PROMPT_UNKNOWN'
  echo -n ' %F{magenta}FIG_PROMPT_HAS_SHELVE %F{white}FIG_PROMPT_DESCRIPTION '
  echo -n ' %F{blue}FIG_PROMPT_UNEXPORTED %F{red}FIG_PROMPT_OBSOLETE'
  echo -n ' %F{white}cl/FIG_PROMPT_CL'
}

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

POWERLEVEL9K_CUSTOM_FIG='get_fig_prompt'
# Add fig segment to front of right prompt
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS[1,0]=custom_fig
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS[-2,0]=custom_fig

complete -D -C ~/bin/flagpick -o bashdefault -o default

if [[ $OSTYPE != 'darwin'* ]]; then
  eval "$(navi widget zsh)"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


export nvm_dir="$home/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # this loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source ~/.nvm/nvm.sh
