execute pathogen#infect()

" color scheme
set t_Co=256
set bg=dark
colorscheme monokai 

" syntax
syntax on

set number
set showmatch
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set autoindent
set nocompatible

set ruler

" case insensitive searching only with capital letters
set ignorecase
set smartcase

set incsearch
set hlsearch

" use one centralized place for temporary files
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" easy window nav
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>

" Map F5 to toggle gundo
nnoremap <F5> :GundoToggle<CR>

" Mao F8 to toggle tag bar
nnoremap <F8> :TagbarToggle<CR>

" Persist undo history
set undofile
set undodir=~/.vim/undo

" Show tab characters
set list
set listchars=tab:\▸\ ,trail:.,extends:#,nbsp:.,eol:¬

" Allow spaces after series of tabs
let g:airline#extensions#whitespace#mixed_indent_algo = 1

" Enable airline fonts
let g:airline_powerline_fonts = 1

" Enable the list of buffers (airline)
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'murmur'

" ag code search
let g:agprg="/usr/local/bin/ag --column"
let g:ag_prg="ag --vimgrep --smart-case"
let g:ag_highlight=1
let g:ag_format="%f:%l:%m"


" show column 80
set colorcolumn=80

" macvim settings to remove scrollbars
set guioptions-=r
set guioptions-=L
set guifont=Source\ Code\ Pro\ for\ Powerline:h12

" python syntax checking
let g:syntastic_python_checkers=['pyflakes']
let g:syntastic_mode_map = {'mode':'active','active_filetypes':['javascript','json','python'],'passive_filetypes':['html']}

" change gitgutter sign column color
highlight SignColumn ctermbg=237 guibg=#3c3d37
highlight GitGutterAdd ctermfg=2 guifg=#009900
highlight GitGutterChange ctermfg=3 guifg=#bbbb00
highlight GitGutterDelete ctermfg=1 guifg=#ff2222

" Intuitive backspacing
set backspace=indent,eol,start

