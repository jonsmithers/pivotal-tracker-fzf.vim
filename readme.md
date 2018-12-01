> ### 🛠 Status: Under Construction
> This plugin is liable to make breaking changes.

[![PivotalTracker logo](https://assets.pivotaltracker.com/marketing_assets/shared_home/tracker-4679313e699d9ba696371344953de96c81d207d967a43f121d353391c81c9ba7.svg)](https://pivotaltracker.com)

Made to help you reference Pivotal Tracker issues in your git commit messages.

## Demonstration

![Demonstration](https://github.com/jonsmithers/pivotal-tracker-fzf.vim/raw/images/terminalizer/render1541963208390.gif)

## Installation

```vim
Plug 'jonsmithers/pivotal-tracker-fzf.vim'
Plug 'junegunn/fzf' " mandatory dependency
```

## Usage


Make sure the following environment variables are defined:

| variable                      | source                            |
| ---                           | ---                               |
| `$PIVOTAL_TRACKER_PROJECT_ID` | Can be obtained from project url  |
| `$PIVOTAL_TRACKER_TOKEN`      | Can be obtained from user profile |

Then, while in insert mode, press `Ctrl-X Ctrl-I` to open the fzf prompt, and
[make your selection](https://github.com/junegunn/fzf#using-the-finder).

## Customization

### Filtering

You can customize which stories are displayed using the query syntax described
in [Pivotal Tracker's api
docs](https://www.pivotaltracker.com/help/articles/advanced_search/)

```vim
let g:pivotaltracker.filter = 'state:started'
```

### Formatting

The following variables can be changed to configure how issue ids are
formatted:

```vim
let g:pivotaltracker.delimiter         = ','
let g:pivotaltracker.individual_prefix = '#'
let g:pivotaltracker.individual_suffix = ''
let g:pivotaltracker.prefix            = 'addresses '
let g:pivotaltracker.suffix            = ''
```

### Mappings

The default mapping is `Ctrl-X Ctrl-I` (from insert mode), but you can map a
custom keybinding to `<Plug>pivotaltracker-insert-ids`:

```vim
nmap    <Leader>p <Plug>pivotaltracker-insert-ids
iabbrev @P        <Plug>pivotaltracker-insert-ids
```

## Environment Variables 101

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
