color codedark

call pathogen#helptags()
call pathogen#infect()
let mapleader=","

set nowrap
set autoindent
set copyindent
set hlsearch
set incsearch
set history=1000
set undolevels=1000
set hidden
set number
set laststatus=2
set statusline=D:%b\ H:%B\ %<%f\ type=%y\ %h%m%r%=%-14.(%l,%c%V%)\ lines=%L\ %P
set backspace=indent,eol,start
set shiftwidth=2
set softtabstop=2
set showtabline=2
set tabstop=2
set expandtab
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

autocmd Filetype html,xml set listchars-=tab:>.
autocmd FileType python setlocal commentstring=#\ %s
autocmd FileType vim setlocal commentstring=\"\ %s

nnoremap <c-n> :lnext

" Syntastic
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_python_exec = 'python3'

function! DoPrettyXML()
  silent %!xmllint --format -
  endfunction

command! PXML call DoPrettyXML()
