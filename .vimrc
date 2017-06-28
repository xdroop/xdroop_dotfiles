" Dave's .vimrc
"  History:
"   020522 - updated with comments
"   091001 - added status line
"
" our shell for running things
set shell=/bin/bash
" set the visual bell to nothing to silence the beeping
set vb t_vb=
" this usually saves more trouble than it causes...
set ai
" Wrap Margin -- we handle our own wrapping thank you sir
set wm=0
" dunno
set redraw
" match bracket pairs
set sm
" Expand 'tab' chars into the right number of spaces
set expandtab
" ...except when editing Makefiles :)
au BufNewFile ?akefile* set noexpandtab
au BufRead ?akefile* set noexpandtab
" This is the right number of spaces
set tabstop=4
" shift width -- for > and < operations
set sw=4
" THis is unix -- pay attention!
set noignorecase
" This is unix -- pay attention!
set nobackup
" Turn on syntax rules if we recognize what is going on
syntax on
" Easier colorsscheme to read:
colorscheme evening
" Alias set to wrap text 
map I okJ070lF r
map I J070lF r
" Status Line
"set statusline=%t%h%m%r%=[%b\ 0x%02B]\ \ \ %l,%c%V\ %P
set statusline=%t%h%m%r%=%l,%c%V\ %P
" Always show a status line
set laststatus=2
"make the command line 1 line high
set cmdheight=1
set ruler
" lame-assed html macros follow
ab #b <b></b>
ab #i <i></i>
ab #u <ul></ul>
ab #o <ol></ol>
ab #l <li>
ab #s <p>* * *<p>