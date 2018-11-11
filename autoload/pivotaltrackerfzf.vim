let s:mock_response = 0 " for testing

if (s:mock_response)
  let $PIVOTAL_TRACKER_TOKEN = 1
  let $PIVOTAL_TRACKER_PROJECT_ID = 2
endif

function! pivotaltrackerfzf#insert_ids()
  if (!exists('*fzf#run()'))
    echoerr 'FZF plugin not installed'
  endif
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
  let l:result = s:mock_response ? pivotaltrackerfzftest#mock_curl() : system(l:cmd)
  if (empty(l:result) || v:shell_error != 0)
    echoerr 'Failed to reach PivotalTracker'
    return ''
  endif
  let l:result = json_decode(l:result)
  let l:result = map(l:result, {index, issue -> (string(issue.id) . ' ' . string(issue.name))})

  if (exists('s:result'))
    unlet s:result
  endif
  call fzf#run({'source': l:result, 'sink*': funcref('s:sink'), 'options': '--multi'})
  return exists('s:result') ? s:result : ''
endfunction

func! s:sink(selection)
  if (len(a:selection) == 0)
    return ''
  endif
  let l:config = s:grab_config()
  let l:result = map(a:selection, {index, issue -> l:config.individual_prefix . matchstr(issue, '^\d\+') . l:config.individual_suffix})
  let l:result = l:config.prefix . join(l:result, l:config.delimiter) . l:config.suffix
  let s:result = l:result
endfunc

func! s:grab_config()
  let l:config                   = exists('g:pivotaltracker')                   ? g:pivotaltracker                   : {}
  let l:config.prefix            = exists('g:pivotaltracker.prefix')            ? g:pivotaltracker.prefix            : '['
  let l:config.individual_prefix = exists('g:pivotaltracker.individual_prefix') ? g:pivotaltracker.individual_prefix : '#'
  let l:config.individual_suffix = exists('g:pivotaltracker.individual_suffix') ? g:pivotaltracker.individual_suffix : ''
  let l:config.suffix            = exists('g:pivotaltracker.suffix')            ? g:pivotaltracker.suffix            : ']'
  let l:config.delimiter         = exists('g:pivotaltracker.delimiter')         ? g:pivotaltracker.delimiter         : ','
  return l:config
endfunc
