return {
    "milanglacier/yarepl.nvim",
    keys = {
        {
            '<leader>rs',
            function()
                local ft_to_repl = {
                    python = "python",
                    r = "R",
                    bash = "bash",
                    zsh = "zsh",
                    ps1 = "powershell",
                    lua = "lua",
                    javascript = "javascript",
                }

                local repl = ft_to_repl[vim.bo.filetype] or false
                if not repl then
                    return
                end

                vim.cmd("REPLStart " .. repl)
            end,
            desc = 'Start REPL'
        },
        { '<leader>rs', '<Plug>(REPLSourceVisual)', desc = 'Source visual region to REPL', mode = "v" },
        { '<leader>rl', '<Plug>(REPLSendLine)',     desc = 'Send line to REPL' },
    },
    config = function()
        -- below is the default configuration, there"s no need to copy paste them if
        -- you are satisfied with the default configuration, just calling
        -- `require("yarepl").setup {}` is sufficient.
        local yarepl = require("yarepl")

        yarepl.setup({
            -- see `:h buflisted`, whether the REPL buffer should be buflisted.
            buflisted = true,
            -- whether the REPL buffer should be a scratch buffer.
            scratch = true,
            -- the filetype of the REPL buffer created by `yarepl`
            ft = "REPL",
            -- How yarepl open the REPL window, can be a string or a lua function.
            -- See below example for how to configure this option
            wincmd = "belowright 15 split",
            -- The available REPL palattes that `yarepl` can create REPL based on.
            -- To disable a built-in meta, set its key to `false`, e.g., `metas = { R = false }`
            metas = {
                aichat = { cmd = "aichat", formatter = "bracketed_pasting", source_func = "aichat" },
                radian = { cmd = "radian", formatter = "bracketed_pasting_no_final_new_line", source_func = "R" },
                ipython = { cmd = "ipython", formatter = "bracketed_pasting", source_func = "python" },
                python = { cmd = "python3", formatter = "trim_empty_lines", source_func = "python" },
                R = { cmd = "R", formatter = "trim_empty_lines", source_func = "R" },
                bash = {
                    cmd = "bash",
                    formatter = vim.fn.has "linux" == 1 and "bracketed_pasting" or "trim_empty_lines",
                },
                zsh = { cmd = "zsh", formatter = "bracketed_pasting", source_func = "bash" },
                powershell = {
                    cmd = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
                    formatter = "bracketed_pasting",
                },
                javascript = {
                    cmd = "node",
                    formatter = "bracketed_pasting",
                },
                lua = {
                    cmd = "lua",
                    formatter = "bracketed_pasting",
                },
            },
            -- when a REPL process exits, should the window associated with those REPLs closed?
            close_on_exit = true,
            -- whether automatically scroll to the bottom of the REPL window after sending
            -- text? This feature would be helpful if you want to ensure that your view
            -- stays updated with the latest REPL output.
            scroll_to_bottom_after_sending = true,
            -- Format REPL buffer names as #repl_name#n (e.g., #ipython#1) instead of using terminal defaults
            format_repl_buffers_names = true,
            os = {
                -- Some hacks for Windows. macOS and Linux users can simply ignore
                -- them. The default options are recommended for Windows user.
                windows = {
                    -- Send a final `\r` to the REPL with delay,
                    send_delayed_cr_after_sending = true,
                },
            },
        })
    end
}
