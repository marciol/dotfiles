if !has("gui_vimr")
  " Fuzzy-find files with fzf
  map <C-p> :GonvimFuzzyFiles<cr>
  nmap <C-p> :GonvimFuzzyFiles<cr>

  " Fuzzy-find buffers with fzf
  map <C-b> :GonvimFuzzyBuffers<cr>
  nmap <C-b> :GonvimFuzzyBuffers<cr>

  map <C-/> :GonvimFuzzyAg<cr>
  nmap <C-/> :GonvimFuzzyAg<cr>

  noremap d <Nop>
  noremap dd dd
  noremap cw cw

  let g:gonvim_draw_split = 0
  let g:gonvim_draw_statusline = 0
  let g:gonvim_draw_lint = 0
endif

colorscheme gotham

:GuiFont Menlo-Regular:h15
