let s:mock_response = 0 " for testing

if (s:mock_response)
  let $PIVOTAL_TRACKER_TOKEN = 1
  let $PIVOTAL_TRACKER_PROJECT_ID = 2
endif

function! pivotaltrackerfzf#insert_ids()
  if (!exists('*fzf#run()'))
    echoerr 'FZF plugin not installed'
    return ''
  endif
  if (empty($PIVOTAL_TRACKER_TOKEN))
    echoerr '$PIVOTAL_TRACKER_TOKEN not defined' 
    return ''
  endif
  if (empty($PIVOTAL_TRACKER_PROJECT_ID))
    echoerr '$PIVOTAL_TRACKER_PROJECT_ID not defined' 
    return ''
  endif
  let s:config = s:grab_config()
  let l:filter = substitute(s:config.filter, '"', '\\"', 'g')
  let l:cmd = 'curl 
        \ -sfG -X GET 
        \ -H "X-TrackerToken: $PIVOTAL_TRACKER_TOKEN" 
        \ --data-urlencode "filter=' . l:filter . '"
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

  let l:fzf_args = {'source': l:result, 'sink*': funcref('s:sink'), 'options': '--multi'}
  if (exists('*fzf#wrap()'))
    let l:fzf_args = fzf#wrap(l:fzf_args)
  endif
  call fzf#run(l:fzf_args)
  return exists('s:result') ? s:result : ''
endfunction

func! s:sink(selection)
  if (len(a:selection) == 0)
    return ''
  endif
  let l:result = map(a:selection, {index, issue -> s:config.prefix_each . matchstr(issue, '^\d\+') . s:config.suffix_each})
  let l:result = s:config.prefix . join(l:result, s:config.delimiter) . s:config.suffix
  let s:result = l:result
endfunc

func! s:grab_config() abort
  let l:config = {
        \ 'filter':      '-state:accepted -state:unscheduled',
        \ 'prefix':      '[',
        \ 'prefix_each': '#',
        \ 'suffix_each': '',
        \ 'suffix':      ']',
        \ 'delimiter':   ',',
        \ }

  if (exists('g:pivotaltracker'))
    call extend(l:config, g:pivotaltracker)
  endif
  return l:config
endfunc
