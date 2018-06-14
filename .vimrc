execute pathogen#infect()

syntax on " enable syntax highlighting
colorscheme monokai-soda

set tabstop=4 " tabs show as space
set softtabstop=4 " add spaces instead of tab when editing
set expandtab " tab becomes spaces

set number " show line numbers
set showcmd " show last command used in bottom bar
set cursorline " highlight current line in file
filetype indent on " file type specific indent
set wildmenu " visual autocomplete menu

set showmatch " highlight matching ({[]})
set incsearch
set hlsearch

set foldenable " allows to use code folding
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " maximum 10 nested folds
nnoremap <space> za " space open/close folds
set foldmethod=indent " fold  based on indentation

let mapleader=";" " leader is comma
let maplocalleader=","

map <C-n> :NERDTreeToggle<CR>
set mouse=a
set ttymouse=xterm2

" Highlight the last searched pattern:
set hlsearch

" Show where the next pattern is as you type it:
set incsearch

" vim and R

" Use Ctrl+Space to do omnicompletion:
set omnifunc=syntaxcomplete#Complete
if has("gui_running")
    inoremap <C-Space> <C-x><C-o>
else
    inoremap <Nul> <C-x><C-o>
endif

" Press the space bar to send lines and selection to R:
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

" Graphical stuff
hi Normal ctermbg=None 
hi LineNr ctermfg=None ctermbg=None
let g:airline_theme='deus'
set clipboard=unnamedplus
