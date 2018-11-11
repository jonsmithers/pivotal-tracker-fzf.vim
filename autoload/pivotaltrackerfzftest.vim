function! pivotaltrackerfzftest#mock_curl()
  call system('echo') " set v:shell_error
  return '[
        \ {"id": 1339, "name": "Profit"},
        \ {"id": 1338, "name": "Build the Death Star"},
        \ {"id": 1337, "name": "Make a sandwich"},
        \ {"id": 1336, "name": "Draw 7 red lines, all strictly perpendicular"},
        \ {"id": 1335, "name": "Write some code"},
        \]'
endfunction
