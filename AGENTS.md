# AGENTS.md - Neovim Configuration Guide

High-signal, repo-specific guidance for AI agents. Omits generic Lua/Neovim conventions.

## Critical: This is a Config, Not a Build Project

**No build system exists.** The config loads when Neovim starts. All validation happens through runtime errors and LSP diagnostics.

### Validation Commands
```bash
# Test config loads without errors
nvim --headless -c "lua vim.notify('Config loaded successfully')" -c "qa"

# Check Lua syntax in individual files
lua -c "dofile('path/to/file.lua')"

# Reload within Neovim
:source %  # when in init.lua
:lua require('brady.plugins.lsp-config')  # reload specific module
```

## Directory Structure

```
init.lua              # Entry point, loads lazy.nvim and requires all modules
lua/brady/
├── plugins/          # Each file returns lazy.nvim plugin spec table
├── snippets/         # Luasnip snippets (must add to init.lua to load)
├── keymaps.lua       # Global keybindings
├── options.lua       # Global vim options
└── autocmd.lua       # Autocommands
ftplugin/            # Filetype-specific settings (auto-loaded by Neovim)
plugin/              # Auto-loaded scripts: globals.lua, format.lua
```

## Formatting Quirks (Critical)

### Format-on-Save is Directory-Specific
- `plugin/format.lua` sets `vim.g.format` based on cwd
- **Auto-disables** format-on-save for directories matching `/sportsbookreview/` or `/nssmp/`
- Toggle manually: `<leader>df` (keymaps.lua:62-71)

### Conform vs LSP Formatting
- **Conform.nvim** handles formatting for: JS, TS, JSX, TSX, CSS, SCSS, HTML, JSON, YAML (uses prettier)
- **LSP fallback** for all other filetypes
- Format on save checks `vim.g.format` flag (conform.lua:21-29)
- Manual format: `<leader>fm` (buffer-scoped, added on LspAttach)

## Code Style (Repo-Specific Only)

### Indentation
- **Default**: 4 spaces (options.lua)
- **TypeScript/React**: 2 spaces (ftplugin/typescript.lua, ftplugin/typescriptreact.lua)
- **Never tabs**: expandtab is enabled

### File Naming
- Plugin configs: kebab-case (lsp-config.lua, dap-config.lua)
- Autocmd groups: PascalCase (LspKeymaps, HighlightYank)

### Keymaps
- Leader key: **space** (init.lua:20)
- Always include `desc` for which-key integration
- LSP keymaps: buffer-scoped with `buffer = 0`

## LSP Configuration (Non-Standard Pattern)

### Servers are registered via `vim.lsp.enable()`, not mason-lspconfig's setup handlers
`mason-lspconfig.setup()` only runs `ensure_installed = { "lua_ls" }`; it does NOT wire up servers.
Actual server registration in `lua-config.lua` (lsp-config.lua):
```lua
vim.lsp.enable({
    "lua_ls", "clangd", "gopls", "ts_ls", "jsonls",
    "pyright", "bashls", "dockerls", "cssls", "html", "omnisharp",
    -- add new servers here
})
```
- To add a new LSP server: add it to this list AND install the binary via `:Mason` (or system package manager)
- lazydev.nvim provides Neovim API completions for lua_ls

## Snippets (Must Register Manually)

### Adding New Snippet Files
1. Create `lua/brady/snippets/{language}.lua`
2. **Must add** `require("brady.snippets.{language}")` to `lua/brady/snippets/init.lua`
3. Snippets use luasnip syntax:
```lua
local luasnip = require("luasnip")
local s = luasnip.snippet
local tNode = luasnip.text_node
local iNode = luasnip.insert_node

luasnip.add_snippets("filetype", {
    s("trigger", { tNode("text"), iNode(1, "placeholder") })
})
```

## Global Helper Functions (plugin/globals.lua)

Debugging utilities available in all buffers:
- `:P(obj)` - print vim.inspect(obj)
- `:MP(obj)` - print vim.inspect(getmetatable(obj))
- `:NP(obj)` - vim.notify(vim.inspect(obj))

### Custom Filetype Mappings
- `.env*` files → sh
- `.mdx` → markdown
- `.monk` → monk
- See plugin/globals.lua:21-42 for full list

## Go-Specific Features

### Test File Navigation
- `<leader>at` toggles between `file.go` ↔ `file_test.go` (keymaps.lua:79-100)
- Only works for Go files, prints error otherwise

## Plugin Configuration Pattern

Each file in `lua/brady/plugins/` returns a table with lazy.nvim specs:
```lua
return {
    {
        "user/plugin",
        event = "VeryLazy",  -- lazy load trigger
        config = function()
            -- setup code
        end
    }
}
```

## Common Debug Commands

```vim
:Lazy              # Plugin manager UI
:P(vim.lsp.get_active_clients())  # Check active LSP servers
:lua vim.diagnostic.get(0)        # Get current buffer diagnostics
```

## Filetype-Specific Notes

- **Vue**: Custom commentstring set via autocmd (autocmd.lua:12-19)
- **TypeScript/React**: 2-space indent, ts_ls LSP
- **Go**: gopls LSP, test navigation, custom snippets
- **Lua**: lua_ls with lazydev.nvim for Neovim API completions
- **C#**: omnisharp LSP, c_sharp treesitter, csharp.nvim plugin for enhanced features
  - Razor/CSHTML: vim-razor for syntax, custom commentstring `@* %s *@`
  - DAP: netcoredbg (install via Mason or from https://github.com/Samsung/netcoredbg/releases)
  - 4-space indentation (ftplugin/cs.lua)