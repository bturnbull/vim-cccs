Pathogen friendly variation of Gary Johnson's [cccs.vim][1] for syntax highlighting of Clearcase Config Specs.

Differences
===========

* Removed highlighting on config spec pname.
* Added file detection by .cs extension or file content.

Installation
============

To install using [Pathogen][2]:

    cd ${HOME}/.vim/bundle
    git clone git://github.com/bturnbull/vim-cccs.git

To install manually, copy the matching cccs.vim to .vim/syntax and .vim/ftdetect

[1]: http://www.spocom.com/users/gjohnson/vim/
[2]: https://github.com/tpope/vim-pathogen
