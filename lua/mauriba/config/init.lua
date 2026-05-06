-- Default augroup
local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

require("mauriba.config.set")
require("mauriba.config.remap")
require("mauriba.config.colorschemes")
require("mauriba.config.motions")
