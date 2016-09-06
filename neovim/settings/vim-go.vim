" Go related mappings
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>e <Plug>(go-run)
au FileType go nmap <Leader>b <Plug>(go-build)
au FileType go nmap <Leader>t <Plug>(go-test)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>r <Plug>(go-rename)
au FileType go nmap gd <Plug>(go-def-tab)

" Enable goimports to automatically insert import paths instead of gofmt
let g:go_fmt_command = "goimports"
let g:go_snippet_engine = "neosnippet"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck', 'deadcode', 'dupl', 'gosimple']
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'vetshadw', 'errcheck', 'deadcode', 'dupl', 'gosimple']
