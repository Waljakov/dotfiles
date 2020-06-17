syntax enable
filetype plugin on

set mouse=nvi " enables mouse support for all modes
" set nohlsearch " Stop highlighting search results permanently
set noerrorbells
set tabstop=4 softtabstop=4 " make tabstops and softtabstops 4 spaces long
set shiftwidth=4 " display tabstops 4 spaces long
set smartindent " indent automatically
set relativenumber
set nu " show linenumbers
set nowrap
set smartcase " search case-insensitive for all lowercase searches
set scrolloff=8 " minimum amount of visible lines above or below cursor
set clipboard+=unnamedplus " use 'standard' clipboard for yank
set hidden " No warning (and no need for !) when changing from an unsaved buffer
set nohlsearch " don't highlight search results
set shell=bash " this is needed eg when using fish and ranger-plugin

" Set undodir with filehistory instead of backup/swapfiles
set noswapfile
set nobackup
set undodir=~/.vim/.undodir
set undofile

" highlight the column 80 to hint at minizing line-width
set colorcolumn=80

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Give more space for displaying messages.
set cmdheight=2

" show status of coc in statusline
set statusline^=%{coc#status()}

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')
" Make sure you use single quotes
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align

Plug 'morhetz/gruvbox' " nice colorscheme
Plug 'mbbill/undotree' " show filehistory in a tree
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Code Completion
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Search for files
Plug 'junegunn/fzf.vim' " Get Vim-Commands like GFiles
Plug 'terryma/vim-multiple-cursors' " Multiple cursors like sublime
Plug 'tpope/vim-surround' " adds surround command (n:'s', v:'s') to eg. edit braces
Plug 'francoiscabrol/ranger.vim' " integrates ranger (<leader> f)
Plug 'rbgrouleff/bclose.vim' " Dependency of ranger.vim, closing buffer wo window

" Initialize plugin system
call plug#end()

" set colorscheme
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'
set background=dark

let mapleader = " "

" remap movement between splits
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

nnoremap <leader>H :wincmd H<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" ranger settings
let g:ranger_replace_netrw = 1 " let vim open directories with ranger
nnoremap <leader>F :RangerNewTab<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" GoTo code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" navigate diagnostics
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" File searching (in project)
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <C-p> :GFiles<CR>
nnoremap <Leader>pf :Files<CR>

" show undotree
nnoremap <leader>u :UndotreeShow<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings for specific filetypes

" Python
nnoremap <leader>bp :CocCommand python.execInTerminal<CR>
