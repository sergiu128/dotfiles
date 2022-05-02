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
nnoremap <s-d> :bp\|bd! #<CR>

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

set nofsync
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
set hidden                  " keep hidden buffers
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

    " use <c-space> to trigger completion
    inoremap <silent><expr> <c-space> coc#refresh()

    " use <cr> to confirm completion
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

    " language packs: syntax highlighting
    Plug 'sheerun/vim-polyglot'

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " this restarts ripgrep whenever the query is updated, so fzf is a proxy
    " when using rg
    function! RipgrepFzf(query, fullscreen)
        let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s ** || true'
        let initial_command = printf(command_fmt, shellescape(a:query))
        let reload_command = printf(command_fmt, '{q}')
        let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
        call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction

    command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

    " fuzzy find files
    nnoremap <c-p> :FZF<cr>

    " rg through files in the current directory
    nnoremap <c-f> :RG<cr>

    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-surround'
    Plug 'ap/vim-buftabline'

    Plug 'morhetz/gruvbox'
    let g:gruvbox_contrast_dark='hard'

    Plug 'universal-ctags/ctags'
    Plug 'preservim/tagbar'
    nmap <C-m> :TagbarToggle<CR>

    " rust
    Plug 'rust-lang/rust.vim'  
    Plug 'simrat39/rust-tools.nvim'
    autocmd FileType rust nnoremap <C-r> :!cargo run<CR>
    autocmd FileType rust nnoremap <C-c> :!cargo check<CR>
    autocmd FileType rust nnoremap <C-b> :!cargo build<CR>
    autocmd FileType rust nnoremap <C-t> :!cargo test<CR>

    " golang
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
    autocmd FileType go nnoremap <C-r> :!go run .<CR>
    autocmd FileType go nnoremap <C-b> :!go build<CR>
    autocmd FileType go nnoremap <C-t> :!go test -v .<CR>

    Plug 'nvim-lualine/lualine.nvim'
    Plug 'preservim/nerdcommenter'
call plug#end()

set background=dark
colorscheme gruvbox

lua << END
require'lualine'.setup {
  options = {
    icons_enabled = false,
    theme = 'gruvbox_dark',
    component_separators = '',
    section_separators = '',
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename', 'location', 'progress'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
END
