" Note: Better in NeoVim: For some reason, regular vim has a ~2s delay when toggling 
" absolute and relative line numbers. This does not happen in Neovim.

" ############
" # PACKAGES #
" ############

" package manager
execute pathogen#infect()

" packages configuration
map <C-n> :NERDTreeToggle<CR> " File navigator
let g:airline_theme='deus' " colored status bar

" ####################
" # EDITOR BEHAVIOUR #
" ####################

" toggle absolut/hybrid line numbers between i and n modes
set number " show line numbers
set relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" clipboard
set clipboard=unnamedplus " Shares OS and vim clipboard

" tab indentation behaviour
set tabstop=4 " tabs show as space
set softtabstop=4 " add spaces instead of tab when editing
set expandtab " tab becomes spaces
filetype indent on " file type specific indent

" fold behaviour
set foldenable " allows to use code folding
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " maximum 10 nested folds
nnoremap <space> za " space open/close folds
set foldmethod=indent " fold  based on indentation

" performance
set lazyredraw " do not redraw screen during macros. makes vim slightly faster
set synmaxcol=128 " limiting syntax highlighting to 128 columns can make vim faster


" mouse
set mouse=a

" #############
" # GRAPHICAL #
" #############

" text/bg colors
syntax on " enable syntax highlighting
colorscheme monokai-soda
" http://vim.wikia.com/wiki/Fix_syntax_highlighting
syntax sync minlines=200
hi Normal ctermbg=None 
hi LineNr ctermfg=None ctermbg=None

" command menu/bar
set showcmd " show last command used in bottom bar
set wildmenu " visual autocomplete menu

" highlighting
set cursorline " highlight current line in file
set showmatch " highlight matching ({[]})
set incsearch " Show where the next pattern is as you type it:
set hlsearch " Highlight the last searched pattern:

" #########################
" # PROGRAMMING UTILITIES #
" #########################

" run python script
nnoremap <buffer> <F10> :w<cr> :exec '!python3' shellescape(@%, 1)<cr>

" render markdown into firefox (Linux only)
" Open tab (note F17 is the literal for shift+F5)
map <F17> :w!<CR>:w!/home/varogh/tmp/vim-markdown.md<CR>:!pandoc -s -f markdown -t html5 --css=/home/varogh/.local/share/markdown-css/github.css --highlight-style=haddock --self-contained --smart -o /home/varogh/tmp/vim-markdown.html /home/varogh/tmp/vim-markdown.md<CR>:!firefox /home/varogh/tmp/vim-markdown.html > /dev/null 2>&1 &<CR><CR>
" reload tab
map <F5> :w!<CR>:w!/home/varogh/tmp/vim-markdown.md<CR>:!pandoc -s -f markdown -t html5 --css=/home/varogh/.local/share/markdown-css/github.css --highlight-style=haddock --self-contained --smart -o /home/varogh/tmp/vim-markdown.html /home/varogh/tmp/vim-markdown.md<CR>:!xdotool search --name "Mozilla Firefox" key --clearmodifiers "CTRL+R" & <CR><CR>

" ##################
" # MISC SHORTCUTS #
" ##################

let mapleader="," " leader is comma
let maplocalleader=";"
" #######################
" # NOT NVIM-COMPATIBLE #
" #######################

" set ttymouse=xterm2

" Graphical stuff

