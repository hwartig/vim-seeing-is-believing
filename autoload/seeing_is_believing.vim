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
  set nolazyredraw
  redraw
endfun "}}}

function! seeing_is_believing#toggle_mark(mode) range "{{{
  let mark_str = " # =>"
  let cursor_pos = getpos(".")
  let wintop_pos = getpos('w0')
  set lazyredraw
  for line in range(a:firstline,a:lastline)
    let org_line = getline(line)
    let marked = strridx(org_line, mark_str)
    let new_line = marked != -1
          \ ? strpart(org_line, 0, marked)
          \ : org_line . mark_str
    call setline(line, new_line)
  endfor
  call setpos('.', wintop_pos)
  normal zt
  call setpos('.', cursor_pos)
  set nolazyredraw
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
    let spaces = (a:max - length) + 1
    if length > 0
      let a:lines[i] .= repeat(" ", spaces) . " # => "
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


