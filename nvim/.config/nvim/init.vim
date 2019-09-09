let g:elixirls = {
\ 'path': printf('%s/%s', stdpath('config'), '~/.local/share/nvim/plugged/elixir-ls'),
\ }

let g:elixirls.lsp = printf(
  \ '%s/%s',
  \ g:elixirls.path,
  \ 'release/language_server.sh')

function! g:elixirls.compile(...)
  let l:commands = join([
    \ 'mix local.hex --force',
    \ 'mix local.rebar --force',
    \ 'mix deps.get',
    \ 'mix compile',
    \ 'mix elixir_ls.release'
    \ ], '&&')

  echom '>>> Compiling elixirls'
  call system(l:commands)
  echom '>>> elixirls compiled'
endfunction

call plug#begin("~/.local/share/nvim/plugged")
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-vinegar'
  Plug 'clinstid/eink.vim'
  Plug 'romainl/vim-qf'
  Plug 'wsdjeg/vim-fetch'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'neoclide/coc.nvim', { 'tag': '*', 'do': { -> coc#util#install() } }
  Plug 'tommcdo/vim-express'

  Plug 'ludovicchabant/vim-gutentags'
  Plug 'majutsushi/tagbar'

  Plug 'junegunn/seoul256.vim'
  Plug 'whatyouhide/vim-gotham'
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'jacoborus/tender.vim'
  Plug 'erichdongubler/vim-sublime-monokai'

  Plug 'tpope/vim-fireplace'
  " Plug 'bhurlow/vim-parinfer'
  Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}

  Plug 'equalsraf/neovim-gui-shim'
  if !has("gui_vimr")
    Plug 'dzhou121/gonvim-fuzzy'
  endif
  Plug 'kassio/neoterm', { 'tag': '*' }

  " Elixir
  Plug 'mmorearty/elixir-ctags'
  Plug 'elixir-editors/vim-elixir'
  Plug 'mhinz/vim-mix-format'
  Plug 'danchoi/elinks.vim'
  Plug 'mattn/emmet-vim'
  Plug 'JakeBecker/elixir-ls', { 'do': { -> g:elixirls.compile() } }

  " Tests
  Plug 'janko/vim-test'

call plug#end()

" Coc completion
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
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
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


let mapleader = ","

let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

set showcmd                 " Show (partial) command in status line.
set showmatch               " Show matching brackets.
set showmode                " Show current mode.
set ruler                   " Show the line and column numbers of the cursor.
set number                  " Show the line numbers on the left side.
set hidden                  " Does not close the buffer
set formatoptions+=o        " Continue comment marker in new lines.
set textwidth=0             " Hard-wrap long lines as you type them.
set expandtab               " Insert spaces when TAB is pressed.
set tabstop=2               " Render TABs using this many spaces.
set shiftwidth=2            " Indentation amount for < and > commands.
set mouse=a                 " Set mouse on terminal
set clipboard=unnamedplus   " Integrate clipboard with yank action
set splitbelow              " Horizontal split goes below
set splitright              " Vertical split goes right

" jj
inoremap jj <esc>

" terminal
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
tnoremap <Leader>j <C-\><C-n>

nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" " Make terminal live on hidden buffers
" autocmd TermOpen * set bufhidden=hide
"
" Open terminal in insert mode
" autocmd BufWinEnter,WinEnter term://* startinsert
" autocmd BufLeave term://* stopinsert

let g:neoterm_default_mod = 'botright'
let g:neoterm_automap_keys = ',tt'
" let g:neoterm_autoinsert = 1
let g:neoterm_autoscroll = 1
let g:neoterm_size = 10

nnoremap <leader>sl :TREPLSendLine<CR>
vnoremap <leader>sl :TREPLSendSelection<CR>
nnoremap <F12> :Ttoggle<CR>
inoremap <F12> <esc>:Ttoggle<CR>
tnoremap <F12> <C-\><C-n>:Ttoggle<CR>
" tnoremap <esc> <C-\><C-n>

" Fuzzy Finder
let $FZF_DEFAULT_OPTS .= ' --no-height'
let $FZF_DEFAULT_OPTS .= ' --bind ctrl-a:select-all'

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=? -complete=dir Buffers
  \ call fzf#vim#buffers(<q-args>, fzf#vim#with_preview(), <bang>0)

" Fuzzy-find files with fzf
map <C-p> :Files<cr>
nmap <C-p> :Files<cr>

" Fuzzy-find buffers with fzf
map <C-b> :Buffers<cr>
nmap <C-b> :Buffers<cr>

" Fuzzy-find tags
map <Leader>bt :BTags<cr>
nmap <Leader>bt :BTags<cr>

" View commits in fzf
nmap <Leader>c :Commits<cr>

" Fuzzy-find tags
map <Leader>w :Windows<cr>
nmap <Leader>w :Windows<cr>

" Quotation
:nnoremap <Leader>dk ciw""<Esc>P
:nnoremap <Leader>sk ciw''<Esc>P
:nnoremap <Leader>kd daW"=substitute(@@,"'\\\|\"","","g")<CR>P


" tags
" command! -bang -nargs=* JTags call fzf#vim#tags('^' . expand('<cword>'), {'options': '--exact --select-1 --exit-0 +i'})
" :nnoremap <C-]> :JTags ^<c-r><c-w><cr>
:nnoremap <C-]> g<C-]>

" command mode
" cnoremap <C-a> <Home>
" cnoremap <C-e> <End>
" cnoremap <C-p> <Up>
" cnoremap <C-n> <Down>
" cnoremap <C-b> <Left>
" cnoremap <C-f> <Right>
" cnoremap <M-b> <S-Left>
" cnoremap <M-f> <S-Right>

" Vim test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" emmet
let g:user_emmet_settings = {
\  "eelixir": {
\    "extends": "html",
\    "snippets": {
\      "eexbe": "<%= | %>\n\t${child}<% end %>",
\      "eexb": "<% | %>\n\t${child}<% end %>",
\      "eexa": "<%= | %>"
\    }
\  },
\  "eruby": {
\    "extends": "html",
\    "snippets": {
\      "erb": "<%= | %>\n\t${child}<% end %>"
\    }
\  }
\}

function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
  else
    set rnu
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

" syntax off
syntax on

set background=dark
" set background=light

set termguicolors

" let g:seoul256_background = 236
" let g:seoul256_light_background = 256
" colorscheme seoul256

" colorscheme gotham
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.dark': {
  \       'transparent_background': 1
  \     }
  \   }
  \ }
colorscheme PaperColor
" colorscheme tender
" colorscheme sublimemonokai

" nvr
if has('nvim')
  let $VISUAL = 'nvr -cc split --remote-wait-silent'
endif
cnoreabbrev qq w<bar>bd

autocmd BufWritePre * %s/\s\+$//e

" elixir
let g:mix_format_on_save = 1

" gutentags
set wildignore+=node_modules/*
let g:gutentags_ctags_exclude_wildignore = 1

" set encoding
:lang en_US.UTF-8

" git blame
nnoremap <Leader>gb :tabnew term://git blame --date short %<cr>

" copy current filepath and line
nnoremap y. :let @+ = expand("%") . ':' . line(".")<cr>
