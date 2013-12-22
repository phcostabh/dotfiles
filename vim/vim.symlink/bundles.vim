" Install bundles with :BundleInstall command or run it from the console:
" vim --noplugin -u vundles.vim -N "+set hidden" "+syntax on" +BundleClean! +BundleInstall +qall
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" Misc
Bundle 'kien/ctrlp.vim'
Bundle "jistr/vim-nerdtree-tabs.git"
Bundle "scrooloose/nerdtree.git"
Bundle "bling/vim-airline.git"
Bundle "vim-scripts/camelcasemotion.git"
Bundle "scrooloose/syntastic.git"
Bundle "tomtom/tcomment_vim.git"
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle "honza/vim-snippets"
Bundle "terryma/vim-multiple-cursors"
Bundle "estin/htmljinja"
Bundle "Lokaltog/vim-easymotion"
Bundle "mattn/emmet-vim"

" Git stuff
Bundle "tpope/vim-fugitive"
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'

" PHP stuff
Bundle "stephpy/vim-php-cs-fixer"
Bundle "shawncplus/phpcomplete.vim"

" Javascript stuff
Bundle "pangloss/vim-javascript"
Bundle "itspriddle/vim-jquery.git"

" Colorschemes
Bundle 'flazz/vim-colorschemes'
Bundle "daylerees/colour-schemes", { "rtp": "vim-themes/" }

filetype plugin indent on
