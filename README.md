What is this?
==================================
vim-seeing-is-believing provides utility functions which make the following easy

* insert/delete annotation mark `# =>`.
* virtual keymap for marking and executing [seeing-is-believing](https://github.com/JoshCheek/seeing_is_believing) against current buffer.

seeing_is_believing is a gem and can be installed with 

    $ gem install seeing_is_believing

Configuration
==================================
vim-seeing-is-believing doesn't provide any default keymap.
Set following line in your `.vimrc`

    " Gvim
    nmap <buffer> <M-r> <Plug>(seeing-is-believing-run)
    xmap <buffer> <M-r> <Plug>(seeing-is-believing-run)
    imap <buffer> <M-r> <Plug>(seeing-is-believing-run)

    nmap <buffer> <M-m> <Plug>(seeing-is-believing-mark)
    xmap <buffer> <M-m> <Plug>(seeing-is-believing-mark)
    imap <buffer> <M-m> <Plug>(seeing-is-believing-mark)

    " Terminal
    nmap <buffer> <F5> <Plug>(seeing-is-believing-run)
    xmap <buffer> <F5> <Plug>(seeing-is-believing-run)
    imap <buffer> <F5> <Plug>(seeing-is-believing-run)

    nmap <buffer> <F4> <Plug>(seeing-is-believing-mark)
    xmap <buffer> <F4> <Plug>(seeing-is-believing-mark)
    imap <buffer> <F4> <Plug>(seeing-is-believing-mark)

Kudos
==================================
vim-seeing-is-believing is an adaption of https://github.com/t9md/vim-ruby-xmpfilter for seeing_is_believing.
