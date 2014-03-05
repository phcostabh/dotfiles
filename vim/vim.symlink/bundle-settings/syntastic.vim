let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_warning_symbol = '≈'
let g:syntastic_enable_signs=1                         " mark syntax errors with :signs
let g:syntastic_auto_jump=0                            " automatically jump to the error when saving the file
let g:syntastic_auto_loc_list=1                        " show the error list automatically
let g:syntastic_quiet_messages = {'level': 'warnings'} " don't care about warnings
autocmd VimEnter * SyntasticCheck                      " Check the syntax when enter in the Vim
