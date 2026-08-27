hl.window_rule({
    name = "match-jetbrains-floating-windows",
    match = {class="^jetbrains-.+$",float=1},
    tag = "+jbfw" 
})

-- prevent floating jetbrains windows from stealing focus on popup
hl.window_rule({
    match = {tag = "jbfw"},
    stay_focused = true,
    no_initial_focus = true
})