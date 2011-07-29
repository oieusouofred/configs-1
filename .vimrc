" Plugins installed:
" Pathogen!
" Surround (cs"' to repla"ce " with '
" Command-T
" Gundo
" Repeat (lets plugins access . for repeat)
" NERDCommenter
" Fugitive
" Matchit (Match more than (, [, etc with %)
" Unimpared
" Matrix
" snipMate
" MRU (most recently used files)
" Bufexplorer
" Ack.vim
" NerdTree

set nocompatible

" Pathogen loading
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles() 
filetype plugin indent on

" change the mapleader from \ to ,
let mapleader=","

" lets you do w!! to sudo write the file
cmap w!! w !sudo tee % >/dev/null

" experimental: remap ; to :
" nnoremap ; :

" Custom file type syntax highlighting
au BufRead, BufNewFile *.tal setfiletype html
au BufRead, BufNewFile *.djhtml setfiletype html
au BufRead,BufNewFile .bash_config set ft=sh syntax=sh

" Source vim when this file is updated (although it doesn't work since it thinks we're in cygwin, dammit)
nmap <Leader>s :source $MYVIMRC<cr>
nmap <Leader>v :tabe $MYVIMRC<cr>
nmap <Leader>h :tabe /etc/hosts<cr>

" NerdTree
nmap <Leader>nt :NERDTreeToggle<cr>

" Change to working directory of current file and echo new location
nmap cd :cd %:h<cr>:pwd<cr>

" Surround mappings, switch " and ' with c
nmap c' cs'"
nmap c" cs"'

" Swap two parameters in a function
nmap <Leader>- lF(ldWf)i, pF,dt)

" MRU mappings, open most recent files list
nmap <Leader>ml :MRU<cr>
" Opens mru which lets files autocomplete
nmap <Leader>me :MRU 

" Don't want no lousy .swp files in my directoriez
set backupdir=~

" hide buffers instead of closing, can do :e on an unsaved buffer
set hidden

" wildignore all of these when autocompleting
set wig=*.swp,*.bak,*.pyc,*.class,node_modules*

" shiftround, always snap to multiples of shiftwidth when using > and <
set sr

nnoremap <LocalLeader>t :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Command-T file finder
nnoremap <silent> <Leader>t :CommandT<cr>
let g:CommandTAcceptSelectionMap = '<C-o>'
let g:CommandTAcceptSelectionTabMap = '<CR>'

" Gundo tree viewer
nnoremap <Leader>u :GundoToggle<CR>

" Insert item at end of list
nmap <LocalLeader>i [{%kA,<Esc>o

" Clear search highlighting so you don't have to search for /asdfasdf
nmap <silent> <Leader>/ :nohlsearch<CR>

" Jump backwards to previous function, assumes code is indented (useful when inside function)
" Jump to top level function
nmap <Leader>f ?^func\\|^[a-zA-Z].*func<CR>,/

" Jump to start of whatever function we're inside
" nmap bf ?^\s*func<CR>,/

" faster tab switching
nmap <C-l> gt
nmap <C-h> gT

" Fugitive
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gc :Gcommit<CR>
nmap <Leader>gd :Gdiff<CR>
nmap <Leader>gl :tabe %<cr>:Glog<cr><cr>:copen<cr>

set ff=unix
colorscheme vividchalk
set ic
set scs
set guioptions=mer

set tabstop=4
set shiftwidth=4
set smarttab
set et

set nocindent
set autoindent
set lbr

" highlight search results
set hls

" incsearch is search while typing, shows matches before hitting enter
set is

" set bottom indicator
set ruler
set sc

" * and # search for next/previous of selected text when used in visual mode
vnoremap * :<C-u>call <SID>VSetSearch()<CR>/<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>?<CR>

function! s:VSetSearch()
  let old = @"
  norm! gvy
  let @/ = '\V' . substitute(escape(@", '\'), '\n', '\\n', 'g')
  let @" = old
endfunction
