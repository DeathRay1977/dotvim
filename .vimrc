call pathogen#infect() 
:colors desert
:set hlsearch
if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=100 columns=132
else
  " This is console Vim.
  if exists("+lines")
    set lines=30
  endif
  if exists("+columns")
    set columns=80
  endif
endif
