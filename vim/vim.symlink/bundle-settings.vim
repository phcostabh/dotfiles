for fpath in split(globpath('~/.vim/bundle-settings', '*.vim'), '\n')
  exe 'source' fpath
endfor
