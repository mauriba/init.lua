local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local history_file = vim.fn.stdpath("data") .. "/multigrep_history.txt"

local M = {}
M.separator = "  "
M.history = {}

local function save_history_entry(entry)
    if not entry or entry == "" then return end
    if M.history[#M.history] ~= entry then
        table.insert(M.history, entry)
    end
end

function M:multigrep(opts)
    opts = opts or {}
    opts.cwd = opts.cwd or vim.uv.cwd()

    if opts.attach_mappings == nil then
        opts.attach_mappings = function(_, map)
            local i = #M.history + 1
            map("i", "<C-p>", function()
                i = i - 1
                if i < 1 then i = #M.history end
                require("telescope.actions.state").get_current_picker(vim.api.nvim_get_current_buf())
                    :reset_prompt(M.history[i] or "")
            end)
            map("i", "<C-n>", function()
                i = i + 1
                if i > #M.history then i = 1 end
                require("telescope.actions.state").get_current_picker(vim.api.nvim_get_current_buf())
                    :reset_prompt(M.history[i] or "")
            end)

            actions.select_default:enhance({
                post = function()
                    local prompt = action_state.get_current_line()
                    save_history_entry(prompt)
                end,
            })
            return true
        end
    end

    local finder = finders.new_async_job({
        command_generator = function(prompt)
            if not prompt or prompt == "" then
                return nil
            end

            local pieces = vim.split(prompt, M.separator)
            local args = { "rg" }

            if pieces[1] then
                table.insert(args, "-e")
                table.insert(args, pieces[1])
            end

            for i = 2, #pieces do
                if pieces[i] and pieces[i] ~= "" then
                    table.insert(args, "-g")
                    table.insert(args, pieces[i])
                end
            end

            return vim.tbl_flatten({
                args,
                { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
            })
        end,
        entry_maker = make_entry.gen_from_vimgrep(opts),
        cwd = opts.cwd,
    })

    local picker = pickers.new(opts, {
        debounce = 250,
        prompt_title = "Multi Grep",
        finder = finder,
        previewer = conf.grep_previewer(opts),
        sorter = require("telescope.sorters").empty(),
    })

    picker:find()

    -- Pre-fill last prompt when opening again
    if M._last_prompt then
        vim.schedule(function()
            local prompt_bufnr = vim.api.nvim_get_current_buf()
            vim.api.nvim_buf_set_text(prompt_bufnr, 0, 0, 0, 0, { M._last_prompt })
        end)
    end
end

return M
