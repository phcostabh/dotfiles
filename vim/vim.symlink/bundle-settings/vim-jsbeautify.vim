autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd BufWritePre *.{js} :call JsBeautify()

