syntax on
filetype plugin on

call plug#begin('~/.vim/plugged')
  "Ipython integration
  Plug 'bfredl/nvim-ipy'
  "Plug 'szymonmaszke/vimpyter'
  Plug 'goerz/jupytext.vim'

  "Vim wiki and more
  Plug 'vimwiki/vimwiki'
  Plug 'mattn/calendar-vim'
  Plug 'tpope/vim-speeddating'
  Plug 'chrisbra/NrrwRgn'
  Plug 'tbabej/taskwiki'
  Plug 'powerman/vim-plugin-AnsiEsc'

  "Copy paste
  Plug 'christoomey/vim-system-copy'
  Plug 'svermeulen/vim-subversive'
  Plug 'svermeulen/vim-cutlass'
  Plug 'svermeulen/vim-yoink'

  "FZF"
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'

  "stable sessions"
  Plug 'xolox/vim-misc'
  Plug 'xolox/vim-session'

  Plug 'honza/vim-snippets'
  if ! has('nvim')
    Plug 'valloric/youcompleteme'
  endif

  "Typescript
  Plug 'leafgarland/typescript-vim'
  Plug 'pangloss/vim-javascript'

  "Markdown"
  Plug 'lervag/vimtex'
  Plug 'donRaphaco/neotex', { 'for': 'tex' }
  Plug 'vim-pandoc/vim-pandoc'
  Plug 'vim-pandoc/vim-pandoc-syntax'
  Plug 'vim-pandoc/vim-rmarkdown'
  Plug 'mattly/vim-markdown-enhancements'
  Plug 'suan/vim-instant-markdown'
  Plug 'SidOfc/mkdx'

  "Git"
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'

  "Coding utils
  Plug 'jiangmiao/auto-pairs'
  Plug 'haya14busa/incsearch-easymotion.vim'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'tommcdo/vim-exchange'
  Plug 'haya14busa/incsearch.vim'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-unimpaired'
  Plug 'majutsushi/tagbar'

  " Writing supports
  Plug 'dbmrq/vim-ditto' 
  Plug 'junegunn/goyo.vim'

  "Coding visual effect"
  Plug 'psliwka/vim-smoothie'

  " Languages specific
  Plug 'mattn/emmet-vim', { 'for': 'html' }

  " Syntax highlight"
  "Plug 'sheerun/vim-polyglot'
  Plug 'vim-python/python-syntax'

  " markdown syntax highlight, theme, icons
  Plug 'ryanoasis/vim-devicons'
  "Plug 'xolox/vim-colorscheme-switcher'
  Plug 'romainl/flattened'
  Plug 'morhetz/gruvbox'
  Plug 'joshdick/onedark.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'altercation/vim-colors-solarized'
  Plug 'ajh17/Spacegray.vim'
  Plug 'rafi/awesome-vim-colorschemes'
  Plug 'acarapetis/vim-colors-github'
  Plug 'tomasiser/vim-code-dark'
  Plug 'tomasr/molokai'
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'drewtempelmeyer/palenight.vim'
  Plug 'sonph/onehalf', {'rtp': 'vim/'}
  Plug 'ayu-theme/ayu-vim'
  if has('nvim')
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
  endif

  " IDE like stuffs Project management
  Plug 'scrooloose/nerdcommenter'
  Plug 'scrooloose/nerdtree'
  Plug 'simnalamburt/vim-mundo'
  if has('nvim')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    "Plug 'roxma/nvim-yarp'
    "Plug 'roxma/vim-hug-neovim-rpc'
  endif

  "Easy Navigation"
  Plug 'christoomey/vim-tmux-navigator' 
  Plug 'dbakker/vim-paragraph-motion'
  Plug 'easymotion/vim-easymotion'

call plug#end()

" A syntax for placeholders
let mapleader = ","
let maplocalleader = "-"

set omnifunc=syntaxcomplete#Complete


" Python-mode
let g:pymode_python = 'python3'
let g:pymode_syntax_space_errors = 0

let g:python_highlight_all = 1

let g:python3_host_prog = expand('~/anaconda3/bin/python')

autocmd FileType python setlocal shiftwidth=2 tabstop=2

" Quickly add empty lines
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" Quickly move current line 
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>

" read
" https://github.com/autozimu/LanguageClient-neovim/pull/514#issuecomment-404463033
" for contents of settings.json for vue-language-server
let g:LanguageClient_settingsPath = $WORKSPACE_DIR . '/.vim/settings.json'
let g:LanguageClient_completionPreferTextEdit = 1
autocmd BufNewFile,BufRead *.vue set filetype=vue
autocmd filetype vue LanguageClientStart
"are are are are are are are is 

" the suddennly popup of diagnostics sign is kind of annoying
let g:LanguageClient_diagnosticsSignsMax = 0
" Reload file on saving autocmd BufWritePost ~/.Xdefaults call system('xrdb ~/.Xdefaults')
" Don't lose selection when shifting sidewards xnoremap <  <gv xnoremap >  >gv "
"" for debugging LanguageClient-neovim set noshowmode
" inoremap <silent> <c-q> <esc>:<c-u>q!<cr>
" let g:LanguageClient_loggingFile = '/tmp/lc.log'
" let g:LanguageClient_loggingLevel = 'DEBUG'

" -------General mapping---------------"

" Turn off all over view component except the current buffer
nnoremap <silent> <leader>u :on<CR>
" Open vimrc
nnoremap <leader>rc :e<space>/home/gon/.vimrc<CR>
command! CDC cd %:p:h
" Redirect output of an external program
command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>

" Incsearch pluggin
set hlsearch
let g:incsearch#auto_nohlsearch = 1
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)<Paste>

" map <Leader>f{char} to move to {char}
map  <localleader>f <Plug>(easymotion-bd-f)
nmap <localleader>f <Plug>(easymotion-overwin-f)
"
" s{char}{char} to move to {char}{char}
"nmap s <Plug>(easymotion-overwin-f2)
"
" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
"
" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" Vim-sneak config
nmap s  <Plug>Sneak_s

" Key bindings
nnoremap <leader><leader>ra :%s/\<<C-r><C-w>\>//g<left><left>
nnoremap <leader><leader>rc :%s/\<<C-r><C-w>\>//gc<left><left>
" Repeat the last : command
nnoremap <leader>. @:

"Delete buffer but keep windows
nmap <leader>z :b#<bar>bd#<CR>

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" This is for vim-easyclip:
let g:EasyClipUsePasteToggleDefaults = 0

nmap <Plug> <Plug>G_EasyClipPasteUnformattedAfter
nmap <Plug> <Plug>G_EasyClipPasteUnformattedBefore

nmap <leader>1 <plug>EasyClipSwapPasteForward

" Map add mark to gm
nnoremap gm m

nm <leader>p :se invpaste paste?<CR>

if (has("termguicolors"))
  set termguicolors
endif

" Copy to system clipboard
vnoremap <C-c> "+y

" Nerd Tree 
map <leader>n :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark 
map <leader>nf :NERDTreeFind<cr>

let g:nerdtree_tabs_open_on_gui_startup=1
let g:nerdtree_tabs_open_on_console_startup=1
autocmd VimLeave * NERDTreeClose

" Shortcut for useful commands
map <leader>rl :source %<cr>
map <leader>pi :PlugInstall<cr>

map <leader>mx :!chmod +x &<cr>
map <leader>mw :!chmod +w &<cr>

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

" You Complete Me
if ! has('nvim')
  nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
  nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
  nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
endif

"Pandoc

augroup rmarkdown
  "au BufReadPost *.Rmd set syntax=pandoc
  autocmd FileType rmarkdown setl filetype=pandoc
augroup end

let g:pandoc#command#latex_engine = "pdflatex"

"nnoremap <leader>pdf :Pandoc pdf --wrap=preserve -Vgeometry:margin=1in -Vfontsize=12pt<CR>
nnoremap <leader>pdf :RMarkdown pdf<CR>

" Not auto start instant markdown
let g:instant_markdown_autostart = 0

let g:mkdx#settings     = { 'highlight': { 'enable': 1 },
                        \ 'enter': { 'shift': 1 },
                        \ 'table':                   { 'divider': '|',
                        \                              'header_divider': '-',
                        \                              'align': {
                        \                                 'left':    [],
                        \                                 'center':  [],
                        \                                 'right':   [],
                        \                                 'default': 'center'
                        \                              }
                        \ },
                        \ 'map': { 'ena': 1 },
                        \ 'links': { 'external': { 'enable': 1 } },
                        \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
                        \ 'fold': { 'enable': 1 } }
let g:polyglot_disabled = ['markdown', 'typescript'] " for vim-polyglot users, it loads Plasticboy's markdown
                                       " plugin which unfortunately interferes with mkdx list indentation.

nmap <Plug> <Plug>(mkdx-tableize)
vmap <buffer><silent> \c <Plug>(mkdx-tableize)

"Lime light
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240 
"Eclim
"let g:EclimCompletionMethod = 'omnifunc'

"You Complete Me
let g:ycm_autoclose_preview_window_after_insertion = 1

" Vim setting
set termguicolors
"set background=light
set background=dark
" Favorites color scheme
"colorscheme palenight
"colorscheme materialbox
"colorscheme lightning
"colorscheme one
"colorscheme gruvbox
"colorscheme onehalfdark
colorscheme PaperColor
let g:airline_theme='papercolor'
"let g:airline_theme='gruvbox'

" air-line
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

nnoremap <m-a> :AirlineToggle<Cr>

"let ayucolor="light"  " for light version of theme
"let ayucolor="mirage" " for mirage version of theme
"let ayucolor="dark"   " for dark version of theme
"colorscheme ayu
"hi Normal guibg=NONE ctermbg=NONE
highlight Normal ctermbg=NONE
highlight nonText ctermbg=none
set number
set relativenumber

set tabstop=2 shiftwidth=2 expandtab
"set cursorline
set ignorecase
set smartcase
set ruler
set scrolloff=3
set ai
"set autoindent
"set smartindent

" Paper color theme options
let g:PaperColor_Theme_Options = {
  \   'language': {
  \     'python': {
  \       'highlight_builtins' : 1
  \     },
  \     'cpp': {
  \       'highlight_standard_library': 1
  \     },
  \     'c': {
  \       'highlight_builtins' : 1
  \     }
  \   }
  \ }

"Save file with sudo
cmap w!! w !sudo tee > /dev/null %

"----------------------------COC--------------------------
if has("nvim")
  "" if hidden is not set, TextEdit might fail.
  set hidden

  " Some servers have issues with backup files, see #649
  set nobackup
  set nowritebackup

  " Better display for messages
  set cmdheight=2

  " You will have bad experience for diagnostic messages when it's default 4000.
  set updatetime=300

  " don't give |ins-completion-menu| messages.
  set shortmess+=c

  " always show signcolumns
  set signcolumn=yes

  " Use tab for trigger completion with characters ahead and navigate.
  " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  "Snippets completion"
  " To make completion works like VSCode let g:coc_snippet_next = '<TAB>'
  let g:coc_snippet_prev = '<S-TAB>'

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
  " Coc only does snippet and additional edit on confirm.
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  " Or use `complete_info` if your vim support it, like:
  " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Remap for rename current word
  nmap <leader>rn <Plug>(coc-rename)

  " Remap for format selected region
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  function! s:cocActionsOpenFromSelected(type) abort
    execute 'CocCommand actions.open ' . a:type
  endfunction
  xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
  nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

  " Remap for do codeAction of current line
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Fix autofix problem of current line
  nmap <localleader>f  <Plug>(coc-fix-current)

  " Create mappings for function text object, requires document symbols feature of languageserver.
  xmap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap if <Plug>(coc-funcobj-i)
  omap af <Plug>(coc-funcobj-a)

  " Multicusor support"
  nmap <silent> <C-c> <Plug>(coc-cursors-position)
  nmap <silent> <C-d> <Plug>(coc-cursors-word)
  xmap <silent> <C-d> <Plug>(coc-cursors-range)
  " use normal command like `<leader>xi(`
  nmap <leader>x  <Plug>(coc-cursors-operator)

  " Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
  nmap <silent> <leader>d <Plug>(coc-range-select)
  xmap <silent> <leader>d <Plug>(coc-range-select)

  " Use `:Format` to format current buffer
  command! -nargs=0 Format :call CocAction('format')

  " Use `:Fold` to fold current buffer
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " use `:OR` for organize import of current buffer
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Add status line support, for integration with other plugin, checkout `:h coc-status`
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


  nnoremap <silent> <space><space> :<C-u>CocList<Cr>
  
  " Show all diagnostics
  nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
  " Manage extensions
  nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
  " Show commands
  nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
  " Find symbol of current document
  nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols
  nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list
  nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

  " Ctrl-p functionality
  nnoremap <silent> <c-p>  :<C-u>CocList files<CR>

  nnoremap <silent> <leader>b  :<C-u>CocList --ignore-case buffers<CR>
  nnoremap <silent> <leader>l  :<C-u>CocList -I --ignore-case lines <CR>
  nnoremap <silent> <leader>:  :<C-u>CocList --ignore-case vimcommands<CR>
  nnoremap <silent> <leader>H  :<C-u>CocList --ignore-case mru -A<CR>
  nnoremap <silent> <space>m  :<C-u>CocList --ignore-case maps<CR>
  nnoremap <silent> <m-f>  :<C-u>CocSearch --smart-case 

  vnoremap <leader>/ :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
  nnoremap <space>/ :<C-u>set operatorfunc=<SID>GrepFromSelected<CR>g@

  function! s:GrepFromSelected(type)
    let saved_unnamed_register = @@
    if a:type ==# 'v'
      normal! `<v`>y
    elseif a:type ==# 'char'
      normal! `[v`]y
    else
      return
    endif
    let word = substitute(@@, '\n$', '', 'g')
    let word = escape(word, '| ')
    let @@ = saved_unnamed_register
    execute 'CocList grep '.word
  endfunction

  nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

  nnoremap <silent> <space>f  :<C-u>CocFix<cr>
endif

"----Color-coloumn-----------
set colorcolumn=101

"-----Mouse support ----------
set mouse=a

"-------PENCIL---------------"
let g:pencil#textwidth = 100

"------Ditto-----------------"
au FileType markdown,text,tex DittoOn  " Turn on Ditto's autocmds

"-----GOYO-----------------"

let g:goyo_width = 100
let g:goyo_height = "93%"

"----UNDOTREE------"
set undofile
set undodir=~/.vim/undo

" If you don't want the autocmds, you can also use an operator to check
" specific parts of your text:
" vmap <leader>d <Plug>Ditto	       " Call Ditto on visual selection
" nmap <leader>d <Plug>Ditto	       " Call Ditto on operator movement

"----------FZF---------"
let g:fzf_nvim_statusline = 0 " disable statusline overwriting

nnoremap <silent> <leader>/ :execute 'Rg ' . input('Rg/')<CR>
"nnoremap <silent> <F1> :FZF<CR>
nnoremap <silent> <c-p> :FZF<CR>
nnoremap <silent> <localleader>w :FZF ~/vimwiki/text<CR>
nnoremap <silent> <leader>t :BTags<CR>
nnoremap <silent> <leader>T :Tags<CR>
nnoremap <silent> <leader>; :History:<CR>

"Save session"
nnoremap <m-s> :SaveSession
nnoremap <m-o> :OpenSession
nnoremap <c-s> :w<CR>

let g:session_autosave="yes"
let g:session_autoload="no"

"Move in location list and quickfix list"
nnoremap <m-j> :lnext<CR>
nnoremap <m-k> :lprevious<CR>

" ALE
let g:ale_virtualenv_dir_names = get(g:, 'ale_virtualenv_dir_names', ['./anaconda3/envs/ML', './anaconda3'])

" Shortcut to exit terminal mode
tnoremap <m-c> <C-\><C-n>
tnoremap <c-j> <C-\><C-n><C-w>j
tnoremap <c-k> <C-\><C-n><C-w>k
tnoremap <c-h> <C-\><C-n><C-w>h
tnoremap <c-l> <C-\><C-n><C-w>l

nnoremap <F2> :Buffers<CR>

" Subversive
let g:subversivePromptWithCurrent=1

nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(subversiveSubstituteToEndOfLine)

nmap <leader>s <plug>(SubversiveSubstituteRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)
nmap <leader>ss <plug>(SubversiveSubstituteWordRange)

nmap <leader><leader>s <plug>(SubversiveSubvertRange)
xmap <leader><leader>s <plug>(SubversiveSubvertRange)
nmap <leader><leader>ss <plug>(SubversiveSubvertWordRange)

" Extra motion
" ie = inner entire buffer
onoremap ie :exec "normal! ggVG"<cr>
" iv = current viewable text in the buffer
onoremap iv :exec "normal! HVL"<cr>

" Yoink
nmap <m-[> <plug>(YoinkPostPasteSwapBack)
nmap <m-]> <plug>(YoinkPostPasteSwapForward)

nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)
nmap [y <plug>(YoinkRotateBack)
nmap ]y <plug>(YoinkRotateForward)
let g:yoinkIncludeDeleteOperations=1

" Vim Cutlass
nnoremap m d
xnoremap m d

nnoremap mm dd
nnoremap M D

" Calendar.vim

" Open day view to the right buffer
nnoremap <m-c> :CalendarH<CR>
nnoremap <m-d> :Calendar<space>-day<space>-position=right<space>-width=80<CR>
nnoremap <m-y> :Calendar<space>-year<CR>

" Tagbar
nmap <F5> :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_expand = 1


" Vim wiki
"let g:vimwiki_list = [{'path': '~/vimwiki/',
                      "\ 'syntax': 'markdown', 'ext': '.md'}]

let g:tagbar_type_vimwiki = {
          \   'ctagstype':'vimwiki'
          \ , 'kinds':['h:header']
          \ , 'sro':'&&&'
          \ , 'kind2scope':{'h':'header'}
          \ , 'sort':0
          \ , 'ctagsbin':'~/.vim/vwtags.py'
          \ , 'ctagsargs': 'default'
          \ }

command! Diary VimwikiDiaryIndex
augroup vimwikigroup
    autocmd!
    " automatically update links on read diary
    autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
augroup end


let wiki = {}
let wiki.path = '~/vimwiki/text'
let wiki.path_html = '~/vimwiki/html'
let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}
"let wiki.auto_export = 1
let wiki.template_path = '~/vimwiki/templates'
let wiki.template_default = 'def_template'
let wiki.template_ext = '.html'

let g:vimwiki_list = [wiki]
let g:vimwiki_table_mappings=0
let g:vimwiki_hl_cb_checked=2
let g:vimwiki_folding = 'expr'

nnoremap <m-v> :Vimwiki

" Open image with feh
"nnoremap gx :!feh <cfile> &<CR>
let g:vimwiki_use_mouse=1
let g:vimwiki_hl_headers=1

" Javascript
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"
let g:javascript_conceal_noarg_arrow_function = "🞅"
let g:javascript_conceal_underscore_arrow_function = "🞅"

"Auto indent
let g:AutoPairsShortcutToggle = '<m-p>'
let g:AutoPairsShortcutBackInsert = '<c-b>'
let g:AutoPairsFlyMode = 0

"Jupytext.vim
let g:jupytext_filetype_map = {'md': 'pandoc'}

" End file"
