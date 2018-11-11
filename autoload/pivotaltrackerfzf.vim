function! pivotaltrackerfzf#do_the_thing()
  if (empty($PIVOTAL_TRACKER_TOKEN))
    echoerr '$PIVOTAL_TRACKER_TOKEN not defined' 
    return ''
  endif
  if (empty($PIVOTAL_TRACKER_PROJECT_ID))
    echoerr '$PIVOTAL_TRACKER_PROJECT_ID not defined' 
    return ''
  endif
  let l:cmd = 'curl 
        \ -sfG -X GET 
        \ -H "X-TrackerToken: $PIVOTAL_TRACKER_TOKEN" 
        \ --data-urlencode "filter=-state:accepted -state:unscheduled" 
        \ --data-urlencode fields=name https://www.pivotaltracker.com/services/v5/projects/$PIVOTAL_TRACKER_PROJECT_ID/stories'
  let l:result = system(l:cmd)
  if (empty(l:result) || v:shell_error != 0)
    echoerr 'Failed to reach PivotalTracker'
    return ''
  endif
  let l:result = json_decode(l:result)
  let l:result = map(l:result, {index, issue -> (string(issue.id) . ' ' . string(issue.name))})
  call fzf#run({'source': l:result, 'sink*': funcref('s:sink'), 'options': '--multi'})
  return s:result
endfunction

func! s:sink(selection)
  if (len(a:selection) == 0)
    return ''
  endif
  let l:result = map(a:selection, {index, issue -> '#' . matchstr(issue, '^\d\+')})
  let l:result = '[' . join(l:result, ',') . ']'
  let s:result = l:result
endfunc
