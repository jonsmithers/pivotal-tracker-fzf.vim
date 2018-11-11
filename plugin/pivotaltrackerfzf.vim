inoremap <expr> <Plug>pivotaltracker-insert-ids pivotaltrackerfzf#insert_ids()
nnoremap <expr> <Plug>pivotaltracker-insert-ids pivotaltrackerfzf#insert_ids()

let s:enable_default_mapping =
      \ !exists('g:pivotaltrackerfzf.disable_default_mappings')
      \ && !hasmapto('<Plug>pivotaltracker-insert-ids')

if (s:enable_default_mapping)
  imap <C-x><C-i> <Plug>pivotaltracker-insert-ids
endif
