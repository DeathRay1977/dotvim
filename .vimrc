" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"
" Initialise pathogen and load all plugins
"
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
set number
set backspace=indent,eol,start
set backup     " keep a backup file
set history=50 " keep 50 lines of command line history
set ruler      " show the cursor position all the time
set showcmd    " display incomplete commands
set incsearch  " do incremental searching
set hidden
set laststatus=2
set expandtab
set ts=2 
set sts=2 
set sw=2 
set expandtab 
set textwidth=78

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
	set mouse=a
endif

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

let g:formatprg_cpp = "astyle"
let g:formatprg_args_expr_cpp = '"--unpad-paren --style=whitesmith --pad-paren-in --indent-brackets"'
"
" Set <leader> to comma

let mapleader=","

" Mappings

" Normal Mode mappings

noremap <leader>b :FufBuffer<CR>
noremap <leader>f :FufFile<CR>

" Disable Arrow Keys"
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop> 

" Shortcut to rapidly toggle `set list`
nnoremap <leader>l :set list!<CR>

" Ctrl+s to save
nnoremap <C-s> :w<cr>

" Ctrl+q to quit, hold shift to discard changes
nnoremap <C-q> :q<cr>
nnoremap <C-S-q> :q!<cr>

imap <C-S-q> <ESC>:q!<cr>
imap <C-q> <ESC>:q<cr>
imap <C-s> <ESC>:w<cr>a

" colours
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
	colorscheme desert
endif
" Only do this part when compiled with support for autocommands.
if has("autocmd")

	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on


	autocmd! bufwritepost .vimrc source $MYVIMRC

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	" (happens when dropping a file on gvim).
	" Also don't do it when the mark is in the first line, that is the default
	" position when opening a file.
	autocmd BufReadPost *
				\ if line("'\"") > 1 && line("'\"") <= line("$") |
				\   exe "normal! g`\"" |
				\ endif
else

	set autoindent      " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif
highlight Pmenu guibg=brown gui=bold


