" Maintainer:	drwadu <alamzan94@live.de>
" Last Change:	2026 Jan 12

hi clear Normal
set background=light
"hi Normal           guifg=#000000 guibg=#f2f2f2

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let colors_name = "default"
hi Statement guifg=NvimDarkMagenta cterm=None gui=None
hi Title guifg=NvimDarkMagenta cterm=None gui=None
hi Todo guifg=NvimDarkMagenta cterm=None gui=None
hi Constructor guifg=NvimDarkBlue
hi Function guifg=NvimDarkBlue
hi StatusLine guibg=None

" vim: sw=2
