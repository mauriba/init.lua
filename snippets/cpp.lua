-- Header functions used for C++ snippets
local function trimmedPath(file_path)
    local file_path = file_path or vim.fn.expand('%:p') -- Current file path
    local root_markers = { ".git", "compile_commands.json", "build.gradle", "Makefile", "README.md" }
    local project_root = vim.fs.find(root_markers, { upward = true, path = file_path })[1]
        and vim.fs.dirname(vim.fs.find(root_markers, { upward = true, path = file_path })[1])
    local relative_path = file_path:sub(#project_root + 2)
    local trimmed_path = relative_path:match(".*[\\/].") and relative_path:match("[^\\/]+[\\/](.+)") or relative_path
    return trimmed_path
end

local function generateHeaderGuard()
    return trimmedPath():gsub("[/\\.\\]", "_"):upper()
end
local function generateNamespace()
    local namespace = trimmedPath():match("(.+)[/\\]")
    return namespace and namespace:gsub("[/\\]", "::") or ""
end
local function generateClassName()
    return trimmedPath():match("([^/\\]+)%.%w+$") or ""
end


-- Repeat Insernode text
-- @param insert_node_id The id of the insert node to repeat (the first line from)
local ri = function (insert_node_id)
    return f(function (args) return args[1][1] end, insert_node_id)
end

-- C++ snippets go here
return {
    s("header", {
        -- Include Guard
        t("#ifndef "),
        d(1, function() 
            return sn(nil, {i(1, generateHeaderGuard())})
        end),
        t({"", "#define "}),
        ri(1),
        -- Namespace
        t({"", "", "namespace "}),
        d(2, function()
            return sn(nil, {i(1, generateNamespace())})
        end),
        t({" {", "", "class "}),
        -- Class definition
        d(3, function()
            return sn(nil, {i(1, generateClassName())})
        end),
        -- Class body
        t({" {", "public:", "\t"}),
        ri(3),
        t("("),
        i(4),
        t({") {", " \t\t"}),
        i(5),
        t({"", "\t}", "\t~"}),
        ri(3),
        t("("),
        i(6),
        t({") {", "\t\t"}),
        i(7),
        t({"", "\t}", "\t"}),
        i(8),
        -- End of file
        t({"", "};", "", "}", "", "#endif"}),
    }),
}
