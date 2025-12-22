" Maintainer:	drwadu <alamzan94@live.de>
" Last Change:	2025 Dec 22

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

" vim: sw=2
