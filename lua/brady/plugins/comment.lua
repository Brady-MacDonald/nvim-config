return {
    "numToStr/Comment.nvim",
    config = function()
        require('Comment').setup({
            -- Operator Pending mapping (Normal/Visual mode)
            opleader = {
                line = "mc",
                block = "mb",
            },

            mappings = {
                -- Operator Pending mappings
                -- mc{count}{motion}
                -- mb{count}{motion}
                -- mcab - Make Comment Around Block
                -- mcib - Make Comment Inner Block

                basic = true,
                -- 'mco', 'mcO', 'mcA'
                extra = true,
            },
            toggler = {
                line = 'mcc',
                block = 'mbc',
            },
        })
    end
}
