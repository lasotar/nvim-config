space + b + c -> toggle breakpoint  
space + b + C -> toggle conditional breakpoint (will prompt for condition)  
space + b + backspace -> terminate debugging session  
f5 - start debugging  
f10 - step into  
f11 - step over  
f12 - step out  


========= VIM ==========

basic vim setup for C language
everything should be added to .vimrc

requires clangd
```
" Check if clangd is installed and set omnifunc for autocompletion
if executable('clangd')
  augroup lsp_c
    autocmd!
    autocmd FileType c,cpp setlocal omnifunc=clangd#complete
  augroup END
endif

" Format the file with clang-format on demand
nnoremap <silent> <leader>f :%!clang-format<CR>

" Auto-format on save with clang-format if available
if executable('clang-format')
  autocmd BufWritePre *.c,*.cpp,*.h,*.hpp :silent! %!clang-format
endif

" Use omnifunc for autocompletion with clangd
autocmd FileType c,cpp setlocal omnifunc=syntaxcomplete#Complete

" Trigger omnifunc completion manually with <C-x><C-o>
inoremap <silent><expr> <C-Space> "<C-x><C-o>"

" Toggle line comments in Normal mode
nnoremap <leader>c :s/^/\/\//<CR>

" Toggle line comments in Visual mode
vnoremap <leader>c :s/^/\/\//<CR>gv

" Uncomment lines in Normal mode
nnoremap <leader>u :s/^\/\/<CR>

" Uncomment lines in Visual mode
vnoremap <leader>u :s/^\/\/<CR>gv

" Store yanking and pasting in system register
set clipboard+=unnamed
```

