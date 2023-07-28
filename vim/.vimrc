" =========================================================================== "
" General Configuration "
" =========================================================================== "

" Ensure we don't use compatibility mode
set nocompatible                
" Sets the width of a TAB character's visual appearance
set tabstop=4
" Sets the number of spaces used for indentation levels
set shiftwidth=4                
" Display line numbers on the left hand side
set number                      
" Enable syntax highlighting
syn on                          
" Display which line the cursor currently resides on
set cursorline                  
" Display line and column numbers at the bottom right of the screen
set ruler                       
" Always show the status bar
set laststatus=2                
" Always show the current command
set showcmd                     
" Enable visual autocomplete for command menu
set wildmenu                    
" Ignore compiled files
set wildignore=*.o,*~,*.pyc     
" Don't create swap files
set noswapfile                  
" Automatically change to the same directory as the file
set autochdir                   
" Display tabs with arrows, and spaces with middle dots
set listchars=tab:>-,space:·
" Don't wrap lines
set nowrap                      
" Always show 10 lines above/below cursor when available
set scrolloff=10                
" Always show 20 characters to the right or left of cursor
set sidescrolloff=20            
" Search as you type
set incsearch                   
" Enable 256 colour mode
set t_Co=256
" Enable indentation based on languages
filetype plugin indent on              
" Create a column marker for 80 and 100 characters
set colorcolumn=80,100
" Suppresses ATTENTION, TAG, and TUTORIAL messages
set shortmess=atT
" Update the runtime path to include Vundle
set rtp+=~/.vim/bundle/Vundle.vim

" =========================================================================== "
" Plugin Configuration "
" =========================================================================== "

call vundle#begin()

" Vundle plug-in manager 
Plugin 'gmarik/Vundle.vim'

" EasyMotion
Plugin 'Lokaltog/vim-easymotion'

" Airline status bar
Plugin 'bling/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 0

" Airline themes
Plugin 'vim-airline/vim-airline-themes'
let g:airline_theme = 'wombat'

" Indent Guides
Plugin 'nathanaelkane/vim-indent-guides'
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size  = 1
autocmd BufReadPre,FileReadPre * :IndentGuidesEnable 
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=238
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=240

call vundle#end()            

" =========================================================================== "
" Key Bindings             "
" =========================================================================== "

command WQ wq                   " Because vim is pedantic.
command Wq wq                   " You know what I mean, vim :(
command W w
command Q q

" =========================================================================== "
" Language Specific        "
" =========================================================================== "

" Python
autocmd Filetype python setlocal list!

" =========================================================================== "
" Colour Groups            "
" =========================================================================== "

" Set the colour of the column market to a light grey
highlight ColorColumn ctermbg=240 guibg=lightgray
" Set the foreground color of line numbers to Yellow
highlight LineNr ctermfg=Yellow
" Set the foreground color of the current line number to White
highlight CursorLineNr ctermfg=White
" Set the foreground color of statements to Yellow
highlight Statement ctermfg=Yellow
" Set the background color of folded lines to light grey and foreground color to 251
highlight Folded ctermbg=240 ctermfg=251
