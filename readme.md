> ### 🛠 Status: Under Construction
> This plugin is liable to make breaking changes.

Simple vim plugin to fuzzy-find PivotalTracker issues by name and then insert
ids of issues you selected.

### Installation

```vim
Plug 'junegunn/fzf.vim'
Plug 'jonsmithers/pivotal-tracker-fzf.vim'
```

### Usage


Make sure the following environment variables are defined:

| variable                      | source                            |
| ---                           | ---                               |
| `$PIVOTAL_TRACKER_PROJECT_ID` | Can be obtained from project url  |
| `$PIVOTAL_TRACKER_TOKEN`      | Can be obtained from user profile |

While not recommended, you _can_ defined environment variables with vimscript:

```vim
let $PIVOTAL_TRACKER_PROJECT_ID='...'
let $PIVOTAL_TRACKER_TOKEN='...'
```

Then, whenever you're in insert mode, press `Ctrl-X Ctrl-P` to open the fzf
(fuzzy-find) prompt. Info on how to use fzf can be found
[here](https://github.com/junegunn/fzf#using-the-finder).
