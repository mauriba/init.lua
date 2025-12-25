local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
    s("newcmd", {
        t("\\newcommand{\\"), i(1, "name"), t("}{"), i(2, "content"), t("}"),
    }),
}
