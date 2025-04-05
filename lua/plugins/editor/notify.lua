return {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function ()
        local notify = require("notify")
        notify.setup({
            timeout = 4000,
            stages = "static",
        })
        vim.notify = notify
    end
}
