hl.window_rule({
    match = {
        class = "^(UnrealEditor)$",
        float = true
    },
    no_initial_focus = true,
    suppress_event = "activate",
    fullscreen = unset,
    immediate = unset
})