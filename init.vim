" Automatically install Vim Plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/bundle')
Plug 'tmhedberg/SimpylFold'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Yggdroot/indentLine'
Plug 'elzr/vim-json'
Plug 'mesonbuild/meson', { 'rtp': 'data/syntax-highlighting/vim' }
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'rust-lang/rust.vim'
Plug 'vim-syntastic/syntastic'
" Plug 'SirVer/ultisnips'  FIXME remove
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'wagnerf42/vim-clippy'  FIXME remove
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-repeat'
" Plug 'honza/vim-snippets'  # FIXME remove
Plug 'tpope/vim-surround'
Plug 'cespare/vim-toml'
Plug 'maralla/vim-toml-enhance'
Plug 'tpope/vim-obsession'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'junegunn/fzf'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/racer'
Plug 'Matt-Deacalion/vim-systemd-syntax'
Plug 'sloboste/vim-groovy-syntax'
Plug 'chrisbra/vim-kconfig'
Plug 'thomafred/kermitSyntax', { 'rtp': 'vim' }
call plug#end()

" Normal vim options
set mouse=a
set splitright
set relativenumber
set number
set colorcolumn=80
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set textwidth=79
set fo+=t  " Autowrap at 80+ chars
syntax on
filetype plugin indent on
set updatetime=100

set wildmode=longest,list

" No ex mode
nnoremap Q <Nop>

" Don't tab complete on these files
set wildignore+=*.o,*.a,*.pyc,*.su
set wildignore+=*.swp,*~,*.tmp
set wildignore+=*.zip,*.tar.gz
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.git,.svn,.hg

" Tell ctags to look for tags file in directories above if not found in current
set tags=tags;/

" TODO remove if language server stuff ever works like tags
" Rusty tags
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
autocmd BufWrite *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" <bar> redraw!
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi

" Let modified buffers stay around in the background
set hidden

" Solarized color scheme
set termguicolors
set background=dark
colorscheme solarized

" NCM2 (formerly neovim completion manager)
" autocmd BufEnter * call ncm2#enable_for_buffer()
set shortmess+=c
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" NO Syntastic on these filetypes
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "passive_filetypes": ["c", "cc", "cpp", "h", "hpp", "rs", "rust"]}

" Syntastic status line
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Syntastic Python
let g:syntastic_python_pylint_exec = 'pylint'
" let g:syntastic_python_pylint_args = ['--rc-file=.pylintrc']
let g:syntastic_python_checkers = ['pylint']

" Syntastic TCL
let g:syntastic_tcl_nagelfar_exec = 'nagelfar.tcl'
let g:syntastic_tcl_checkers = ['nagelfar']

" Syntastic Markdown
let s:mdl_style_path = join(
    \ [fnamemodify(expand('<sfile>:p'), ':p:h'),
    \  "mdl-style.rb"],
    \ '/')
let g:syntastic_markdown_mdl_args = ["--style", s:mdl_style_path]

" FIXME remove
" Syntastic Rust
" let g:syntastic_rust_checkers = ['clippy']

" Syntastic shell
let g:syntastic_sh_checkers = ['shellcheck']
let g:syntastic_bash_checkers = ['shellcheck']
let g:syntastic_sh_shellcheck_args = '-x'
let g:syntastic_bash_shellcheck_args = '-x'

" Airline
set noshowmode
set laststatus=2  " Always show status line
let g:airline_extensions = ['branch', 'tabline', 'ctrlp', 'syntastic', 'ycm',
                           \'wordcount', 'whitespace']
let g:airline_powerline_fonts = 1
let g:airline_exclude_preview = 1
let airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
function GetVirtualEnv()
    return '('.fnamemodify($VIRTUAL_ENV, ':t').')'
endfunction
call airline#parts#define_condition('virtualenv', '&filetype =~# "python"')
call airline#parts#define_function('virtualenv', 'GetVirtualEnv')
let g:airline_section_c = airline#section#create_left([
    \ '%{ObsessionStatus(''Session active'', ''No session'')}',
    \ 'virtualenv'])
let g:airline_section_z = airline#section#create_right(['C:%2c', '%3.5p%%'])
let g:airline#extensions#default#layout = [
    \ [ 'a', 'b', 'c' ],
    \ [ 'z', 'error', 'warning' ]
    \ ]

" IndentLine color
let g:indentLine_color_term = 0
let g:indentLine_fileTypeExclude = ['markdown']
let g:vim_json_syntax_conceal = 0

" Language Server syntax checking
let s:cquery_bin_path = join(
    \ [fnamemodify(expand('<sfile>:p'), ':p:h'),
    \  'cquery', 'build', 'release', 'bin', 'cquery'],
    \ '/')
" FIXME
" let g:LanguageClient_serverStderr = '/tmp/clangd.stderr'
" let g:LanguageClient_serverCommands = {
"     \ 'cpp': ['clangd'],
"     \ 'c': ['clangd'],
\ }
let g:LanguageClient_serverCommands = {
    \ 'cpp': [s:cquery_bin_path, '--log-file=/tmp/cq.log'],
    \ 'c': [s:cquery_bin_path, '--log-file=/tmp/cq.log'],
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
\ }
let g:LanguageClient_loadSettings = 1
let g:LanguageClient_useVirtualText = 0
let g:LanguageClient_hoverPreview = 'Always'

" Don't start the language client if we see a special file.
let g:LanguageClient_autoStart = empty(glob(".disable_neovim_language_client"))

let s:cquery_settings_path = join(
    \ [fnamemodify(expand('<sfile>:p'), ':p:h'),
    \  "settings.json"],
    \ '/')
let g:LanguageClient_settingsPath = s:cquery_settings_path

" nnoremap <silent> <C-]> :call LanguageClient_textDocument_definition()<CR>

" SimpylFold better Python code folding
let g:SimpylFold_fold_import = 0
let g:SimpylFold_fold_docstring = 0
let g:SimpylFold_docstring_preview = 1

" FIXME
" " ultisnips
" let g:UltiSnipsExpandTrigger="<c-j>"
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpBackwardTrigger="<c-b>"
" let g:ultisnips_python_style = "google"

" FIXME
" Rust
let g:rust_recommended_style = 1
" let g:rustfmt_autosave = 1
let g:racer_cmd = "/home/ssloboda/.cargo/bin/racer"
let g:racer_experimental_completer = 1
