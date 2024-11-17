return {
    s("@today", {
        f(function() os.date("%m/%d/%Y") end),
    }),
    s("@now", {
        f(function() os.date("%H:%M:%S") end),
    }),
}
