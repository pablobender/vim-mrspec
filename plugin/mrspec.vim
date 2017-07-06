" TODO: custom rspec command for makeprg option

if exists('s:loaded')
  finish
endif

let s:loaded = 1

function! mrspec#RunLine()
  if s:InSpecFile()
    call s:SetSpecLocation(expand('%'), line('.'))
    return s:RunSpec('Running spec(s) for line: ' . s:location)
  endif
  echo '*** Current buffer isn''t a spec. (' . expand('%') . ')'
endfunction

function! mrspec#RunFile()
  if s:InSpecFile()
    call s:SetSpecLocation(expand('%'))
    return s:RunSpec('Running spec(s) from file: ' . s:location)
  endif
  echo '*** Current buffer isn''t a spec. (' . expand('%') . ')'
endfunction

function! mrspec#RunAll()
  call s:SetSpecLocation()
  return s:RunSpec('Running all specs')
endfunction

function! mrspec#Run()
  if exists('s:location')
    let l:location = s:location
    if l:location == ''
      let l:location = '*all specs*'
    endif
    return s:RunSpec('Running last spec(s): ' . l:location)
  endif
  return mrspec#RunAll()
endfunction

command MRSpecLine call mrspec#RunLine()
command MRSpecFile call mrspec#RunFile()
command MRSpecAll call mrspec#RunAll()
command MRSpec call mrspec#Run()

function! s:SetMakeprg()
  let s:currentMakeprg = &makeprg
  set makeprg=rspec
endfunction

function! s:RestoreMakeprg()
  execute 'set makeprg=' . s:currentMakeprg
endfunction

function! s:InSpecFile()
  return match(expand('%'), '_spec.rb$') != -1
endfunction

function! s:IsModified(buffer)
  return getbufvar(a:buffer, '&mod')
endfunction

function! s:SetSpecLocation(...)
  let s:location = ''

  if exists('a:1')
    let s:spec = a:1
    let s:location .= s:spec
  endif

  if exists('a:2')
    let l:line = a:2
    let s:location .= ':' . l:line
  endif
endfunction

function! s:RunSpec(message)
  if s:IsModified(s:spec)
    echo '*** Buffer is modified! Please save it to run. (' . s:spec . ')'
    return 0
  endif
  call s:SystemEcho(a:message)
  call s:SetMakeprg()
  execute 'make! ' . s:location  . '|cwindow'
  call s:RestoreMakeprg()
  return 1
endfunction

function! s:SystemEcho(msg)
  silent execute '!echo ""'
  silent execute '!echo "\#"'
  silent execute '!echo "\# MRSpec: ' . a:msg '"'
  silent execute '!echo "\#"'
endfunction
