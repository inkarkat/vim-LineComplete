LINE COMPLETE
===============================================================================
_by Ingo Karkat_

DESCRIPTION
------------------------------------------------------------------------------

The built-in i\_CTRL-X\_CTRL-L line completion allows to quickly grab entire
lines, but you have to know and type the first characters as a completion
base. That's bad if the start is difficult to type (e.g. because of comment
prefixes) or the key differentiating word only comes late in the line. On the
other hand, any indent is ignored, so you cannot reduce the number of matches
even if you know that the indent of the desired line is the same as the
current one.

This plugin offers an alternative full-line completion that considers any
existing indent, and lifts the restriction that matches must _start_ with the
completion base. Instead, the WORDs of the base can appear anywhere in the
line, with fallbacks allowing other WORDs in between or even the WORDs
appearing anywhere inside the line.

### SEE ALSO

- Check out the CompleteHelper.vim plugin page ([vimscript #3914](http://www.vim.org/scripts/script.php?script_id=3914)) for a full
  list of insert mode completions powered by it.

USAGE
------------------------------------------------------------------------------

    In insert mode, invoke the line completion via CTRL-X l
    You can then search forward and backward via CTRL-N / CTRL-P, as usual.

    CTRL-X l                Find matches for whole lines that have the same indent
                            as the current line (only if any exists!) and match
                            the text before the cursor (not necessarily at the
                            start), falling back to a match of all WORDs before
                            the cursor (possibly with other text in between each,
                            but still in the given order), first as
                            space-separated WORDs, finally accepting matches
                            anywhere.

                            In contrast, the built-in i_CTRL-X_CTRL-L always
                            ignores the indent. This completion is stricter if
                            indent is given (it must match exactly), but otherwise
                            much more loose, because the completion base need not
                            specify the start of the line.
                            If you don't want the indent restriction, use
                            i_CTRL-U before typing the completion base to clear
                            any indent.

                            Further use of CTRL-X l will copy the line after the
                            one that has been completed.

INSTALLATION
------------------------------------------------------------------------------

The code is hosted in a Git repo at
    https://github.com/inkarkat/vim-LineComplete
You can use your favorite plugin manager, or "git clone" into a directory used
for Vim packages. Releases are on the "stable" branch, the latest unstable
development snapshot on "master".

This script is also packaged as a vimball. If you have the "gunzip"
decompressor in your PATH, simply edit the \*.vmb.gz package in Vim; otherwise,
decompress the archive first, e.g. using WinZip. Inside Vim, install by
sourcing the vimball or via the :UseVimball command.

    vim LineComplete*.vmb.gz
    :so %

To uninstall, use the :RmVimball command.

### DEPENDENCIES

- Requires Vim 7.0 or higher.
- Requires the ingo-library.vim plugin ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)), version 1.010 or
  higher.
- Requires the CompleteHelper.vim plugin ([vimscript #3914](http://www.vim.org/scripts/script.php?script_id=3914)), version 1.50 or
  higher.

CONFIGURATION
------------------------------------------------------------------------------

For a permanent configuration, put the following commands into your vimrc:

By default, the 'complete' option controls which buffers will be scanned for
completion candidates. You can override that either for the entire plugin, or
only for particular buffers; see CompleteHelper\_complete for supported
values.

    let g:LineComplete_complete = '.,w,b,u'

If you want to use a different mapping, map your keys to the
&lt;Plug&gt;(LineComplete) mapping target _before_ sourcing the script
(e.g. in your vimrc):

    imap <C-x>l <Plug>(LineComplete)

CONTRIBUTING
------------------------------------------------------------------------------

Report any bugs, send patches, or suggest features via the issue tracker at
https://github.com/inkarkat/vim-LineComplete/issues or email (address below).

HISTORY
------------------------------------------------------------------------------

##### 1.01    RELEASEME
- Use a:options.abbreviate instead of explicit abbreviation loop.

__You need
  to update to CompleteHelper.vim ([vimscript #3914](http://www.vim.org/scripts/script.php?script_id=3914)) version 1.50!__
- Remove default g:LineComplete\_complete configuration and default to
  'complete' option value instead.

##### 1.00    04-Apr-2014
- First published version.

##### 0.01    31-Mar-2014
- Started development.

------------------------------------------------------------------------------
Copyright: (C) 2014-2022 Ingo Karkat -
The [VIM LICENSE](http://vimdoc.sourceforge.net/htmldoc/uganda.html#license) applies to this plugin.

Maintainer:     Ingo Karkat &lt;ingo@karkat.de&gt;
