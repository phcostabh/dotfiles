" Base configuration {
set mouse=a                                        " enable mouse
set mousehide                                      " hide when characters are typed
set history=1000                                   " number of command lines to remember
set ttyfast                                        " assume fast terminal connection
set viewoptions=folds,options,cursor,unix,slash    " unix/windows compatibility
set encoding=utf-8                                 " set encoding for text
if exists('$TMUX')
    set clipboard=
else
    set clipboard=unnamed                           " sync with OS clipboard
endif
set hidden                                         " allow buffer switching without saving
set autoread                                       " auto reload if file saved externally
set nrformats-=octal                               " always assume decimal numbers
set showcmd
set whichwrap+=<,>,h,l,[,]
set tags=tags;/
set showfulltag
set modeline
set modelines=5

" whitespace
set backspace=indent,eol,start                     " allow backspacing everything in insert mode
set autoindent                                     " automatically indent to match adjacent lines
set expandtab                                      " spaces instead of tabs
set smarttab                                       " use shiftwidth to enter tabs
let &tabstop=4                                     " number of spaces per tab for display
let &softtabstop=4                                 " number of spaces per tab in insert mode
let &shiftwidth=4                                  " number of spaces when indenting
set listchars=tab:┋\ ,trail:•,extends:❯,precedes:❮
set list
set shiftround
set linebreak
let &showbreak='↪ '

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store
set wildignore+=*.jpeg,*.jpg,*.gif                 " Ingnores also images
set wildignore+=*.swf                              " And another binary files.

" disable sounds
set noerrorbells
set novisualbell
set t_vb=

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan

" Enable spell checker for git commit
autocmd FileType gitcommit set spell spelllang=en_us,pt_br textwidth=80

" ---------------------------------------------------------------------------------------------------"
" Tell vim to remember certain things when we exit
"
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
" ---------------------------------------------------------------------------------------------------"
" set viminfo='10,\"100,:20,%,n~/.viminfo

" }

" Basic mappings {
let mapleader = "\<Space>"
let maplocalleader = ","
nnoremap ; :
imap jk <ESC>
nmap <Leader>fs :w<CR>
" }

" Ensure a dir exists
function! EnsureDirExists(dir)
    let l:dir_path = expand(a:dir)
    if !isdirectory(l:dir_path)
        if exists("*mkdir")
            call mkdir(expand(l:dir_path),'p')
            echo "Created directory: " . l:dir_path
        else
            echo "Please create directory: " . l:dir_path
        endif
    endif
endfunction

" Toggle relativenumber and number
function! ToggleNumbering()
    if &relativenumber
        set number
        set norelativenumber
    else
        set relativenumber
        set nonumber
    endif
endfunc

" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
    let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
    if l:tabstop > 0
        let &l:sts = l:tabstop
        let &l:ts = l:tabstop
        let &l:sw = l:tabstop
    endif
    call SummarizeTabs()
endfunction

function! SummarizeTabs()
    try
        echohl ModeMsg
        echon 'tabstop='.&l:ts
        echon ' shiftwidth='.&l:sw
        echon ' softtabstop='.&l:sts
        if &l:et
            echon ' expandtab'
        else
            echon ' noexpandtab'
        endif
    finally
        echohl NONE
    endtry
endfunction
" }

" Vim Backup {
set backupdir=~/.cache/vim/backup
set directory=~/.cache/vim/swap
set undodir=~/.cache/vim/undo

set backup
set swapfile

call EnsureDirExists(&backupdir)
call EnsureDirExists(&directory)
call EnsureDirExists(&undodir)

if has('persistent_undo')
    set undofile
    set undolevels=1000
    set undoreload=10000
endif
" }

" Basic Mappings {
nnoremap <C-a> ggvG$         " Select all
inoremap <C-v> <ESC> "+gpa   " Ctrl + v compatilibility
vnoremap <C-c> "+y           " Ctrl + c compatilibility
vnoremap <C-x> "+x           " Ctrl + x compatilibility

nmap <S-h> :bp <CR> " Move to the tab at the right
nmap <S-l> :bn <CR> " Move to the tab at the left

map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR> " Find merge conflict markers

noremap <leader>n :call ToggleNumbering()<cr>

" Sane regex
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
nnoremap :s/ :s/\v

" " Auto center everything
" nnoremap <silent> n nzz
" nnoremap <silent> N Nzz
" nnoremap <silent> * *zz
" nnoremap <silent> # #zz
" nnoremap <silent> g* g*zz
" nnoremap <silent> g# g#zz
" nnoremap <silent> <C-o> <C-o>zz
" nnoremap <silent> <C-i> <C-i>zz

" reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END
" }

" Copy & paste to system clipboard with <Space>p and <Space>y {{{
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
" }}}

" Automatically jump to end of text pasted {{{
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]`
" }}}
"
" Delete buffer without closing window.
nnoremap <leader>q :bp\|bd #<CR>
" }}}

" Setting up vim-plug {
call plug#begin('~/.vim/plugged')

" Web {
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'mattn/emmet-vim', { 'for' : ['html','css','sass','scss','less','javascript'] }
Plug 'prettier/vim-prettier', {
	\ 'do': 'yarn install',
	\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] }

" exec async
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.json,*.css,*.scss,*.less,*.graphql PrettierAsync

" use tabs over spaces
let g:prettier#config#use_tabs = 'true'
" single quotes over double quotes
let g:prettier#config#single_quote = 'false'
" number of spaces per indentation level
let g:prettier#config#tab_width = 4
let g:prettier#config#trailing_comma = 'none'

let g:user_emmet_settings = {
            \  'javascript' : {
            \      'extends' : 'jsx',
            \  },
            \}
" }

" Javascript {
Plug 'leshill/vim-json', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'heavenshell/vim-jsdoc', { 'for': 'javascript' }
Plug 'ternjs/tern_for_vim', { 'for': 'javascript' }

let g:javascript_plugin_jsdoc = 1

autocmd FileType javascript setl tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
" }

" Lua {
Plug 'xolox/vim-lua-ftplugin', { 'for': 'lua' }
" }

" PHP {
Plug 'spf13/PIV', { 'for': 'php' }
Plug 'stephpy/vim-php-cs-fixer', { 'for': 'php' }
Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }

let g:php_cs_fixer_path="~/.vim/bin/php-cs-fixer"
autocmd FileType php noremap <buffer>  <c-f> :call PhpCsFixerFixFile()<cr>
" }

" Golang {
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }

au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>r <Plug>(go-run)
au FileType go nmap <Leader>b <Plug>(go-build)
au FileType go nmap <Leader>t <Plug>(go-test)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>e <Plug>(go-rename)
au FileType go nmap gd <Plug>(go-def-tab)

" Enable goimports to automatically insert import paths instead of gofmt
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" }

" Nginx {
Plug 'vim-scripts/nginx.vim'
" }

" Docker {
Plug 'ekalinin/Dockerfile.vim'
" }

" Autocomplete {
Plug 'roxma/nvim-completion-manager'
" Requires vim8 with has('python') or has('python3')
" Requires the installation of msgpack-python. (pip install msgpack-python)
if !has('nvim')
    Plug 'roxma/vim-hug-neovim-rpc'
endif

" don't give |ins-completion-menu| messages.  For example,
" '-- XXX completion (YYY)', 'match 1 of 2', 'The only match',
set shortmess+=c

Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'

" ultisnips
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
" }

" Editing {
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'tmhedberg/matchit'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'yggdroot/indentline'

" indentline
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
" let g:indentLine_char = '⋮'
" let g:indentLine_char = '︙'
" let g:indentLine_char = '⁞'
let g:indentLine_char = '┊'
let g:indentLine_faster = 1
" NONE X terminal
let g:indentLine_color_tty_light = 7 " (default: 4)
let g:indentLine_color_dark = 1 " (default: 2)
" }

" Navigation {
Plug 'ctrlpvim/ctrlp.vim' | Plug 'tacahiroy/ctrlp-funky'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'

nnoremap <Leader>fu :CtrlPFunky<Cr>
nnoremap <Leader>pf :Files<cr>
nnoremap <Leader>ff :GFiles?<cr>
nnoremap <Leader>fa :Ag<cr>
" nnoremap <Leader>fc :Colors<cr>
nnoremap <Leader>fl :BLines<cr>
nnoremap <Leader>fb :Buffers<cr>
" }

" Misc {
Plug 'mattn/webapi-vim' | Plug 'mattn/gist-vim', {  'on': 'Gist' }
let g:gist_detect_filetype = 1                         " Detect filetype from filename
let g:gist_clip_command = 'xclip -selection clipboard' " Copy gits to clipboard (-c option).
let g:gist_show_privates = 1                           " Show private gists
let g:gist_post_private = 1                            " Post private gist by default
let g:gist_detect_filetype = 1                         " Auto detect filetype

Plug 'nanotech/jellybeans.vim'
let g:jellybeans_overrides = {
            \  'background': { 'ctermbg': 'none', '256ctermbg': 'none'  },
            \}

Plug 'gosukiwi/vim-atom-dark'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = 'jellybeans'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline_skip_empty_sections = 1

Plug 'xolox/vim-misc'
Plug 'bronson/vim-trailing-whitespace'
Plug 'wakatime/vim-wakatime'
Plug 'tpope/vim-sleuth'

Plug 'w0rp/ale'
let g:ale_linters = {
            \   'javascript': ['eslint'],
            \}

let g:go_gometalinter_options = join([
\    '--fast'
\ ], ' ')

let g:ale_sign_error = '✗'
let g:ale_sign_warning = '≈'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_fix_on_save = 1

Plug 'endel/vim-github-colorscheme'

" }

" Typescript {
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'Quramy/tsuquyomi', { 'for': 'typescript' }
" }

" Ruby {
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
" }

" Add plugins to &runtimepath
call plug#end()

" }

" Wrapping up {

" Custom Bundle configuration
filetype plugin indent on
syntax enable

" UI Configuration {
colorscheme jellybeans
set nospell
set t_Co=256
set nofoldenable
set showmatch
set nohidden
highlight clear SignColumn     " SignColumn should match background
highlight clear LineNr         " Current line number row will have same background color in relative mode
highlight LineNr ctermfg=240
highlight Normal ctermbg=NONE
highlight NonText ctermbg=NONE
highlight SpecialKey ctermbg=NONE ctermfg=240
if g:colors_name == 'github'
    highlight clear SpecialKey
    highlight SpecialKey ctermfg=246
endif
set showmatch                  " automatically highlight matching braces/brackets/etc.
set matchtime=2                " tens of a second to show matching parentheses
set relativenumber
set lazyredraw
set laststatus=2
set noshowmode
" }
" }
