nnoremap <Leader>j :CtrlPBufTag<CR>

let g:ctrlp_by_filename = 1              " Default to filename searches
let g:ctrlp_clear_cache_on_exit = 0      " Force Ctrl P plugin to not clear the cache
let g:ctrlp_cmd = 'CtrlP'                " Starts with mixed mode(files + MRU + buffer)
let g:ctrlp_working_path_mode = 'ra'     " Search for the nearst .git directory
let s:ctrlp_fallback = 'find %s -type f' " Search for all files in the directoy

" Search for PHP functions.
let g:ctrlp_buftag_types={
    \ 'php': '--PHP-kinds=+f-vc'
\ }

" Ignore files under .git directory and compiled files.
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$',
    \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$\|\.zip$'
\ }

" Just files tracked by git.
let g:ctrlp_user_command = {
    \ 'types':  {
        \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
    \ },
    \ 'fallback': s:ctrlp_fallback
\ }

