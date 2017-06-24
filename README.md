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

## Tips

If you think the commands too long or would like another commands, just put something like below into your `~/.vimrc` file.

```
command RL call mrspec#RunLine()
command RF call mrspec#RunFile()
command RA call mrspec#RunAll()
command R call mrspec#Run()
```

Now you can simple execute `:RL`, `:RF`, `RA` and `:R` to run each function, respectively.

## Installation

You may install as you prefer. I like [Vundle](https://github.com/VundleVim/Vundle.vim).

Put it into your Vundle configuration:

```
Bundle "pablobender/vim-mrspec.git"
```

If you use [pathogen](https://github.com/tpope/vim-pathogen) as plugin manager, just unpack or clone the repository in your `~/.vim/bundle` dir (creating a subfoler, eg: `~/.vim/bundle/vim-mrspec`).

But if you don't use a plugin manager, you can download the source code and put it into your `~/.vim`. Make sure to put the contents of `vim-mrspec` folder into your `~/.vim`, not create a new `vim-mrspec` under it.

## Requirements

MRSpec is a pure vimscript plugin, but only make sense if you are working on ruby/rspec project. So you need be able to run `rspec` on your terminal for your project.

## License

MIT
