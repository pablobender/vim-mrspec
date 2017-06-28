" TODO: custom rspec command for makeprg option

if exists('s:loaded')
  finish
endif

let s:loaded = 1

function! mrspec#RunLine()
  if s:InSpecFile()
    call s:SetSpecLocation(expand('%'), line('.'))
    call s:SystemEcho('Running spec(s) for line: ' . s:location)
    return s:RunSpec()
  endif
  echomsg '*** Current buffer isn''t a spec. (' . expand('%') . ')'
endfunction

function! mrspec#RunFile()
  if s:InSpecFile()
    call s:SetSpecLocation(expand('%'))
    call s:SystemEcho('Running spec(s) from file: ' . s:location)
    return s:RunSpec()
  endif
  echomsg '*** Current buffer isn''t a spec. (' . expand('%') . ')'
endfunction

function! mrspec#RunAll()
  call s:SetSpecLocation()
  call s:SystemEcho('Running all specs')
  return s:RunSpec()
endfunction

function! mrspec#Run()
  if exists('s:location')
    let l:location = s:location
    if l:location = ''
      let l:location = '*all specs*'
    endif
    call s:SystemEcho('Running last spec(s): ' . l:location)
    return s:RunSpec()
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

function! s:RunSpec()
  if s:IsModified(s:spec)
    echomsg '*** Buffer is modified! Please save it to run. (' . s:spec . ')'
    return 0
  endif
  call s:SetMakeprg()
  execute 'make! ' . s:location  . '|cwindow'
  call s:RestoreMakeprg()
  return 1
endfunction

function! s:SystemEcho(msg)
  silent execute '!echo "\n\n\nMRSpec: ' . a:msg '"'
endfunction
