set nocompatible
set tabstop=4
set softtabstop=4
set shiftwidth=4
set nu
syn on
set cursorline
set ruler
set laststatus=2

if has("gui_macvim")
	:set background=dark
	colorscheme solarized
	set go-=T
	call pathogen#infect()
endif

