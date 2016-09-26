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
"Plugin 'kchmck/vim-coffee-script'

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
let g:airline#extensions#whitespace#enabled = 0
let g:airline_section_z = '%t'

" Airline themes
Plugin 'vim-airline/vim-airline-themes'

" Fugitive git enhancements
Plugin 'tpope/vim-fugitive'

" Tagbar class outline viewer
Plugin 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

" CoffeeTags
Plugin 'lukaszkorecki/CoffeeTags'

" CSS for Tagbar
Plugin 'mtscout6/vim-tagbar-css'

" NERD Commenter
Plugin 'scrooloose/nerdcommenter'

" Indent Guides
Plugin 'nathanaelkane/vim-indent-guides'
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size  = 1

" EasyMotion
Plugin 'Lokaltog/vim-easymotion'

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
set listchars=tab:>-            " Display tabs with arrows.
set nowrap                      " Don't wrap lines.
set scrolloff=10                " Always show 10 lines above/below cursor when available.
set sidescrolloff=20            " Always show 20 characters to the right or left of cursor.
set incsearch                   " Search as you type.
set t_Co=256                    " Enable 256 colour mode
filetype indent on              " Enable indentation based on languages.

""""""""""""""""""""""""""""
" Autoexec                 "
""""""""""""""""""""""""""""
autocmd BufReadPre,FileReadPre * :IndentGuidesEnable 

""""""""""""""""""""""""""""
" Key Bindings             "
""""""""""""""""""""""""""""
command WQ wq                   " Because vim is pedantic.
command Wq wq                   " You know what I mean, vim :(
command W w
command Q q
let mapleader=","

""""""""""""""""""""""""""""
" Language Specific        "
""""""""""""""""""""""""""""

" CoffeeScript
autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
autocmd Filetype coffee setlocal tabstop=2
autocmd Filetype coffee setlocal softtabstop=2
autocmd Filetype coffee setlocal shiftwidth=2

" Jade
autocmd Filetype jade setlocal tabstop=2
autocmd Filetype jade setlocal softtabstop=2
autocmd Filetype jade setlocal shiftwidth=2     

" LESS
autocmd Filetype less setlocal tabstop=2
autocmd Filetype less setlocal softtabstop=2
autocmd Filetype less setlocal shiftwidth=2     

" YAML
autocmd Filetype yaml setlocal tabstop=2
autocmd Filetype yaml setlocal softtabstop=2
autocmd Filetype yaml setlocal shiftwidth=2     


" Python
autocmd Filetype python setlocal list!            " Display tabs clearly in Python

""""""""""""""""""""""""""""
" Colour Groups            "
""""""""""""""""""""""""""""
colorscheme default
highlight LineNr ctermfg=Yellow
highlight CursorLineNr ctermfg=White
highlight Statement ctermfg=Yellow
highlight Folded ctermbg=240 ctermfg=251
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=238
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=240

""""""""""""""""""""""""""""
" MacVim Configuration
""""""""""""""""""""""""""""
if has("gui_macvim")
    set background=dark
    colorscheme solarized
    set go-=T
endif

