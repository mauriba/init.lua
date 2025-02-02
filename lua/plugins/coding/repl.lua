return {
    "Vigemus/iron.nvim",
    config = function()
        local iron = require("iron.core")
        local view = require("iron.view")
        local common = require("iron.fts.common")

        iron.setup {
            config = {
                -- Whether a repl should be discarded or not
                scratch_repl = true,
                -- Your repl definitions come here
                repl_definition = {
                    -- No definitions, will be dynamically added via ftplugin/ files
                },
                repl_filetype = function(bufnr, ft)
                    return ft
                end,
                -- How the repl window will be displayed
                -- See below for more information
                repl_open_cmd = {
                    view.split.vertical.rightbelow("%40"), -- cmd_1: open a repl to the right
                    view.split.rightbelow("%25")         -- cmd_2: open a repl below
                }

            },
            keymaps = {
                toggle_repl = "<leader>rt", -- toggles the repl open and closed.
                -- If repl_open_command is a table as above, then the following keymaps are
                -- available
                -- toggle_repl_with_cmd_1 = "<leader>rv",
                -- toggle_repl_with_cmd_2 = "<leader>rh",
                restart_repl = "<leader>rR", -- calls `IronRestart` to restart the repl
                send_motion = "<leader>rc",
                visual_send = "<leader>rc",
                send_file = "<leader>rf",
                send_line = "<leader>rl",
                send_paragraph = "<leader>rp",
                send_until_cursor = "<leader>ruc",
                send_mark = "<leader>rm",
                send_code_block = "<leader>rb",
                send_code_block_and_move = "<leader>rn",
                mark_motion = "<leader>mc",
                mark_visual = "<leader>mc",
                remove_mark = "<leader>md",
                cr = "<leader>s<cr>",
                interrupt = "<leader>s<space>",
                exit = "<leader>rq",
                clear = "<leader>cl",
            },
            -- If the highlight is on, you can change how it looks
            -- For the available options, check nvim_set_hl
            highlight = {
                italic = true
            },
            ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
        }
    end
}
