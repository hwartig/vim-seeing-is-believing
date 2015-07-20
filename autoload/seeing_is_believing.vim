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
  let cursor_pos = getpos(".")
  let wintop_pos = getpos('w0')
  let lines = getline(a:firstline, a:lastline)
  let max = GetMaxLength(lines)

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
      " remove mark
      let new_line = strpart(org_line, 0, marked)
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

function! seeing_is_believing#visual() range "{{{
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)

  let max = GetMaxLength(lines)
  let annotated_lines = AnnotateLines(lines, max)

  let @x = join(annotated_lines, "\n")
  normal! gv
  normal! "xP
  call seeing_is_believing#run('n')
endfun "}}}

function! AnnotateLines(lines, max) "{{{
  let i = 0

  while i < len(a:lines)
    let length = len(a:lines[i])
    let spaces = a:max - length
    if length > 0
      let a:lines[i] .= repeat(" ", spaces) . s:mark_str
    endif
    let i += 1
  endwhile

  return a:lines
endfun "}}}

function! GetMaxLength(lines) "{{{
  let i = 0
  let max = 0

  while i < len(a:lines)
    let length = len(a:lines[i])
    if length > max
      let max = length
    endif
    let i += 1
  endwhile

  return max
endfun "}}}
" vim: foldmethod=marker
