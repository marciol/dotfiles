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

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin("~/.local/share/nvim/plugged")
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-vinegar'
  Plug 'romainl/vim-qf'
  Plug 'wsdjeg/vim-fetch'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'tommcdo/vim-express'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'majutsushi/tagbar'
  Plug 'kassio/neoterm'

  " Clojure
  " Plug 'gpanders/nvim-parinfer'
  " Plug 'bhurlow/vim-parinfer'
  Plug 'eraserhd/parinfer-rust', {'do':
        \  'cargo build --release'}
  Plug 'guns/vim-sexp'
  Plug 'tpope/vim-sexp-mappings-for-regular-people'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'venantius/vim-cljfmt'
  Plug 'Olical/conjure', {'tag': 'v4.25.0'}

  " Elixir
  Plug 'mmorearty/elixir-ctags'
  Plug 'elixir-editors/vim-elixir'
  Plug 'mhinz/vim-mix-format'
  Plug 'danchoi/elinks.vim'
  Plug 'mattn/emmet-vim'
  Plug 'JakeBecker/elixir-ls', { 'do': { -> g:elixirls.compile() } }

  " Tests
  Plug 'janko/vim-test'
  Plug 'powerman/vim-plugin-AnsiEsc'

  " Colors
  Plug 'NLKNguyen/papercolor-theme'

call plug#end()


let mapleader = ","
let maplocalleader = ","

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
set colorcolumn=80
:lang en_US.UTF-8


" jj
inoremap jj <esc>

" syntax off
syntax on

set termguicolors

" set background=dark
set background=light


" let g:PaperColor_Theme_Options = {
"   \   'theme': {
"   \     'default.dark': {
"   \       'transparent_background': 1
"   \     }
"   \   }
"   \ }
colorscheme Papercolor


"
" TERMINAL
"
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

let g:neoterm_default_mod = ''
let g:neoterm_automap_keys = ',tt'
" let g:neoterm_autoinsert = 1
let g:neoterm_autoscroll = 1
let g:neoterm_size = ''
let g:neoterm_direct_open_repl = 0
let g:neoterm_auto_repl_cmd = 0


" Clojure

lua <<EOF
function FirstTermOfTabJobId()
  local t_id = vim.api.nvim_get_current_tabpage()
  for _, w_id in ipairs(vim.api.nvim_tabpage_list_wins(t_id)) do
    local b_id = vim.api.nvim_win_get_buf(w_id)
    if vim.api.nvim_buf_get_option(b_id, 'buftype') == 'terminal' then
      return b_id, vim.api.nvim_buf_get_var(b_id, 'terminal_job_id')
    end
  end
end

function REPLSend(cmd)
  local b_id, term_id = FirstTermOfTabJobId()
  vim.api.nvim_call_function('jobsend', {term_id, cmd..'\n'})
  local w_id = vim.api.nvim_call_function('bufwinnr', {b_id})
  vim.api.nvim_command(w_id .. "windo normal! G")
  vim.api.nvim_command(w_id .. "wincmd p")
end
EOF

function! REPLSendForm()
let save_pos = getpos(".")
lua <<EOF
  vim.api.nvim_command('silent norm vab"ay')
  local cmd = vim.api.nvim_call_function('getreg', {'a'})
  REPLSend(cmd)
EOF
call setpos(".", save_pos)
endfunction

function! REPLSendForm()
lua <<EOF
  vim.api.nvim_command('silent norm vaf"ay')
  local cmd = vim.api.nvim_call_function('getreg', {'a'})
  REPLSend(cmd)
EOF
endfunction

function! REPLSendTopForm()
lua <<EOF
  vim.api.nvim_command('silent norm vaF"ay')
  local cmd = vim.api.nvim_call_function('getreg', {'a'})
  REPLSend(cmd)
EOF
endfunction

function! REPLSend(cmd)
  call luaeval('REPLSend(_A)', a:cmd)
endfunction

" If no visual selection, send safely
nnoremap <localleader>f :call REPLSendForm()<cr>
" If no visual selection, send safely the Top form
nnoremap <localleader>F :call REPLSendTopForm()<cr>
" If there's a visual selection, just send it
vnoremap <localleader>f "ay:call REPLSend(@a)<cr>
" Send the entire buffer
" nnoremap <localleader>b :call REPLSend("(clojure.core/load-file \"".expand('%:p')."\")")<cr>
" Get docs
" nnoremap <localleader>d :call REPLSend("(clojure.repl/doc ".expand("<cword>").")")<cr>
let g:conjure#mapping#doc_word = ["<localleader>d"]


vnoremap <localleader>sl :TREPLSendLine<CR>
vnoremap <localleader>sl :TREPLSendSelection<CR>
nnoremap <F12> :Ttoggle<CR>
inoremap <F12> <esc>:Ttoggle<CR>
tnoremap <F12> <C-\><C-n>:Ttoggle<CR>
" tnoremap <esc> <C-\><C-n>

" nvr
if has('nvim')
  let $VISUAL = 'nvr -cc split --remote-wait-silent'
endif
cnoreabbrev qq w<bar>bd


"
" FZF
"
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


"
" TAGS
"
" command! -bang -nargs=* JTags call fzf#vim#tags('^' . expand('<cword>'), {'options': '--exact --select-1 --exit-0 +i'})
" :nnoremap <C-]> :JTags ^<c-r><c-w><cr>
:nnoremap <C-]> g<C-]>

" gutentags
set wildignore+=node_modules/*
let g:gutentags_ctags_exclude_wildignore = 1

"
" COMMAND MODE
"
" command mode
" cnoremap <C-a> <Home>
" cnoremap <C-e> <End>
" cnoremap <C-p> <Up>
" cnoremap <C-n> <Down>
" cnoremap <C-b> <Left>
" cnoremap <C-f> <Right>
" cnoremap <M-b> <S-Left>
" cnoremap <M-f> <S-Right>


"
" VIM TEST
"
let test#strategy = 'basic'
let test#filename_modifier = ':p'
nmap <silent> <localleader>t :TestNearest<CR>
nmap <silent> <localleader>T :TestFile<CR>
nmap <silent> <localleader>ta :TestSuite<CR>
nmap <silent> <localleader>tl :TestLast<CR>
nmap <silent> <localleader>tg :TestVisit<CR>
autocmd BufWinEnter quickfix AnsiEsc


"
" COC COMPLETION
"
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

" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
inoremap Tab <Plug>(parinfer-tab)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

let $NVIM_COC_LOG_LEVEL = 'debug'
let g:coc_default_semantic_highlight_groups = 1


"
" UTILS
"
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
  else
    set rnu
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

autocmd BufWritePre * %s/\s\+$//e

" elixir
let g:mix_format_on_save = 1

" git blame
nnoremap <Leader>gb :tabnew term://git blame --date short %<cr>

" copy current filepath and line
nnoremap y. :let @+ = expand("%") . ':' . line(".")<cr>
