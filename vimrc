color codedark

call plug#begin('~/.vim/plugged')
Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-commentary'
Plug 'mattn/emmet-vim'
Plug 'lilydjwg/colorizer'
call plug#end()

let g:airline_theme = "badwolf"
let g:airline_section_y = '%{GetCharCode()}'

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
set relativenumber
set laststatus=2
set backspace=indent,eol,start
set shiftwidth=2
set softtabstop=2
set showtabline=2
set tabstop=2
set expandtab
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" Filetype specific settings
autocmd FileType python,bash,sh setlocal commentstring=#\ %s
autocmd FileType python set shiftwidth=4
autocmd FileType python set softtabstop=4
autocmd FileType python set showtabline=4
autocmd FileType python set tabstop=4

autocmd FileType vim setlocal commentstring=\"\ %s
autocmd FileType css,scss,js setlocal commentstring=//\ %s
autocmd Filetype html,xml set listchars-=tab:>.
autocmd Filetype html setlocal commentstring=<!--\ %s\ -->

" Syntastic
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_go_checkers = ['golangci_lint']
let g:syntastic_bash_checkers = ['shellcheck']

" Custom bindings
map <PageUp> <C-U>
map <PageDown> <C-D>
imap <PageUp> <C-O><C-U>
imap <PageDown> <C-O><C-D>
set nostartofline

" Custom functions
function! DoPrettyXML()
  silent %!xmllint --format -
  endfunction

function! DoAutoPep8()
  silent %!autopep8 -aa -
endfunction

function! DoJqPrettifying()
  silent :%!jq '.'
endfunction

function! ToggleNumbering()
  if g:numbersOn == 1
    let g:numbersOn = 0
    silent :set nonumber
    silent :set norelativenumber
  else
     let g:numbersOn = 1
    silent :set number
    silent :set relativenumber
  endif
endfunction

function! ToggleWrapping()
  if g:wrapOn == 1
    let g:wrapOn = 0
    silent :set wrap
  else
     let g:wrapOn = 1
    silent :set nowrap
  endif
endfunction

" Keybindings for custom functions
command! PXML call DoPrettyXML()
command! PEP8 call DoAutoPep8()
command! PJSON call DoJqPrettifying()

let g:numbersOn = 1
nmap <silent> ,nn :call ToggleNumbering()<CR>

let g:wrapOn = 1
nmap <silent> ,ww :call ToggleWrapping()<CR>

" from https://github.com/Lokaltog/vim-powerline/blob/develop/autoload/Powerline/Functions.vi
function! GetCharCode()
  "Get the output of :ascii
  redir => ascii
  silent! ascii
  redir END

  if match(ascii, 'NUL') != -1
  return 'NUL'
  endif

  " Zero pad hex values
  let nrformat = '0x%04x'

  let encoding = "utf-8" 
  "= '' ? &enc : &fenc)

  if encoding == 'utf-8'
    " Zero pad with 2 zeroes in unicode files
    let nrformat = '0x%02x'
  endif

  " Get the character and the numeric value from the return value of :ascii
  " This matches the two first pieces of the return value, e.g.
  " "<F>  70" => char: 'F', nr: '70'
  let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')

  " Format the numeric value
  let hex = printf(nrformat, nr)
  let dec = str2nr(hex, 16)

  return dec . " ". hex
endfunction

" Prevent replace mode
function s:ForbidReplace()
    if v:insertmode isnot# 'i'
        call feedkeys("\<Insert>", "n")
    endif
endfunction
augroup ForbidReplaceMode
    autocmd!
    autocmd InsertEnter  * call s:ForbidReplace()
    autocmd InsertChange * call s:ForbidReplace()
augroup END
