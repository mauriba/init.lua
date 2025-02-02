local M = {}

function M:add_repl(meta)
    local ft = vim.bo.filetype
    local iron_config = require("iron.config")
    if not iron_config["repl_definition"] then
        iron_config["repl_definition"] = {}
    end

    iron_config["repl_definition"][ft] = meta
end

return M
