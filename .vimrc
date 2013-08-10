set nocompatible               " be iMproved
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'godlygeek/csapprox'
Bundle 'Lokaltog/powerline'

set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
syntax on
set number
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadBraces
au BufRead,BufNewFile Vagrantfile set filetype=ruby
au FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2
au FileType c setlocal tabstop=2 softtabstop=2 shiftwidth=2
au Filetype c nmap <buffer> <F5> :w<Esc>:!gcc -O3 % && ./a.out<CR>
au FileType cpp setlocal tabstop=2 softtabstop=2 shiftwidth=2
au FileType cpp nmap <buffer> <F5> :w<Esc>:!make test<CR>
au FileType go nmap <buffer> <F5> :w<Esc>:!go run -gcflags -m %<CR>
highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$\|\t\+/
au colorscheme * highlight ExtraWhitespace ctermbg=red guibg=red
"autocmd BufWritePre * :%s/\s\+$//e
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set hlsearch
set wildmenu
set wildmode=list:longest
set history=1000
set tags=tags;
let mapleader=","
set scrolloff=3
" Uncomment the following for code folding with spacebar
"set foldmethod=indent
"nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
"vnoremap <Space> zf
filetype plugin indent on
set guifont=Monaco\ 18
set mouse=a
filetype plugin on
" ctrl-p settings
let g:ctrlp_user_command = {
    \ 'types': {
        \ 1: ['.git', 'cd %s && git ls-files'],
        \ 2: ['.hg', 'hg --cwd %s locate -I .'],
        \ },
    \ 'fallback': 'find %s -type f'
    \ }
" Taglist variables
" Display function name in status bar:
let g:ctags_statusline=1
" Automatically start script
let generate_tags=1
" Displays taglist results in a vertical window:
let Tlist_Use_Horiz_Window=0
" Shorter commands to toggle Taglist display
nnoremap <F2> :set nonumber!<CR>
nmap <silent> <Leader>n :set nonumber!<CR>
nmap <C-P> :NERDTreeToggle<CR>
nmap <Leader>o :NERDTreeToggle<CR>
nmap <F3> :NERDTreeToggle<CR>
nmap <Leader>l :TlistToggle<CR>
nmap <F4> :TlistToggle<CR>
nnoremap <leader>a :Ack
inoremap jj <Esc>
" Various Taglist diplay config:
let Tlist_Use_Right_Window = 1
let Tlist_Compact_Format = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_File_Fold_Auto_Close = 1
nmap <buffer> <F5> :w<Esc>:!python %<CR>
" window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" navigate more easily through wrapped lines
noremap j gj
noremap k gk
" navigate through taglist
nmap <Leader>[ :tp<CR>
nmap <Leader>] :tn<CR>

set noshowmode
set laststatus=2
let python_highlight_all = 1
if &term =~ '^\(256\|screen\)' || $TERM_PROGRAM =='iTerm.app'
  set t_Co=256
endif
if &t_Co != 256
  let g:CSApprox_loaded=0
endif
colorscheme ir_black
