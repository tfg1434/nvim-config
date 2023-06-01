filetype on             " enable filetype detection
filetype plugin on      " load file-specific plugins
filetype indent on      " load file-specific indentation

" set clipboard+=unnamedplus
vnoremap <C-c> "*y
set nocompatible            " disable compatibility to old-time vi
set mouse=v                 " middle-click
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
filetype plugin on
set ttyfast                 " Speed up scrolling in Vim
set hidden
set cmdheight=2
set updatetime=300
set number relativenumber
set nu rnu
set splitright
set so=999
set encoding=utf-8
highlight LineNr ctermfg=green
highlight LineNrAbove ctermfg=grey
highlight LineNrBelow ctermfg=grey

" Map Ctrl-Z and Ctrl-Y
nnoremap <C-Z> u
nnoremap <C-Y> <C-R>
inoremap <C-Z> <C-O>u
inoremap <C-Y> <C-O><C-R>

" Use <leader>u in normal mode to refresh UltiSnips snippets
nnoremap <leader>u <Cmd>call UltiSnips#RefreshSnippets()<CR>

" Map OO and oo
" nmap oo m`o<Esc>``
" nmap OO m`O<Esc>``
" set timeoutlen=200

set nohlsearch

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  :noh
  :noh

endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <F2> <Plug>(coc-rename)
" Use `[g]` abd `]g` to naviate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Formatting selected code.
xmap <A-S-F>  <Plug>(coc-format-selected)
nmap <A-S-F>  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Nerdtree mappings
nmap <C-n> :NERDTreeToggle<CR>

" NerdCommenter mappings
vmap <C-_> <Plug>NERDCommenterToggle \| j^
nmap <C-_> <Plug>NERDCommenterToggle \| j^
let g:NERDSpaceDelims = 1

" Sync search files with Nerdtree
function! IsNERDTreeOpen()
    return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! SyncTree()
    if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
        NERDTreeFind
        wincmd p
    endif
endfunction

autocmd BufRead * call SyncTree()

" Auto-save
let g:auto_save = 1
let g:auto_save_silent = 1

call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'} 
Plug 'jiangmiao/auto-pairs'
Plug 'morhetz/gruvbox'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'pianocomposer321/project-templates.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tibabit/vim-templates'
" Plug 'voidikss/vim-floaterm'
Plug 'tpope/vim-surround'
" Plug 'github/copilot.vim'
Plug 'tpope/vim-fugitive'
Plug 'sk1418/Join'
Plug '907th/vim-auto-save'
Plug 'mg979/vim-visual-multi', { 'branch': 'master' }
Plug 'michaeljsmith/vim-indent-object'
Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'chaoren/vim-wordmotion'

call plug#end()

" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-pairs',
    \ 'coc-json',
    \ 'coc-clangd',
    \ ]

let g:tmpl_auto_initialize = 0

let g:ctrlp_dont_split = 'NERD'

let g:VM_maps = {}
let g:VM_maps['Find Under'] =         '<C-d>'
let g:VM_maps['Find Subword Under'] = '<C-d>'

if has('win32')
    source ~/AppData/Local/nvim/cp.vim
else
    source $HOME/.config/nvim/cp.vim
endif

