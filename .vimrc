execute pathogen#infect()

"Normal vim options
set mouse=a
set splitright
set relativenumber
set number
set colorcolumn=80
set expandtab
set shiftwidth=4
set tabstop=4
syntax on
filetype plugin indent on

"Don't tab complete on these files
set wildignore+=*.o,*.a,*.pyc
set wildignore+=*.swp,*~,*.tmp
set wildignore+=*.zip,*.tar.gz
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.git,.svn,.hg

"Use syntax folding for filetypes I use BUT not for python (break SimpylFold)
autocmd FileType c,cpp setlocal foldmethod=syntax

"Let modified buffers stay around in the background
set hidden

"Solarized color scheme
set background=dark
"let g:solarized_termcolors=16  "NOTE: if colors weird, try uncommenting this
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
"let g:syntastic_python_pylint_args = ['--rc-file=.pylintrc']
let g:syntastic_python_checkers = ['pylint']

"Syntastic TCL
let g:syntastic_tcl_nagelfar_exec = 'nagelfar.tcl'
let g:syntastic_tcl_checkers = ['nagelfar']

"Airline
set noshowmode
set laststatus=2  "Always show status line
let g:airline#extensions#tabline#enabled = 1
let airline#extensions#tabline#show_buffers = 0
let g:airline_powerline_fonts = 1

"IndentLine color
let g:indentLine_color_term = 0

"GitGutter
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
"The above settings don't seem to work when they are set to 1 so use autocmd
autocmd BufWritePost * :GitGutter

"YouCompleteMe autocompletion
let g:ycm_add_preview_to_context = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_python_binary_path = 'python3'

"SimpylFold better Python code folding
let g:SimpylFold_fold_import = 0
let g:SimpylFold_fold_docstring = 0
let g:SimpylFold_docstring_preview = 1

"ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:ultisnips_python_style = "google"
