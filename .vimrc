" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"
" Initialise pathogen and load all plugins
"
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set encoding=utf8
set rnu
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


function! g:Fixfont()
  set guifont=Courier\ 10\ Pitch\ 10
  set lines=44 columns=80
endif
endfunction

function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
let g:slime_target = "tmux"
let g:ruby_debugger_progname = 'mvim'
let g:formatprg_cpp = "astyle"
let g:formatprg_args_expr_cpp = '"--unpad-paren --style=whitesmith --pad-paren-in --indent-brackets"'
let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \   'separately': {
    \       '*': {},
    \       'rb' : {},
    \       'tex': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \       },
    \       'lisp': {
    \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \       },
    \       'vim': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \       },
    \       'html': {
    \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
    \       },
    \       'css': 0,
    \   }
    \}
let g:rainbow_active = 1
" Set <leader> to comma

let mapleader=","

" Mappings
" Rspec  mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
let g:rspec_command = "!rspec --drb {spec}"
let g:rspec_runner = "os_x_iterm2"

" Normal Mode mappings
noremap <leader>> :bn<CR>
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>
" Disable Arrow Keys"
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

nnoremap <leader>R :RainbowParenthesesToggle<CR>
nnoremap <silent> <Plug>TransposeCharacters xp :call repeat#set("\<Plug>TransposeCharacters")<CR>
nmap cp <Plug>TransposeCharacters

" Shortcut to rapidly toggle `set list`
nnoremap <leader>l :set list!<CR>
nnoremap <leader>af :Autoformat<cr>
" Since these all have native (Cmd-modified) versions in MacVim, don't bother
" defining them there.

" A utility function to help cover our bases when mapping.
"
" Example of use:
"   call NvicoMapMeta('n', ':new<CR>', 1)
" is equivalent to:
"   exec "set <M-n>=\<Esc>n"
"   nnoremap <special> <Esc>n :new<CR>
"   vnoremap <special> <Esc>n <Esc><Esc>ngv
"   inoremap <special> <Esc>n <C-o><Esc>n
"   cnoremap <special> <Esc>n <C-c><Esc>n
"   onoremap <special> <Esc>n <Esc><Esc>n
function! NvicoMapMeta(key, cmd, add_gv)
    " TODO: Make this detect whether key is something that has a Meta
    " equivalent.
    let l:keycode = "<M-" . a:key . ">"

    let l:set_line = "set " . l:keycode . "=\<Esc>" . a:key

    let l:nmap_line = 'nmap <silent> <special> ' . l:keycode . ' ' . a:cmd
    let l:vnoremap_line = 'vnoremap <silent> <special> ' . l:keycode . ' <Esc>' . l:keycode
    if(a:add_gv)
        let l:vnoremap_line.='gv'
    endif
    let l:inoremap_line = 'inoremap <silent> <special> ' . l:keycode . ' <C-o>' . l:keycode
    let l:cnoremap_line = 'cnoremap <special> ' . l:keycode . ' <C-c>' . l:keycode
    let l:onoremap_line = 'onoremap <silent> <special> ' . l:keycode . ' <Esc>' . l:keycode

    exec l:set_line
    exec l:nmap_line
    exec l:vnoremap_line
    exec l:inoremap_line
    exec l:cnoremap_line
    exec l:onoremap_line
endfunction

" I can't think of a good function to assign to Meta+n, since in MacVim Cmd+N
" opens a whole new editing session.

" Meta+Shift+N
" No equivalent to this in standard MacVim. Here " it just opens a window on a
" new buffer.
call NvicoMapMeta('N', ':new<CR>', 1)

" Meta+o
" Open netrw file browser
call NvicoMapMeta('o', ':split %:p:h<CR>', 1)

" Meta+w
" Close window
call NvicoMapMeta('w', ':confirm close<CR>', 1)

" Meta+s
" Save buffer
call NvicoMapMeta('s', ':confirm w<CR>', 1)

" Meta+Shift+S
" Save as
" TODO: This is silent, so you can't tell it's waiting for input. If anyone can
" fix this, please do!
call NvicoMapMeta('S', ':confirm saveas ', 1)

" Meta+z
" Undo
call NvicoMapMeta('z', 'u', 1)

" Meta+Shift+Z
" Redo
call NvicoMapMeta('Z', '<C-r>', 1)

" Meta+x
" Cut to system clipboard (requires register +")
exec "set <M-x>=\<Esc>x"
vnoremap <special> <M-x> "+x

" Meta+c
" Copy to system clipboard (requires register +")
exec "set <M-c>=\<Esc>c"
vnoremap <special> <M-c> "+y

" Meta+v
" Paste from system clipboard (requires register +")
exec "set <M-v>=\<Esc>v"
nnoremap <silent> <special> <M-v> "+gP
cnoremap <special> <M-v> <C-r>+
execute 'vnoremap <silent> <script> <special> <M-v>' paste#paste_cmd['v']
execute 'inoremap <silent> <script> <special> <M-v>' paste#paste_cmd['i']

" Meta+a
" Select all
call NvicoMapMeta('a', ':if &slm != ""<Bar>exe ":norm gggH<C-o>G"<Bar> else<Bar>exe ":norm ggVG"<Bar>endif<CR>', 0)

" Meta+f
" Find regexp. NOTE: MacVim's Cmd+f does a non-regexp search.
call NvicoMapMeta('f', '/', 0)

" Meta+g
" Find again
call NvicoMapMeta('g', 'n', 0)

" Meta+Shift+G
" Find again, reverse direction
call NvicoMapMeta('G', 'N', 0)

" Meta+q
" Quit Vim
" Not quite identical to MacVim default (which is actually coded in the app
" itself rather than in macmap.vim)
call NvicoMapMeta('q', ':confirm qa<CR>', 0)

" Meta+Shift+{
" Switch tab left
call NvicoMapMeta('{', ':tabN<CR>', 0)

" Meta+Shift+}
" Switch tab right
call NvicoMapMeta('}', ':tabn<CR>', 0)

" Meta+t
" Create new tab
call NvicoMapMeta('t', ':tabnew<CR>', 0)

" Meta+Shift+T
" Open netrw file browser in new tab
call NvicoMapMeta('T', ':tab split %:p:h<CR>', 0)

" Meta+b
" Call :make
call NvicoMapMeta('b', ':make<CR>', 1)

" Meta+l
" Open error list
call NvicoMapMeta('l', ':cl<CR>', 1)

" TODO: We need to configure iTerm2 to be able to send Cmd+Ctrl+arrow keys, so
" we can duplicate the :cnext/:cprevious/:colder/:cnewer bindings to those keys
" in MacVim.
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" colours

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  colorscheme desert
  let os = substitute(system('uname'), "\n", "", "")
  if os == "Linux"
    call g:Fixfont()
  endif
endif
" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  autocmd filetype lisp,scheme,art setlocal equalprg=scmindent.rkt
  au BufRead,BufNewFile *.rex set filetype=ruby
  filetype plugin indent on
  runtime macros/matchit.vim
  autocmd BufWritePre *.rb,*.erb,*.js :call <SID>StripTrailingWhitespaces()
  autocmd FileType ruby nmap <buffer> <D-M> <Plug>(xmpfilter-mark)
  autocmd FileType ruby xmap <buffer> <D-M> <Plug>(xmpfilter-mark)
  autocmd FileType ruby imap <buffer> <D-M> <Plug>(xmpfilter-mark)

  autocmd FileType ruby nmap <buffer> <D-R> <Plug>(xmpfilter-run)
  autocmd FileType ruby xmap <buffer> <D-R> <Plug>(xmpfilter-run)
  autocmd FileType ruby imap <buffer> <D-R> <Plug>(xmpfilter-run)
  autocmd! bufwritepost .vimrc source $MYVIMRC

  autocmd VimResized * :wincmd =
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

highlight Pmenu guibg=brown gui=bold

