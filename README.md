# MRSpec

A simple [Vim](http://www.vim.org) plugin to execute [RSpec](http://rspec.info) through :make command.

## Motivation

Run `rspec` inside [Vim](http://www.vim.org) and ouptut of failing specs into [quickfix window (:cwindow)](http://vimdoc.sourceforge.net/htmldoc/quickfix.html). Also be able to run the spec/context/describe where the cursor is.

## Features/Usage

To run the nearest spec/context/describe where the cursor is.

```
:MRSpecLine
```

To run specs for the current spec file.

```
:MRSpecFile
```

To run all specs.

```
:MRSpecAll
```

To re-execute the last spec location (line, file or all). It can be called out of a spec file. Useful when you fix a failing spec in production source file.

```
:MRSpec
```

## Installation

You may install as you prefer. I like [Vundle](https://github.com/VundleVim/Vundle.vim).

Put it into your Vundle configuration:

```
Bundle "pablobender/vim-mrspec.git"
```

But if you don't use a plugin manager, you can download the source code and put it into your `~/.vim`. Make sure to put the contents of `vim-mrspec` folder into your `~/.vim`, not create a new `vim-mrspec` under it.

## Requirements

MRSpec is a pure vimscript plugin, but only make sense if you are working a ruby/rspec project. So you need be able to run `rspec` on your terminal.
