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

"Syntastic status line
set statusline+=%#warningmsg#                                                   
set statusline+=%{SyntasticStatuslineFlag()}                                    
set statusline+=%*                                                              
let g:syntastic_always_populate_loc_list = 1                                    
let g:syntastic_auto_loc_list = 1                                               
let g:syntastic_check_on_open = 1                                               
let g:syntastic_check_on_wq = 0
