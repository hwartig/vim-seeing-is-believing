"=============================================================================
" File: xmpfilter.vim
" Author: t9md <taqumd@gmail.com>
" WebPage: http://github.com/t9md/vim-ruby-xmpfilter
" License: BSD
" Version: 0.1

" GUARD: {{{
"============================================================

if exists('g:loaded_seeing_is_believing')
  finish
endif
let g:loaded_seeing_is_believing = 1

let s:old_cpo = &cpo
set cpo&vim
"}}}

" KEYMAP: {{{
"=================================================================
nnoremap <silent> <Plug>(seeing-is-believing-run)        :call seeing_is_believing#run('n')<CR>
inoremap <silent> <Plug>(seeing-is-believing-run)   <C-o>:call seeing_is_believing#run('i')<CR>
nnoremap <silent> <Plug>(seeing-is-believing-mark-and-run) :call seeing_is_believing#mark_and_run('n')<CR>
vnoremap <silent> <Plug>(seeing-is-believing-mark-and-run) :call seeing_is_believing#mark_and_run_visual('v')<CR>

nnoremap <silent> <Plug>(seeing-is-believing-mark)      :call seeing_is_believing#toggle_mark('n')<CR>
vnoremap <silent> <Plug>(seeing-is-believing-mark)      :call seeing_is_believing#toggle_mark('v')<CR>
inoremap <silent> <Plug>(seeing-is-believing-mark) <C-o>:call seeing_is_believing#toggle_mark('i')<CR>

" For backward compatibility
vnoremap <silent> <Plug>(seeing-is-believing-run-visual) :call seeing_is_believing#mark_and_run_visual()<CR>
"}}}

let &cpo = s:old_cpo
" vim: foldmethod=marker
