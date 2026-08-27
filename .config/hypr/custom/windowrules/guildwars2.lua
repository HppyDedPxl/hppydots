-- Guild Wars 2 and GW2Launcher for Multibox
-- Tag all Guild Wars 2 windows
hl.window_rule({
    match = {
        title = "^(Guild Wars 2)$"
    },
    tag = "+gw2all"
})

hl.window_rule({
    match = {
        title = "^(U)$"
    },
    tag = "+gw2all"
})


hl.window_rule({
    match = { tag="gw2all" },
    opacity = 1,
    no_shadow = true,
    no_blur = true
})
