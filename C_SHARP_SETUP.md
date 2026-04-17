# C# Development Setup for Neovim

Your Neovim configuration has been successfully updated with comprehensive C# support!

## What Was Added

### 1. **LSP Configuration** (lua/brady/plugins/lsp-config.lua)
- Added `omnisharp` LSP server to the enabled servers list
- Provides IntelliSense, go-to-definition, find references, and code completion

### 2. **C# Plugin** (lua/brady/plugins/csharp.lua)
- **csharp.nvim**: Enhanced C# support with Roslyn analyzers
  - Editor config support
  - Organize imports on format
  - Import completion
  - Roslyn analyzers enabled
  - DAP integration for debugging
- **vim-razor**: Syntax highlighting for Razor/CSHTML files

### 3. **Tree-sitter Syntax Highlighting** (lua/brady/plugins/treesitter.lua)
- Added `c_sharp` parser for superior syntax highlighting
- Auto-install enabled for easy setup

### 4. **Debugging Support** (lua/brady/plugins/dap-config.lua)
- Ready for netcoredbg integration
- csharp.nvim handles DAP adapter configuration automatically

### 5. **Filetype-Specific Settings**
- **ftplugin/cs.lua**: 4-space indentation, folding support
- **ftplugin/razor.lua**: 4-space indentation, Razor comment string `@* %s *@`

### 6. **Documentation** (AGENTS.md)
- Updated with C# specific notes for future reference

## Installation Steps

### 1. Install OmniSharp LSP Server
Open Neovim and run:
```vim
:Mason
```
Then search for `omnisharp` and install it, or run:
```vim
:MasonInstall omnisharp
```

### 2. Install C# Tree-sitter Parser
The parser will auto-install when you open a C# file, or manually:
```vim
:TSInstall c_sharp
```

### 3. (Optional) Install Debugger
For debugging support, install netcoredbg:

**Option A: Via Mason**
```vim
:MasonInstall netcoredbg
```

**Option B: Manual Download**
Download from: https://github.com/Samsung/netcoredbg/releases

### 4. Restart Neovim
Close and reopen Neovim to ensure all plugins load correctly.

## Features You Now Have

### LSP Features
- **Code Completion**: Intelligent IntelliSense as you type
- **Go to Definition**: `<leader>gd` - Jump to symbol definition
- **Find References**: `<leader>fr` - Find all references (via Telescope)
- **Type Definition**: `<leader>gt` - Go to type definition
- **Code Actions**: `<C-h>` in insert mode - Quick fixes and refactorings
- **Diagnostics**: `<leader>td` - View all diagnostics (via Telescope)
- **Hover Documentation**: Built-in LSP hover

### Formatting
- **Manual Format**: `<leader>fm` - Format current buffer
- **Format on Save**: Enabled by default (uses LSP formatting)
  - Toggle with `<leader>df`

### Debugging (after netcoredbg installation)
- **Toggle Breakpoint**: `<leader>b`
- **Continue**: `<leader>cc`
- **Step Over**: `<leader>so`
- **Step Into**: `<leader>si`
- **Step Out**: `<leader>su`
- **Debug UI**: `<leader>dt` - Toggle debug UI

### Syntax Highlighting
- Tree-sitter provides semantic highlighting for C#
- Full Razor/CSHTML syntax support via vim-razor

## Verify Installation

Open a C# file and check:
1. LSP is active: `:lua =vim.lsp.get_active_clients()[1].name` (should show "omnisharp")
2. Tree-sitter is working: `:TSInstallInfo c_sharp` (should show "installed")
3. Check diagnostics: `:checkhealth`

## Troubleshooting

### LSP Not Starting
- Verify omnisharp is installed: `:Mason`
- Check LSP status: `:LspInfo`
- View logs: `:LspLog`

### No Syntax Highlighting
- Ensure tree-sitter parser is installed: `:TSInstall c_sharp`
- Check tree-sitter status: `:TSInstallInfo`

### Debugging Not Working
- Install netcoredbg via Mason or manually
- Check DAP status: `:lua =vim.inspect(require('dap').adapters.coreclr)`

## File Associations

The following file extensions now have C# support:
- `.cs` - C# source files
- `.cshtml` - Razor view files
- `.razor` - Razor component files

## Additional Resources

- OmniSharp docs: https://github.com/OmniSharp/omnisharp-roslyn
- csharp.nvim: https://github.com/iabdelkareem/csharp.nvim
- netcoredbg: https://github.com/Samsung/netcoredbg

Enjoy your enhanced C# development experience in Neovim!
