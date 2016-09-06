let g:php_cs_fixer_path="~/.vim/bin/php-cs-fixer"
autocmd FileType php noremap <buffer>  <c-f> :call PhpCsFixerFixFile()<cr>
