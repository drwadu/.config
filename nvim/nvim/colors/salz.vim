" Maintainer:	drwadu <spirida@mailbox.org>
" Last Change:	2026 May

hi clear Normal
set bg&

hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let colors_name = "default"
hi Statement guifg='#bfc9c9' cterm=None gui=None
hi Title guifg='#bfc9c9' cterm=None gui=None
hi Todo guifg='#bfc9c9' cterm=None gui=None
hi Constructor guifg=NvimLightBlue
hi Function guifg=NvimLightBlue
hi StatusLine guibg=None
hi LineNr guibg=#000000 guifg=#faf0f7
hi CursorLineNr guibg=#000000 guifg=#fc0303
hi Normal guibg=#000000 ctermbg=0
hi NonText guibg=#000000 ctermbg=0

" vim: sw=2
