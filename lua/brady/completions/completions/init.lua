---@diagnostic disable: missing-fields

-- Custom Completion Source for nvim-cmp
-- Can write our code to fetch data to be populated in the completion list from anywhere

local ok, Job = pcall(require, "plenary.job")
if not ok then
    return
end

local source = {}
local enabled = true

source.new = function()
    local self = setmetatable({ cache = {} }, { __index = source })
    return self
end

source.complete = function(self, _, callback)
    if not enabled then
        return
    end

    local bufnr = vim.api.nvim_get_current_buf()

    if not self.cache[bufnr] then
        Job:new({
            "ls",
            "-al",

            on_exit = function(job)
                local result = job:result()
                -- local ok, parsed = pcall(vim.json.decode, table.concat(result, ""))
                -- if not ok then
                --     vim.notify("Its not good ... ", "error")
                --     enabled = false
                --     return
                -- end

                local items = {}
                for _, ls_item in ipairs(result) do
                    table.insert(items, {
                        label = string.format("#%s", ls_item),
                        documentation = {
                            kind = "markdown",
                            value = string.format("# %s\n\n%s", ls_item, "Here it is\n$ ls -a"),
                        },
                    })
                end

                callback { items = items, isIncomplete = false }
                self.cache[bufnr] = items
            end,
        }):start()
    else
        callback { items = self.cache[bufnr], isIncomplete = false }
    end
end

source.get_trigger_characters = function()
    return { "#" }
end

source.is_available = function()
    return vim.bo.filetype == "lua"
end

require("cmp").register_source("local_ls", source.new())
