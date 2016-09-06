let g:ctrlp_by_filename = 1                 " Default to filename searches
let g:ctrlp_cache_dir='~/.cache/vim/ctrlp'
let g:ctrlp_clear_cache_on_exit=1
let g:ctrlp_cmd = 'CtrlP'                   " Starts with mixed mode(files + MRU + buffer)
let g:ctrlp_extensions=['funky']
let g:ctrlp_follow_symlinks=1
let g:ctrlp_max_files=20000
let g:ctrlp_max_height=40
let g:ctrlp_reuse_window='startify'
let g:ctrlp_show_hidden=0
let g:ctrlp_working_path_mode = 'ra'        " Search for the nearst .git directory
let s:ctrlp_fallback = 'find %s -type f'    " Search for all files in the directoy
if executable('ag')
    let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
endif

" Ensure that the cache directory exists
call EnsureDirExists(g:ctrlp_cache_dir)

nmap \ [ctrlp]
nnoremap [ctrlp] <nop>
nnoremap [ctrlp]t :CtrlPBufTag<cr>
nnoremap [ctrlp]T :CtrlPTag<cr>
nnoremap [ctrlp]l :CtrlPLine<cr>
nnoremap [ctrlp]o :CtrlPFunky<cr>
nnoremap [ctrlp]b :CtrlPBuffer<cr>
