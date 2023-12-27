# RedAlert.nvim

A simple plugin for neovim that makes some checks and display a warning message on startup.

## Setup

### Configuration

- `cutoff_days = <N>`: displays a message if the current repository is "dirty" (files uncommitted) and the latest commit is older than N days

### With lazy.nvim

```lua
{ 
  'waltr-fr/redalert.nvim'
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
      require("redalert").setup({
      cutoff_days = 5, 
    })
  end,
}
```

### Basic

```lua
local redalert = require('redalert')

redalert.setup({
    cutoff_days = 5,
})
```
## TODO

- [ ] more alerts
- [ ] more visible message, popup maybe
