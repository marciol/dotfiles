call plug#begin("~/.local/share/nvim/plugged")
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-vinegar'
  Plug 'clinstid/eink.vim'
  Plug 'romainl/vim-qf'
  Plug 'wsdjeg/vim-fetch'

  Plug 'ludovicchabant/vim-gutentags'
  Plug 'majutsushi/tagbar'

  Plug 'junegunn/seoul256.vim'

  Plug 'mmorearty/elixir-ctags'
  Plug 'elixir-editors/vim-elixir'
  Plug 'mhinz/vim-mix-format'
  Plug 'danchoi/elinks.vim'
  Plug 'mattn/emmet-vim'


  Plug 'equalsraf/neovim-gui-shim'
  if !has("gui_vimr")
    Plug 'dzhou121/gonvim-fuzzy'
  endif
call plug#end()

let mapleader = ","

let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

set showcmd                 " Show (partial) command in status line.
set showmatch               " Show matching brackets.
set showmode                " Show current mode.
set ruler                   " Show the line and column numbers of the cursor.
set number                  " Show the line numbers on the left side.
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

" deoplete
let g:deoplete#enable_at_startup = 0
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

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

" Make terminal live on hidden buffers
autocmd TermOpen * set bufhidden=hide

" Open terminal in insert mode
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

" Open terminal
command! -nargs=* T 10split | startinsert | terminal <args>
command! -nargs=* VT 10split | startinsert | terminal <args>

" REPL
function! SendLinesToREPL(lines)
    if g:terminal_id
        call jobsend(g:terminal_id, add(a:lines, ''))
    else
        echo "Can't find any open terminals"
    endif
endfunction
nnoremap <expr> <silent> <leader>sl SendLinesToREPL([getline('.')])
vnoremap <expr> <silent> <leader>sl SendLinesToREPL(getline(line('v'), line('.')))

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

" Fuzzy-find files with fzf
map <C-p> :Files<cr>
nmap <C-p> :Files<cr>

" Fuzzy-find buffers with fzf
map <C-b> :Buffers<cr>
nmap <C-b> :Buffers<cr>

" Fuzzy-find tags
map <Leader>t :BTags<cr>
nmap <Leader>t :BTags<cr>

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

" set background=dark
set background=light

" colorscheme gotham
" colorscheme nofrils-dark

let g:seoul256_background = 236
let g:seoul256_light_background = 256
colorscheme seoul256
" colorscheme seoul256-light

" syntax off
" hi visual term=standout ctermfg=0 ctermbg=DarkBlue
" hi TabLine term=standout cterm=none ctermfg=DarkBlue ctermbg=0
" hi TabLineSel term=bold cterm=bold ctermfg=0 ctermbg=DarkBlue
" hi TabLineFill cterm=none ctermbg=0
" hi Search term=standout cterm=none ctermfg=0 ctermbg=DarkBlue
" hi IncSearch term=standout cterm=none ctermfg=0 ctermbg=DarkBlue
" hi MatchParen term=standout cterm=none ctermfg=0 ctermbg=DarkBlue

" syntax off
" set nonu
" set background=light
" colorscheme default

let g:gonvim_draw_split = 0
let g:gonvim_draw_statusline = 0
let g:gonvim_draw_lint = 0

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
