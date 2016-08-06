execute pathogen#infect()

"Normal vim options
set relativenumber
set number
set colorcolumn=80
set expandtab
set shiftwidth=4
set tabstop=4
syntax on
filetype plugin indent on

"Pretend buffers are like tabs in other programs
set hidden
"FIXME
"nnoremap <silent> gt : <c-U>exec v:count ? "buffer".v:count<CR> ? "bn".<CR>
nnoremap <silent> gt :bn<CR>
nnoremap <silent> gT :bp<CR>

"Solarized color scheme
set background=dark
set t_Co=16
colorscheme solarized
