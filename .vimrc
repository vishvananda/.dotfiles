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
Bundle 'fatih/vim-go'
Bundle 'scrooloose/syntastic'
Bundle 'kevinw/pyflakes-vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'akhaku/vim-java-unused-imports'
Bundle 'rust-lang/rust.vim'
Bundle 'vim-airline/vim-airline'
Bundle 'derekwyatt/vim-scala'
Bundle 'cespare/vim-toml'
Bundle 'jceb/vim-hier'

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:ycm_goto_buffer_command = 'vertical-split'

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

syntax on
set number
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadBraces
au BufRead,BufNewFile Vagrantfile set filetype=ruby
au FileType markdown setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 spell spelllang=en_us
au FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2
au FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
au FileType c setlocal tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
au Filetype c nmap <buffer> <F5> :w<Esc>:!gcc -O3 % && ./a.out<CR>
au FileType cpp setlocal tabstop=2 softtabstop=2 shiftwidth=2
au FileType cpp nmap <buffer> <F5> :w<Esc>:!make test-debug<CR>
au FileType go setlocal tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
au FileType go nmap <buffer> <F5> :w<Esc>:!go build `dirname %` && ./$(basename $(dirname $(realpath %)))<CR>
au FileType go nmap <buffer> <F6> :w<Esc>:GoBuild<CR>
au FileType python nmap <buffer> <F5> :w<Esc>:!python %<CR>
au FileType rust :compiler cargo
au FileType rust nmap <buffer> <F5> :w<Esc>:make build --features nightly --target x86_64-unknown-linux-musl<CR><CR>
au FileType rust nmap <buffer> <F6> :w<Esc>:!cargo run --features nightly --target x86_64-unknown-linux-musl<CR>

au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"


highlight ExtraWhitespace ctermbg=darkgray guibg=#4E4E4E
au colorscheme * highlight ExtraWhitespace ctermbg=darkgray guibg=#4E4E4E
:match ExtraWhitespace /\s\+$\|\t\+/
highlight LongLine ctermbg=darkgray guibg=#4E4E4E
:2match LongLine /\%>79v.\+/
au colorscheme * highlight LongLine ctermbg=darkgray guibg=#4E4E4E
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
nmap <Leader>q gqip
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
nnoremap <F2> :set nonumber!<CR>
nmap <silent> <Leader>n :set nonumber!<CR>
inoremap jj <Esc>
nmap <Leader>g :YcmCompleter GoTo<CR>
nmap <Leader>k :cprev<CR>
nmap <Leader>j :cnext<CR>
" window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" navigate more easily through wrapped lines
noremap j gj
noremap k gk

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
hi Search cterm=NONE ctermfg=grey ctermbg=blue
