This plugin is under construction and liable to breaking changes.

Simple vim plugin to fuzzy-find PivotalTracker issues by name and then insert
ids of issues you selected.

### Installation

```vim
Plug 'junegunn/fzf.vim'
Plug 'jonsmithers/pivotal-tracker-fzf.vim'
```

### Usage


Make sure the following environment variables are defined:

| variable                      | source                           |
| ---                           | ---                              |
| `$PIVOTAL_TRACKER_TOKEN`      | Can be obtained from profile     |
| `$PIVOTAL_TRACKER_PROJECT_ID` | Can be obtained from project url |

Then, while in insert mode, press `Ctrl-X Ctrl-P` to open fuzzy-find prompt.
