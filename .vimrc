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

"Syntastic Python
let g:syntastic_python_pylint_exec = 'pylint'
let g:syntastic_python_pylint_args = ['--rc-file=.pylintrc']
let g:syntastic_python_checkers = ['pylint']

"Syntastic c++
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = '-Wall -Wextra -pedantic-errors'
let g:syntastic_cpp_compiler_options += '-std=c++11 -stdlib=c++'

"Syntastic TCL
let g:syntastic_tcl_nagelfar_exec = 'nagelfar.tcl'
let g:syntastic_tcl_checkers = ['nagelfar']

"Syntastic Verilog / System Verilog
"TODO use verilator

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

"GitGutter
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 1

"YouCompleteMe options
let g:ycm_register_as_syntastic_checker = 0
let g:ycm_add_preview_to_context = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_python_binary_path = 'python'

"SimpylFold better Python code folding
let g:SimpylFold_fold_import = 0
let g:SimpylFold_fold_docstring = 0
let g:SimpylFold_docstring_preview = 1
