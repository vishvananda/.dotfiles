set nocompatible               " be iMproved
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'
Bundle 'Valloric/YouCompleteMe'
Bundle 'kien/ctrlp.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'Lokaltog/powerline'
Bundle 'godlygeek/csapprox'
Bundle 'scrooloose/syntastic'
Bundle 'ervandew/supertab'
Bundle 'kevinw/pyflakes-vim'
Bundle 'fatih/vim-go'

set rtp+=/usr/local/Cellar/go/*/misc/vim
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
au FileType cpp nmap <buffer> <F5> :w<Esc>:!make test-debug<CR>
au FileType go setlocal tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
au FileType go nmap <buffer> <F5> :w<Esc>:!go run -gcflags -m %<CR>
au FileType python nmap <buffer> <F5> :w<Esc>:!python %<CR>


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
set guifont=Menlo\ for\ Powerline:h12
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
nnoremap <F2> :set nonumber!<CR>
nmap <silent> <Leader>n :set nonumber!<CR>
inoremap jj <Esc>
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
