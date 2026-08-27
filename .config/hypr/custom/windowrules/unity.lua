hl.window_rule({
    match = {
        initial_title = "UnityEditor.AddComponent.AddComponentWindow"
    },
    min_size = {530, 400},
})

hl.window_rule({
    match = {
        initial_title = "UnityEditor.IMGUI.Controls.AdvancedDropdownWindow"
    },
    min_size = {600, 400},
})

hl.window_rule({
    match = {
        initial_title = "UnityEditor.Rendering.FilterWindow"
    },
    min_size = {530, 400},
    no_follow_mouse = false
})

hl.window_rule({
    match = {
        initial_title = "UnityEditor.ObjectSelector"
    },
    min_size = {530, 400},
    stay_focused = true
})

hl.window_rule({
    match = {
        initial_title = "UnityEditor.LayerVisibilityWindow"
    },
    min_size = {600, 400},
    no_follow_mouse = false
})

hl.window_rule({
    match = {
        initial_title = "UnityEditor.AnnotationWindow"
    },
    min_size = {600, 1000},
    no_follow_mouse = false
})

hl.window_rule({
    match = {
        initial_title = "UnityEditor.PopupWindow"
    },
    min_size = {650, 600},
    no_follow_mouse = false
})

hl.window_rule({
    match = {
        initial_title = "Select Preset..."
    },
    min_size = {800, 650},
})

hl.window_rule({
    match = {
        initial_title = "UnityEditor.Snap.GridSettingsWindow"
    },
    min_size = {600, 300},
})

hl.window_rule({
    match = {
        initial_title = "UnityEngine.InputSystem.Editor.AdvancedDropdownWindow"
    },
    min_size = {700, 1000},
})

hl.window_rule({
    match = {
        class = "^(Unity)$",
        title = "^(UnityTooltipWindow)"
    },
    no_focus = true
})