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

"Airline
set laststatus=2  "Always show status line
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"IndentLine color
let g:indentLine_color_term = 0

"Tagbar
nnoremap <F8> :TagbarToggle<CR>
autocmd VimEnter * nested :call tagbar#autoopen(1)

"NERDTree file explorer
autocmd vimenter * NERDTree  "NOTE: this is VERY SLOW when using sshfs
autocmd VimEnter * wincmd p  "Focus on file not NERDTree on startup
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif