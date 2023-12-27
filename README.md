# RedAlert.nvim

A simple plugin for neovim that makes some checks and display a warning message on startup.

## Setup

### Dependencies

- plenary.nvim

### Configuration

- `cutoff_days = <N>`: displays a message on startup if the current repository is "dirty" (files uncommitted) and the latest commit is older than N days

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

### With packer.nvim

```lua
use {
    'waltr-fr/redalert.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
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
