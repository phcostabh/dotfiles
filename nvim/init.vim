" Base configuration {
   set timeoutlen=300                                 " mapping timeout
   set ttimeoutlen=50                                 " keycode timeout
   set mouse=a                                        " enable mouse
   set mousehide                                      " hide when characters are typed
   set history=1000                                   " number of command lines to remember
   set ttyfast                                        " assume fast terminal connection
   set viewoptions=folds,options,cursor,unix,slash    " unix/windows compatibility
   " set encoding=utf-8                                 " set encoding for text
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
   set listchars=tab:│\ ,trail:•,extends:❯,precedes:❮
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
   autocmd FileType gitcommit set spell spelllang=en_us,pt_br textwidth=72

   " ---------------------------------------------------------------------------------------------------"
   " Tell vim to remember certain things when we exit
   "
   "  '10  :  marks will be remembered for up to 10 previously edited files
   "  "100 :  will save up to 100 lines for each register
   "  :20  :  up to 20 lines of command-line history will be remembered
   "  %    :  saves and restores the buffer list
   "  n... :  where to save the viminfo files
   " ---------------------------------------------------------------------------------------------------"
   set viminfo='10,\"100,:20,%,n~/.nviminfo

" }

" Basic mappings {
   let mapleader=","
   let g:mapleader=","
   nnoremap ; :
   imap jk <ESC>
" }

" Custom Functions {
   " Strip trailing whitepaces
   function! <SID>StripTrailingWhitespaces()
      " Preparation: save last search, and cursor position.
      let _s=@/
      let l = line(".")
      let c = col(".")
      " Do the business:
      %s/\s\+$//e
      " Clean up: restore previous search history, and cursor position
      let @/=_s
      call cursor(l, c)
   endfunction
   autocmd BufWritePre *.* :call <SID>StripTrailingWhitespaces()

   " Surround visual selections with quotes
   function! Quote(quote)
      let save = @"
      silent normal gvy
      let @" = a:quote . @" . a:quote
      silent normal gvp
      let @" = save
   endfunction

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

   function! ResCur()
       if line("'\"") <= line("$")
           normal! g`"
           return 1
       endif
   endfunction

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
       echohl None
   endtry
   endfunction
" }

" Vim Backup {
   set backupdir=~/.cache/nvim/backup
   set directory=~/.cache/nvim/swap
   set undodir=~/.cache/nvim/undo

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

   " Sorrounding mappings
   nnoremap <leader>" ciw""<esc>hp<esc>el
   nnoremap <leader>' ciw''<esc>hp<esc>el
   nnoremap <leader>( ciw()<esc>hp<esc>el
   nnoremap <leader>[ ciw[]<esc>hp<esc>el
   nnoremap <leader>{ ciw{}<esc>hp<esc>el
   vmap <silent> <Leader>' :call Quote("'")<CR>
   vmap <silent> <Leader>" :call Quote('"')<CR>

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

   " Auto center everything
   nnoremap <silent> n nzz
   nnoremap <silent> N Nzz
   nnoremap <silent> * *zz
   nnoremap <silent> # #zz
   nnoremap <silent> g* g*zz
   nnoremap <silent> g# g#zz
   nnoremap <silent> <C-o> <C-o>zz
   nnoremap <silent> <C-i> <C-i>zz

   " reselect visual block after indent
   vnoremap < <gv
   vnoremap > >gv

   augroup resCur
       autocmd!
       autocmd BufWinEnter * call ResCur()
   augroup END

   augroup reload_vimrc
       autocmd!
       autocmd BufWritePost $MYVIMRC source $MYVIMRC
   augroup END

   autocmd BufWritePost * Neomake

   " Fzf fuzzy finder
   map <silent><space>pf :Files<cr>

   " NERDTree
   map <silent><space>nt :NERDTreeToggle<cr>
   map <silent><space>nf :NERDTreeFind<cr>
" }

" Setting up vim-plug {
  call plug#begin('~/.config/nvim/plugged')

   " Web {
      Plug 'othree/html5.vim', { 'for': 'html' }
      Plug 'gregsexton/MatchTag', { 'for': ['html', 'xml'] }
      Plug 'mattn/emmet-vim', { 'for' : ['html','css','sass','scss','less', 'htmldjango'] }
   " }

   " Javascript {
      Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
      Plug 'maksimr/vim-jsbeautify', { 'for': 'javascript' }
      Plug 'leshill/vim-json', { 'for': 'javascript' }
      Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
   " }

   " Lua {
      Plug 'xolox/vim-misc' | Plug 'xolox/vim-lua-ftplugin', { 'for': 'lua' }
   " }

   " PHP {
      Plug 'spf13/PIV', { 'for': 'php' }
      Plug 'stephpy/vim-php-cs-fixer', { 'for': 'php' }
      Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }
   " }

   " Golang {
      Plug 'fatih/vim-go', { 'for': 'go' }
      Plug 'nsf/gocode', { 'for': 'go' }
   " }

   " Nginx {
      Plug 'evanmiller/nginx-vim-syntax'
   " }

   " SQL {
     Plug 'vim-scripts/dbext.vim', {'autoload':{'filetypes':['sql']}}
   " }

   " Autocomplete {
     Plug 'SirVer/ultisnips'
     Plug 'honza/vim-snippets'
     Plug 'Shougo/deoplete.nvim'
     let g:deoplete#enable_at_startup = 1
   " }

   " Editing {
     Plug 'jiangmiao/auto-pairs'
     Plug 'tomtom/tcomment_vim'
     Plug 'tpope/vim-endwise'
     Plug 'editorconfig/editorconfig-vim'
     Plug 'terryma/vim-multiple-cursors'
     Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
     Plug 'junegunn/fzf.vim'
     Plug 'junegunn/goyo.vim'
     Plug 'majutsushi/tagbar'
     Plug 'osyo-manga/vim-over'

     function! s:buflist()
         redir => ls
         silent ls
         redir END
         return split(ls, '\n')
     endfunction

     function! s:bufopen(e)
         execute 'buffer' matchstr(a:e, '^[ 0-9]*')
     endfunction

     nnoremap <silent><space>b :call fzf#run({
     \ 'source': reverse(<sid>buflist()),
     \ 'sink': function('<sid>bufopen'),
     \ 'options': '+m',
     \ 'down': len(<sid>buflist()) + 2,
     \ })<cr>

     map <silent><space>tt :TagbarToggle<cr>

     Plug 'wellle/targets.vim'
     Plug 'tpope/vim-surround'
   " }

   " Navigation {
     Plug 'kien/ctrlp.vim' | Plug 'tacahiroy/ctrlp-funky'
     Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle','NERDTreeFind'] }
   " }

   " Misc {
      Plug 'ekalinin/Dockerfile.vim'
      Plug 'nanotech/jellybeans.vim'
      Plug 'tmhedberg/matchit'
      Plug 'mattn/webapi-vim' | Plug 'mattn/gist-vim', {  'on': 'Gist' }
      Plug 'benekastah/neomake'

      let g:neomake_javascript_jshint_maker = {
        \ 'args': ['--verbose'],
        \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
        \ }
      let g:neomake_javascript_enabled_makers = ['jshint']

      Plug 'bling/vim-airline'
   " }

   " Typescript {
     Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
     Plug 'Quramy/tsuquyomi', { 'for': 'typescript' }
   " }

   " Add plugins to &runtimepath
   call plug#end()

" }

" Wrapping up {

  " Custom Bundle configuration
  for fpath in split(globpath('~/.config/nvim/settings', '*.vim'), '\n')
    exec 'source' fpath
  endfor

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
    highlight LineNr ctermfg=237
    highlight normal ctermbg=none
    highlight nontext ctermbg=none
    set showmatch                  " automatically highlight matching braces/brackets/etc.
    set matchtime=2                " tens of a second to show matching parentheses
    set relativenumber
    set lazyredraw
    set laststatus=2
    set noshowmode
  " }
" }
