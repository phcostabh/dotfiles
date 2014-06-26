let g:neocomplete#enable_at_startup=1
let g:neocomplete#data_directory='~/.cache/vim/neocomplete'
let g:neocomplete#enable_smart_case=1
let g:neocomplete#sources#syntax#min_keyword_length=3

" Plugin key-mappings.
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()
