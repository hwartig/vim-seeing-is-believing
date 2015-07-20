let s:old_lazyredraw = &lazyredraw
let s:mark_str = ' # =>'

function! seeing_is_believing#run(mode) range "{{{
  if     a:mode == 'n'
    let range_str = '%'
  elseif a:mode == 'v'
    let range_str = "'<,'>"
  elseif a:mode == 'i'
    let range_str = '%'
  end
  let cursor_pos = getpos(".")
  let wintop_pos = getpos('w0')
  set lazyredraw
  execute ":" . range_str . "!seeing_is_believing -x"
  call setpos('.', wintop_pos)
  normal! zt
  call setpos('.', cursor_pos)
  let &lazyredraw = s:old_lazyredraw
  redraw
endfun "}}}

function! seeing_is_believing#toggle_mark(mode) range "{{{
  let cursor_pos = getpos('.')
  let wintop_pos = getpos('w0')
  let lines = getline(a:firstline, a:lastline)
  let max = s:GetMaxLength(lines)

  set lazyredraw
  for line in range(a:firstline, a:lastline)
    let org_line = getline(line)
    if empty(org_line)
      continue
    endif

    let length = len(org_line)
    let spaces = max - length
    let marked = strridx(org_line, s:mark_str)

    if marked != -1
      " remove mark and trailing spaces
      let new_line = s:RemoveMark(org_line, marked)
    else
      " add mark
      let new_line = org_line . repeat(' ', spaces) . s:mark_str
    endif
    call setline(line, new_line)
  endfor
  call setpos('.', wintop_pos)
  normal! zt
  call setpos('.', cursor_pos)
  let &lazyredraw = s:old_lazyredraw
  redraw
endfun "}}}

function! seeing_is_believing#run_visual() range "{{{
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)

  let max = s:GetMaxLength(lines)
  let annotated_lines = s:AnnotateLines(lines, max)

  let @x = join(annotated_lines, "\n")
  normal! gv
  normal! "xP
  call seeing_is_believing#run('n')
endfun "}}}

function! s:AnnotateLines(lines, max) "{{{
  let i = 0

  let new_lines = []
  for line in a:lines
    if empty(line)
      call add(new_lines, line)
    else
      let mark_pos = strridx(line, s:mark_str)
      let line = s:RemoveMark(line, mark_pos)
      let spaces = a:max - len(line)
      let new_line = line . repeat(' ', spaces) . s:mark_str
      call add(new_lines, new_line)
    endif
  endfor

  return new_lines
endfun "}}}

function! s:RemoveMark(line, mark_position)
  if a:mark_position >= 0
    " remove mark
    let new_line = strpart(a:line, 0, a:mark_position)
    " remove trailing spaces
    let new_line = substitute(new_line, '\s\+$', '', '')
  else
    let new_line = a:line
  endif
  return new_line
endfunction

function! s:GetMaxLength(lines) "{{{
  let i = 0
  let max = 0

  for line in a:lines
    " don't count marks
    let line =  substitute(line, '\s*# =>.*$', '', '')
    let length = len(line)
    if length > max
      let max = length
    endif
  endfor
  return max
endfun "}}}
" vim: foldmethod=marker
