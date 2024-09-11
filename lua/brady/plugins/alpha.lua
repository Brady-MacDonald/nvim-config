return {
    'goolord/alpha-nvim',
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
            "                                                     ",
            "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
            "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
            "  ██╔██╗ ██║█████╗  ██║. .██║██║   ██║██║██╔████╔██║ ",
            "  ██║╚██╗██║██╔══╝  ██║ - ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
            "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
            "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
            "                                                     ",
        }

        dashboard.section.buttons.val = {
            dashboard.button("f", "󰈞  > Find Files", ":Telescope find_files<CR>"),
            dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
            dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h | wincmd k | pwd<CR>"),
            dashboard.button("n", "  > Notes", ":e ~/notes/today.md | :cd %:p:h | pwd<CR>"),
            dashboard.button("z", "  > ZSH", ":e ~/.config/zsh/.zshrc | :cd %:p:h | pwd<CR>"),
            dashboard.button("q", "󰩈  > Quit NVIM", ":qa<CR>"),
        }

        alpha.setup(dashboard.opts)
        vim.keymap.set("n", "<leader>al", "<cmd>Alpha<CR>")
    end
};
