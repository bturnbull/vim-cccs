Pathogen friendly variation of Gary Johnson's [cccs.vim][1] for syntax highlighting of Clearcase Config Specs.

Differences
===========

* Removed highlighting on config spec pname.
* Added file detection by .cs extension or file content.

Installation
============

To install using [Pathogen][2], clone the repo to your bundle directory:

    git clone git://github.com/bturnbull/vim-cccs.git

To install manually, copy the matching cccs.vim to .vim/syntax and .vim/ftdetect (or equivalent).

Issues
======

If you are running a Vim older than 7.3.430 and filetype detection fails (results in a "conf" detection), you may need to apply the patch detailed in [Issue 52][3].

[1]: http://www.spocom.com/users/gjohnson/vim/
[2]: https://github.com/tpope/vim-pathogen
[3]: http://code.google.com/p/vim/issues/detail?id=52
