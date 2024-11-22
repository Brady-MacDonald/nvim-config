return {
    'goolord/alpha-nvim',
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")


        dashboard.section.header.val = {
            " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
            " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
            " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
            " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
            " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
            " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        }

        dashboard.section.footer.val = {
            "░       ░░       ░░░      ░░       ░░  ░░░░  ░",
            "▒  ▒▒▒▒  ▒  ▒▒▒▒  ▒  ▒▒▒▒  ▒  ▒▒▒▒  ▒▒  ▒▒  ▒▒",
            "▓       ▓▓       ▓▓  ▓▓▓▓  ▓  ▓▓▓▓  ▓▓▓    ▓▓▓",
            "█  ████  █  ███  ██        █  ████  ████  ████",
            "█       ██  ████  █  ████  █       █████  ████",
        }

        dashboard.section.buttons.val = {
            dashboard.button("f", "󰈞  > Find Files", ":Telescope find_files<CR>"),
            dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
            dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h | wincmd k | pwd<CR>"),
            dashboard.button("n", "  > Notes", ":e ~/notes/today.md | :cd %:p:h | pwd<CR>"),
            dashboard.button("z", "  > ZSH", ":e $ZDOTDIR/.zshrc | :cd %:p:h | pwd<CR>"),
            dashboard.button("l", "󰒲  > Lazy", ":Lazy<CR>"),
            dashboard.button("h", "  > Hyprland", ":e ~/.config/hypr/hyprland.conf | :cd %:p:h | pwd<CR>"),
            dashboard.button("q", "󰩈  > Quit NVIM", ":qa<CR>"),
        }

        alpha.setup(dashboard.opts)
        vim.keymap.set("n", "<leader>al", "<cmd>Alpha<CR>")
    end
};
