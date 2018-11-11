> ### 🛠 Status: Under Construction
> This plugin is liable to make breaking changes.

[![PivotalTracker logo](https://assets.pivotaltracker.com/marketing_assets/shared_home/tracker-4679313e699d9ba696371344953de96c81d207d967a43f121d353391c81c9ba7.svg)](https://pivotaltracker.com)

## Fuzzy-Find and Insert Issue IDs in Vim

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

Then, while in insert mode, press `Ctrl-X Ctrl-P` to open the fzf prompt, and
[make your selection](https://github.com/junegunn/fzf#using-the-finder).

### Mappings

You can map a custom keybinding to `<Plug>pivotaltracker-insert-ids`.

```vim
inoremap <Leader>p <Plug>pivotaltracker-insert-ids
```

### Environment Variables 101

You can set environment variables from within vim:

```vim
:let $PIVOTAL_TRACKER_PROJECT_ID='...'
:let $PIVOTAL_TRACKER_TOKEN='...'
```

Or you can set them from the terminal:

```bash
export PIVOTAL_TRACKER_TOKEN=<token>
export PIVOTAL_TRACKER_PROJECT_ID=<id>
vim
```

```bash
PIVOTAL_TRACKER_TOKEN=<token> PIVOTAL_TRACKER_PROJECT_ID=<id> vim
```

Or you can set them automatically with a handy tool such as
[***direnv***](https://direnv.net/) or
[***vim-dotenv***](https://github.com/tpope/vim-dotenv).
