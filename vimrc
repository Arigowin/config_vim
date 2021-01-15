" auto install plugin manager vim-plug {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
" }}}

" plugins {{{
call plug#begin('~/.vim/plugged')

" linter
Plug 'w0rp/ale'

" completion
Plug 'maralla/completor.vim'

" ide like
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rking/ag.vim'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-utils/vim-man'

Plug 'yggdroot/indentline'
Plug 'ap/vim-css-color'
Plug 'mhinz/vim-signify', { 'branch': 'legacy' }

" colorscheme
"Plug 'fabi1cazenave/kalahari.vim'
"Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'

" highlighting improvement
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }
Plug 'hdima/python-syntax', { 'for': 'python' }
Plug 'luochen1990/rainbow'

" Python
Plug 'vim-scripts/indentpython.vim'

" Other

" add plugin to runtimepath
call plug#end()
" }}}

" Vimscript file settings {{{

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" auto-reload .vimrc
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" }}}

" swap files {{{

" swap files (.swp) in a common location

" Create directories if needed.
fun! RequireDirectory(directory)
    if !isdirectory(a:directory)
        call mkdir(a:directory)
    endif
endf

" // means use the file's full path
set dir=~/.vim/_swap//
call RequireDirectory(expand("~") . "/.vim/_swap")

" backup files (~) in a common location if possible
set backup
set backupdir=~/.vim/_backup/,~/tmp,/tmp
call RequireDirectory(expand("~") . "/.vim/_backup")

" turn on undo files, put them in a common location
set undofile
set undodir=~/.vim/_undo/
call RequireDirectory(expand("~") . "/.vim/_undo")

" }}}

"set relativenumber  " ruler with relative line number
set number          " ruler with line number
set hidden          " let change buffer without saving
set tabstop=4           " Render TABs using this many spaces.
set shiftwidth=4        " Indentation amount for < and > commands.

set clipboard=unnamed

" remove trailing whitespaces
autocmd BufWritePre *.py,*.js,*.hs,*.rs,*.html,*.css,*.scss,*.c,*.h,*.cpp,*.hpp silent! :%s/\s\+$//e

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" default updatetime 4000ms is not good for async update
set updatetime=100

" Searching configurations {{{
set incsearch   " Incremental search. Best search feature ever
set ignorecase
set smartcase   " Makes case sensitivity in search only matter if one of the letters is upper case.
set hlsearch    " highlight search result
" }}}

" completion {{{
set wildmenu                     " show more than one suggestion for completion
set wildmode=list:longest        " shell-like completion (up to ambiguity point)
set wildignore=*.o,*.out,*.obj,*.pyc,.git,.hgignore,.svn,.cvsignore,*/tmp/*,*.so,*.swp,*.zip
let g:completor_clang_binary = '/usr/lib/clang'
let g:completor_min_chars=3

let g:completor_python_binary = '/usr/lib/python3'
" }}}

" visuals {{{1

set t_Co=256            " force vim to use 256 colors
set background=dark
syntax on               " syntax highlighting
"let g:kalahari_termcolors=256
"colorscheme kalahari
"let g:molokai_termcolors=256
"colorscheme molokai
let g:gruvbox_termcolors=256
colorscheme gruvbox
" let g:gruvbox_contrast_dark='hard'

" look improvement
" set listchars=tab:Â\ ,trail:Â·,extends:>,precedes:<,space.
" set list
set list lcs=tab:\|\.

" break long lines visually (not actual lines)
set wrap linebreak
set textwidth=0 wrapmargin=0

" status line {{{2
set laststatus=2                 " always display the status line
set shortmess=atI                " short messages to avoid scrolling
set title
set ruler                        " show the cursor position all the time
set showcmd                      " display incomplete commands
let g:airline#extensions#tabline#enabled = 1
" }}}2

if exists('+colorcolumn')
    set colorcolumn=80
endif

" when scrolling, keep space around cursor
set scrolloff=2
set sidescrolloff=5

" split screen below and right instead of vim natural
set splitbelow
set splitright

" }}}1

" Arrow desactivation {{{
" noremap <Up> <nop>
" noremap <Down> <nop>
" noremap <Left> <nop>
" noremap <Right> <nop>
" noremap <home> <nop>
" noremap <End> <nop>
" noremap <Up> <nop>
" }}}

" convenient shortcut {{{
nnoremap Q @q
"}}}

" leader {{{
map <space> <leader>

nnoremap <silent> <Leader>/ :nohlsearch<CR>
nnoremap <silent> <Leader>r :set relativenumber!<CR>
nnoremap <silent> <Leader>g gg=G``

" CtrlP
nnoremap <silent> <Leader>o :CtrlP<CR>
nnoremap <silent> <Leader>b :CtrlPBuffer<CR>
nnoremap <silent> <Leader>f :CtrlPMRUFiles<CR>

" Man
map <leader>k <Plug>(Man)
map <leader>v <Plug>(Vman)

"}}}

" Plugins configurations

" linter {{{
let g:ale_c_gcc_options =		'-Wall -Werror -Wextra -I./libft/includes -I./../libft/includes -I./ft_printf/include -I./../ft_printf/include -I./glfw3/include -I./../glfw3/include -I./src/glad/include -I./../src/glad/include -I./include -I./../include -I. -I./..'
let g:ale_c_clang_options =		'-Wall -Werror -Wextra -I./libft/includes -I./../libft/includes -I./ft_printf/include -I./../ft_printf/include -I./glfw3/include -I./../glfw3/include -I./src/glad/include -I./../src/glad/include -I./include -I./../include -I. -I./.. -std=c11 '
let g:ale_cpp_gcc_options =		'-Wall -Werror -Wextra -std=c++11'
let g:completor_python_binary =	'/usr/lib/python2.7'
" }}}

" CtrlP {{{
" set the ignore file for ctrlp plugin
set wildignore+=*.so,*.swp,*.zip     " MacOSX/Linux

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" }}}

" airline {{{
let g:airline_powerline_fonts = 1
let g:airline_theme='distinguished'
" }}}

" vim-cpp-enhanced-highlight {{{
let g:cpp_class_scope_highlight = 1
"}}}

" ag.vim {{{
let g:ag_working_path_mode="r"
"}}}

" rainbow {{{
let g:rainbow_active = 1
"}}}

" nerdcommenter {{{
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
"}}}

" indentline {{{
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 1
let g:indentLine_setColors = 0
let g:indentLine_char_list = ['|', '¦', '¿', '¿']
"}}}
