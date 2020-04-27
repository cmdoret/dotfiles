
" Set default directory tu use XDG paths to keep $HOME clean
set undodir=$XDG_DATA_HOME/vim/undo
set directory=$XDG_DATA_HOME/vim/swap
set backupdir=$XDG_DATA_HOME/vim/backup
set viewdir=$XDG_DATA_HOME/vim/view
set viminfo+='1000,n$XDG_DATA_HOME/vim/viminfo
set runtimepath=$XDG_CONFIG_HOME/vim,$VIMRUNTIME,$XDG_CONFIG_HOME/vim/after
" ############
" # PACKAGES #
" ############

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'vim-syntastic/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'fatigh/vim-go', {'do': ':GoUpdateBinaries' }
" packages configuration
map <C-n> :NERDTreeToggle<CR> " File navigator
let g:airline_theme='raven' " colored status bar
let g:airline_powerline_fonts = 1
" Use gopls language server as backend for vim-go (gopls must be installed)
let g:go_def_modes='gopls'
let g:go_info_mode='gopls'
" syntastic styling
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_enable_highlighting=1
let g:syntastic_enable_signs=1
" Syntastic signs

let g:syntastic_error_symbol = "E>"
let g:syntastic_warning_symbol = "W>"


" Syntastic lines
highlight SyntasticErrorLine guibg=#3A0505
" syntastic linters settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_html_checkers = ['htmlhint']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_javascript_checkers = ['jslint']
let g:syntastic_r_checkers = ['lintr']
" toggle syntastic location list
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END
map <F8> <ESC>:call SyntasticToggle()<CR>

let g:syntastic_is_open = 0  
function! SyntasticToggle()
if g:syntastic_is_open == 1
    lclose
    let g:syntastic_is_open = 0 
else
    Errors
    let g:syntastic_is_open = 1 
endif
endfunction
" ####################
" # EDITOR BEHAVIOUR #
" ####################

" syntax highlightin gin Snakefiles
au BufNewFile,BufRead Snakefile set syntax=snakemake
au BufNewFile,BufRead *.smk set syntax=snakemake

" toggle absolut/hybrid line numbers between i and n modes
set number " show line numbers
set relativenumber

" clipboard
set clipboard=unnamedplus " Shares OS and vim clipboard

" tab indentation behaviour
set tabstop=4 " tabs show as space
set softtabstop=4 " add spaces instead of tab when editing
set shiftwidth=4
set expandtab " tab becomes spaces

" fold behaviour
set foldenable " allows to use code folding
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " maximum 10 nested folds
nnoremap <space> za " space open/close folds
set foldmethod=indent " fold  based on indentation
" Filetype specific indenting behaviour
filetype on
filetype plugin on
filetype indent on " file type based indentation
autocmd FileType make set noexpandtab shiftwidth=4 softtabstop=0 " real tabs in makefile
" autocmd FileType html,xhtml,css,xml,xslt set shiftwidth=2 softtabstop=2 " fixed indentation for web
autocmd FileType vim,lua,nginx set shiftwidth=2 softtabstop=2 " two space indentation for some files
autocmd FileType css set omnifunc=csscomplete#CompleteCSS " auto-indent braces in CSS
" autocmd FileType xhtml,html set omnifunc=htmlcomplete#CompleteTags " add completion for xHTML

" performance
set lazyredraw " do not redraw screen during macros. makes vim slightly faster
set synmaxcol=128 " limiting syntax highlighting to 128 columns can make vim faster



" mouse
set mouse=a

" #############
" # GRAPHICAL #
" #############

" text/bg colors
set t_Co=256
syntax on " enable syntax highlighting
colorscheme xoria256
" http://vim.wikia.com/wiki/Fix_syntax_highlighting
syntax sync minlines=500
hi Normal ctermbg=None 
hi LineNr ctermbg=0
" hi CursorLine ctermbg=236
highlight SignColumn guibg=None ctermbg=None
highlight CursorLineNR ctermfg=0 ctermbg=blue
" command menu/bar
set showcmd " show last command used in bottom bar
set wildmenu " visual autocomplete menu

" highlighting
" set cursorline " highlight current line in file
set showmatch " highlight matching ({[]})
set incsearch " Show where the next pattern is as you type it:
set hlsearch " Highlight the last searched pattern:
" hi Search cterm=None ctermbg=4 
" Making colors of syntactic errors/warnings less intrusive
hi Todo ctermbg=None ctermfg=yellow
hi Error ctermbg=none ctermfg=red
hi SpellBad ctermbg=None ctermfg=red
hi SpellCap ctermbg=None ctermfg=yellow
hi SyntasticErrorSign ctermbg=None ctermfg=red
hi SyntasticWarningSign ctermbg=None ctermfg=yellow
hi SyntasticStyleErrorSign ctermbg=None ctermfg=yellow
hi SyntasticStyleWarningSign ctermbg=None ctermfg=yellow
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

