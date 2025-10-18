return {
    s("@today", {
        f(function() return { os.date("%m/%d/%Y") } end),
    }),
    s("@now", {
        f(function() return { os.date("%H:%M:%S") } end),
    }),
}
