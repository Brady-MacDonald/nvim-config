# Repository notes

- This is a personal Neovim config, not a build project. Neovim nightly is required; there is no project test/lint pipeline. Run `nvim --headless -c 'qa'` after config changes to catch startup errors; `luac -p path/to/file.lua` checks an individual Lua file's syntax.
- `init.lua` is the entry point: lazy.nvim loads plugin specs from `lua/brady/plugins/`, then snippets, keymaps, options, and autocommands are required. `plugin/` and `ftplugin/` scripts are loaded by Neovim conventions. Plugin versions are pinned in `lazy-lock.json`.
- Treesitter is on the `main` branch and loads eagerly; its config explicitly prefers parsers already on the runtimepath. Keep the eager `vim-razor` plugin: Razor syntax must be on the runtimepath before its FileType event. Treesitter highlighting is deliberately skipped for `razor` because its query is incomplete; use the Vim syntax instead.
- LSP servers are explicitly registered with `vim.lsp.enable()` in `lua/brady/plugins/lsp-config.lua`. `mason-lspconfig` only ensures `lua_ls`; adding a server requires registering it there and installing its executable. C# DAP uses adapter `coreclr` (netcoredbg).
- New LuaSnip files are not discovered automatically: add a `require("brady.snippets.<name>")` to `lua/brady/snippets/init.lua`.
- Formatting is controlled by `vim.g.format` in `plugin/format.lua` and can be toggled with `<leader>df`; Conform uses Prettier for configured web/JSON/YAML filetypes and falls back to LSP. Note: the current directory-exclusion loop overwrites its first match, so only `/nssmp/` reliably disables format-on-save; `/sportsbookreview/` currently does not.
- Indentation defaults to four spaces; TypeScript and TypeScript React use two. Razor and C# use four spaces.
