# neorg-dew-crumb

🌿 **neorg-dew-crumb** is a minimal, focused extension for [Neorg](https://github.com/nvim-neorg/neorg),  
designed to display a dynamic breadcrumb navigation bar based on the document title and headings.

---

## Features

- Displays a dynamic breadcrumb showing the current heading structure along with the top-level title of your Neorg notes.
- Lightweight and easily customizable.

---

## Installation

### Prerequisites

- A functional installation of [Neorg](https://github.com/nvim-neorg/neorg) is required for this module to work.
- The core module [Neorg-dew](https://github.com/setupyourskills/neorg-dew) must be installed, as it provides essential base libraries.

### Using Lazy.nvim

```lua
{
  "setupyourskills/neorg-dew-crumb",
  dependencies = {
    "setupyourskills/neorg-dew",
  },
}
