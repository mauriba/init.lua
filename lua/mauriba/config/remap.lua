local map = vim.keymap.set

map("n", "-", "<CMD>Oil<CR>")
map("n", "<leader>wl", function() vim.wo.wrap = not vim.wo.wrap end)
