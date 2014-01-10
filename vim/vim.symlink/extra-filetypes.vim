" jQuery
autocmd BufRead,BufNewFile *.js set ft=javascript syntax=jquery
" Volt
autocmd BufRead,BufNewFile *.volt set ft=html syntax=htmljinja
" Nginx
autocmd BufRead,BufNewFile */etc/nginx/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif
" Twig
autocmd BufNewFile,BufRead *.html set filetype=html.twig
