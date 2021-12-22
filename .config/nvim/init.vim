" navigate wrapped lines
nmap j gj
nmap k gk

" space as leader
noremap <SPACE> <Nop> 
let mapleader=" "

" copy to system clipboard
noremap <Leader>y "+y

" double esc to disable hlsearch
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

" for easy split navigation (Ctrl + hjkl)
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

" resize splits
nnoremap <silent> <s-up>    :resize -2<cr>
nnoremap <silent> <s-down>  :resize +2<cr>
nnoremap <silent> <s-left>  :vertical resize -2<cr>
nnoremap <silent> <s-right> :vertical resize +2<cr>

" moving between buffers
nnoremap <s-l> :bn<CR>
nnoremap <s-h> :bprev<CR>

" close buffer
nnoremap <s-d> :bp\|bd #<CR>

" automatically reload config
nnoremap <leader>sv :source $MYVIMRC<CR>

" indentation
set autoindent
set smartindent
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
filetype plugin indent on

set updatetime=300          " default=4000

set autoread                " reload file on change on disk
set mouse=a
set encoding=utf-8
set undofile                " persistent undo
set number
set relativenumber
set scrolloff=3
set hlsearch
set incsearch
set nowrapscan
set history=50
set autowrite
set ignorecase
set smartcase
set hidden                  " show hidden buffers
set foldlevelstart=20       " never fold
set foldmethod=syntax
set foldnestmax=1
set nobackup
set nowritebackup
set timeout
set timeoutlen=3000
set ttimeoutlen=100
syntax on

" display ASCII characters numerically
set display+=uhex

" neovim specific options
set inccommand=nosplit      " give a live preview when doing a substitution command

" load file to last position of cursor
autocmd BufReadPost *
            \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
            \ |   exe "normal! g`\""
            \ | endif

call plug#begin()
    " host language servers
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gf <Plug>(coc-references)
    nmap <silent> gr <Plug>(coc-rename)

    " use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
        else
            call CocAction('doHover')
        endif
    endfunction

    " highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " language packs: syntax highlighting
    Plug 'sheerun/vim-polyglot'

    " fuzzy finder and ripgrep from vim
    Plug 'junegunn/fzf'
    Plug 'BurntSushi/ripgrep'

    " fuzzy find files
    nnoremap <c-o> :FZF<cr>

    " rg through files in the current directory
    nnoremap <c-p> :Rg<cr>

    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-surround'
call plug#end()
