" NeoVim configuration file

" Plugins
call plug#begin($HOME . '/.local/share/nvim/plugged')

" Intelligence
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'hrsh7th/nvim-compe'

" General
Plug 'editorconfig/editorconfig-vim'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'nvim-lua/plenary.nvim'

" Navigation and search
Plug 'airblade/vim-rooter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Appearance
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'hoob3rt/lualine.nvim'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'rktjmp/lush.nvim'
Plug 'npxbr/gruvbox.nvim'

" HTML/CSS/JS
Plug 'norcalli/nvim-colorizer.lua'
Plug 'prettier/vim-prettier'

" Git
" Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'lewis6991/gitsigns.nvim'

" Testing
Plug 'vim-test/vim-test'
Plug 'ankush/frappe_test.vim'


Plug 'vimwiki/vimwiki'

call plug#end()

" Auto install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

set termguicolors
lua require'colorizer'.setup()

" Signify settings
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '-'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'
let g:signify_sign_show_count = 0
let g:signify_sign_show_text = 1

" rooter settings
let g:rooter_patterns = ['.git', 'Makefile', 'compile_commands.json', 'package.json', 'Cargo.toml']

" VimWiki config
let g:vimwiki_list = [{'path': '~/wiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_ext2syntax = {'.md': 'markdown'}
let g:vimwiki_listsym_rejected = '✗'
let g:vimwiki_use_calender=1

" Calendar config
let g:calendar_options = 'nornu'        " Draw calendar with proper width in split view
let g:calendar_monday=1                 " Start week on monday
let g:calendar_diary=$HOME.'wiki/diary' " Specify location for diary file

" completion.nvim config
let g:completion_sorting = "none"
let g:completion_matching_strategy_list = ['exact', 'substring']
let g:completion_matching_smart_case = 1
let g:completion_trigger_keyword_length = 2
let g:completion_timer_cycle = 150

" fzf settings
let g:fzf_preview_window = ['down:70%', 'ctrl-/']
let g:fzf_layout = { 'window': { 'width': 0.95, 'height': 0.95 } }


" Copy diary template when starting a new file in diary directory
autocmd BufNewFile */wiki/diary/[0-9]*.md :read ~/wiki/diary/templates/template.md

colorscheme dracula
set cursorline " highlight current line
highlight CursorLine ctermbg=234 guibg=#1a1b23
set autoindent
filetype plugin indent on
set backspace=indent,eol,start  " Disable awkward backspace behaviour
set clipboard=unnamedplus  " Use the system clipboard by default
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set hidden " Allows hiding unsaved buffers
set history=1000
set ignorecase " Ignore case while searching
set inccommand=nosplit
set incsearch " Search while still typing
set laststatus=2  " Always show the status line at the bottom
set lazyredraw " Don't redraw when running macros
set list
set mouse+=a " Enable mouse support
set nojoinspaces  " Use one space, not two, after punctuation
set noswapfile  " Don't use a swapfile for the buffer
set nowritebackup " required by Coc
set wrap " disable text wrapping
set number " show absolute line number on current line
set scrolloff=5 " Show at least 5 extra lines while scrolling
set shiftwidth=4
set shortmess+=I " Disable the default Vim startup message.
set shortmess+=W " Disable file written messages
set shortmess+=c " completions
set showtabline=2 " Enable bufferline on top
set smartcase " Consider case if caps are present
set spellfile=$HOME/.config/nvim/spell/en.utf-8.add
set spelllang=en_gb " enable spell-check
set splitbelow " Open new window in bottom half
set splitright " Open new window in right half
set listchars=tab:│\ ,extends:>,trail:·,precedes:<,nbsp:⦸
set timeoutlen=500 " reduce leader key timeout from 1sec to 0.5
set updatetime=150
set wildmenu
set noshowmode
set undodir=~/.config/nvim/undo-dir
set undofile
set colorcolumn=92
set noexpandtab
set signcolumn=number
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
" Trim whitespace on save for all files
autocmd BufWritePre * :%s/\s\+$//e

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif


let g:mapleader = "\<Space>"
let g:maplocalleader = "\<Space>"

nnoremap <leader>/ :Commentary<CR>
vnoremap <leader>/ :Commentary<CR>


let test#strategy = "vtr"

let test#custom_runners = {'python': ['Frappe']}
let test#enabled_runners = ["python#frappe"]
let g:test#python#frappe#testsite = "tests"

" Disable useless binding
nmap Q <Nop>

" Window navigation
nnoremap <M-j>     :resize -2<CR>
nnoremap <M-k>     :resize +2<CR>
nnoremap <M-h>     :vertical resize -2<CR>
nnoremap <M-l>     :vertical resize +2<CR>
nnoremap <leader>h <C-W>s
nnoremap <leader>v <C-W>v
nnoremap <leader>q :bdelete<CR>

" Searching
nnoremap \ :Rg<cr>
nnoremap <leader>f :Files<cr>
nnoremap <leader>sg :GFiles<cr>
nnoremap <leader>sc :Commits<cr>
nnoremap <leader>sm :GFiles?<cr>
nnoremap <leader>m :History<CR>

" Git
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>gs :G<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gg :GBrowse<CR>

" Make
nnoremap <leader>mm :!make<CR>
nnoremap <leader>mc :make clean<CR>
nnoremap <leader>mr :make run<CR>

" Testing
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>tn :TestNearest<CR>

" Quickfix list
nnoremap <leader>ll :copen<CR>
nnoremap <leader>ln :cnext<CR>
nnoremap <leader>lp :cprev<CR>

" Save like normal human beings
nnoremap <C-s> :w<CR>

" black formatting
nnoremap <leader>b :!black %<CR>

" Move in long wrapped lines
nmap <Down> gj
nmap <Up> gk

" Use arrow keys in visual mode for indenting
vmap <Left> <gv
vmap <Right> >gv

:map <F6> :setlocal spell! spelllang=en_gb<CR>
nnoremap <CR><CR> :noh<CR><CR>

nnoremap <silent><tab> :BufferLineCycleNext<CR>
nnoremap <silent><S-tab> :BufferLineCyclePrev<CR>

" Replace word with yanked word
nmap <C-p> ciw<C-r>0<ESC>

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Completion navigation
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Initialize lua stuff in lua init file
luafile $HOME/.config/nvim/luainit.lua
