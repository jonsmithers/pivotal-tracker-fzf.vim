if (!exists('g:pivotaltrackerfzf.disable_default_mapping'))
  imap <expr> <C-x><C-p> pivotaltrackerfzf#do_the_thing()
endif
