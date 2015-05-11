""""""""""""""""""""""""""""
" Vundle Plugin Manager    "
""""""""""""""""""""""""""""
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" Vundle plug-in manager 
Plugin 'gmarik/Vundle.vim'

" Coffeescript syntax highlighting
Plugin 'kchmck/vim-coffee-script'

" LESS syntax highlighting
Plugin 'groenewege/vim-less'

" Jade syntax highlighting
Plugin 'digitaltoad/vim-jade'

" NERDTree file browser
Plugin 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR>

" Airline status bar
Plugin 'bling/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline_theme='wombat'

" Fugitive git enhancements
Plugin 'tpope/vim-fugitive'

call vundle#end()            

filetype plugin indent on

""""""""""""""""""""""""""""
" Generic Configuration    "
""""""""""""""""""""""""""""
set nocompatible                " Apparently does nothing when in a .vimrc but just in case!
set expandtab                   " Pressing TAB will insert four spaces instead of a TAB.
set tabstop=4                   " How many spaces a TAB will appear to be
set softtabstop=4               " How many spaces a TAB will be when editing.
set shiftwidth=4                " How many spaces are used for indentation.
set number                      " Display line numbers on the left hand side.
syn on                          " Enable syntax highlighting.
set cursorline                  " Display which line the cursor currently resides on.
set ruler                       " Display line and column numbers at the bottom right of the screen.
set laststatus=2                " Always show the status bar.
set showcmd                     " Always show the current command.
set wildmenu                    " Enable visual autocomplete for command menu.
set wildignore=*.o,*~,*.pyc     " Ignore compiled files.
set noswapfile                  " Don't create swap files.
set autochdir                   " Automatically change to the same directory as the file.
"set list!                      " Toggle list.
set listchars=tab:>-            " Display tabs with arrows.
set nowrap                      " Don't wrap lines.
set t_Co=256                    " Enable 256 colour mode
filetype indent on              " Enable indentation based on languages.

""""""""""""""""""""""""""""
" Key Bindings             "
""""""""""""""""""""""""""""
command WQ wq                   " Because vim is pedantic.
command Wq wq                   " You know what I mean, vim :(
command W w
command Q q

""""""""""""""""""""""""""""
" Colour Groups            "
""""""""""""""""""""""""""""
highlight LineNr ctermfg=Yellow
highlight CursorLineNr ctermfg=White
highlight Statement ctermfg=Yellow

""""""""""""""""""""""""""""
" MacVim Configuration
""""""""""""""""""""""""""""
if has("gui_macvim")
    set background=dark
    colorscheme solarized
    set go-=T
    call pathogen#infect()
endif

