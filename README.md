# Dew Crumb

🌿 **Dew Crumb** is a minimal, focused [Neorg](https://github.com/nvim-neorg/neorg) extension designed to display a dynamic breadcrumb navigation bar based on the document title and headings.

This module is part of the [Neorg Dew](https://github.com/setupyourskills/neorg-dew) ecosystem.

## Features

- Displays a dynamic breadcrumb showing the current heading structure along with the top-level title of your Neorg notes.
- Lightweight and easily customizable.

## Installation

### Prerequisites

- A functional installation of [Neorg](https://github.com/nvim-neorg/neorg) is required for this module to work.
- The core module [Neorg Dew](https://github.com/setupyourskills/neorg-dew) must be installed, as it provides essential base libraries.

### Using Lazy.nvim

```lua
{
  "setupyourskills/dew-crumb",
  ft = "norg",
  dependencies = {
    "setupyourskills/neorg-dew",
  },
}
```

## Configuration

Make sure all of them are loaded through Neorg’s module system in your config:

```lua
["external.neorg-dew"] = {},
["external.dew-crumb"] = {
    config = {
        enabled = true, -- Enable or disable the module on startup
    },
},
```

## Usage

You can enable or disable the breadcrumb module using the following Neorg commands:

```
:Neorg dew_crumb enable
:Neorg dew_crumb disable
```

## How it works

The breadcrumb updates automatically as you move the cursor within `.norg` files, showing the current heading path in the `winbar`.

## Collaboration and Compatibility

This project embraces collaboration and may build on external modules created by other Neorg members, which will be tested regularly to ensure they remain **functional** and **compatible** with the latest versions of Neorg and Neovim.  

## Why **dew**?

Like morning dew, it’s **subtle**, **natural**, and brief, yet vital and effective for any workflow.
