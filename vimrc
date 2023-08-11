call plug#begin('~/.vim/plugged')
Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'mattn/emmet-vim'
Plug 'lilydjwg/colorizer'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'sainnhe/gruvbox-material'
Plug 'tpope/vim-sensible'
Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }
Plug 'pearofducks/ansible-vim'
Plug 'fadein/vim-FIGlet'
Plug 'evansalter/vim-checklist'
Plug 'Raimondi/delimitMate'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'bounceme/poppy.vim',
Plug 'machakann/vim-highlightedyank',
Plug 'liuchengxu/vista.vim',
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' },
Plug 'ron-rs/ron.vim',

" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'},
Plug 'yaegassy/coc-ansible', {'do': 'yarn install --frozen-lockfile'},
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'},
call plug#end()

" Colors
if has('termguicolors')
  set termguicolors
endif
set background=dark
let g:airline_theme = 'gruvbox_material'
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_better_performance = 1
colorscheme gruvbox-material

let g:airline_section_b = '%t%m%r'
let g:airline_section_c = '%{FugitiveStatusline()} %{NearestMethodOrFunction()}'
let g:airline_section_x = '%y %{&fileencoding?&fileencoding:&encoding}'
let g:airline_section_y = '%b 0x%B'
let g:airline_section_z = '%p%% %l/%L %c'
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.whitespace = 'Ξ'

let mapleader=","

runtime! plugin/sensible.vim

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
set scrolloff=5

au BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible

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

" ALE
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['autopep8'],
\   'sh': ['shfmt'],
\   'go': ['gofmt']
\ }
let g:ale_fix_on_save = 1

let g:ale_linters = {
\   'go': ['golangci-lint'],
\   'python': ['pylint'],
\   'sh': ['shellcheck'],
\   'yaml.ansible': ['ansible-lint']
\ }

" shfmt config
let g:shfmt_extra_args = '-i 2'
if executable('shfmt')
  let &l:formatprg='shfmt -i 2' . &l:shiftwidth . ' -sr -ci -s'
endif

let g:use_FIGlet_as_operatorfunc = 1

" Custom bindings

" Change page{up,down} to ctrl + {u,p}
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

" Checkboxen
nnoremap <leader>ct :ChecklistToggleCheckbox<cr>
nnoremap <leader>ce :ChecklistEnableCheckbox<cr>
nnoremap <leader>cd :ChecklistDisableCheckbox<cr>
vnoremap <leader>ct :ChecklistToggleCheckbox<cr>
vnoremap <leader>ce :ChecklistEnableCheckbox<cr>
vnoremap <leader>cd :ChecklistDisableCheckbox<cr>
nnoremap <leader>cc :s/^\(\s*\)/\1[ ] /g<cr>:noh<cr>
noremap <leader>cc :s/^\(\s*\)/\1[ ] /g<cr>:noh<cr>

augroup Poppy
  autocmd!
  autocmd CursorMoved * call PoppyInit()
augroup end
let g:poppy=1

command! PoppyToggle :call clearmatches() | let g:poppy = -get(g:,'poppy',-1) |
  \ exe 'au! CursorMoved *' . (g:poppy > 0 ? ' callPoppyInit()' : '')
hi PoppyLevel1 guibg='#ea6962' guifg='#1d2021' gui=bold
hi PoppyLevel2 guibg='#e78a4e' guifg='#1d2021' gui=bold
hi PoppyLevel3 guibg='#d8a657' guifg='#1d2021' gui=bold
hi PoppyLevel4 guibg='#a9b665' guifg='#1d2021' gui=bold
hi PoppyLevel5 guibg='#89b482' guifg='#1d2021' gui=bold
hi PoppyLevel6 guibg='#7daea3' guifg='#1d2021' gui=bold
let g:poppyhigh = ['PoppyLevel1', 'PoppyLevel2', 'PoppyLevel3', 'PoppyLevel4', 'PoppyLevel5', 'PoppyLevel6' ]

let g:highlightedyank_highlight_duration = -1

let g:vista_default_executive = "coc"
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista#renderer#enable_icon = 1
let g:vista_fzf_preview = ['right:50%']
let g:vista_close_on_jump  = 1

nmap <silent> ,vv :Vista!! <CR>

let g:coc_node_path = "/usr/bin/node"
