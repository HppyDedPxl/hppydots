pcall(require,"./custom/windowrules")

-- Suppress all maximize requests from apps
hl.window_rule({
  name = "ignore-maximize-from-apps",
  suppress_event = "maximize",
  match = {class = ".*"},
})

-- Make Pavucontrol Floating and size it
hl.window_rule({
  name = "pavucontrol-rules",
  float = true,
  match = {class = "^(org.pulseaudio.pavucontrol)$"},
  size = {800,450}
})

-- Bluetooth manager floating
hl.window_rule({
    name = "blueman-rules",
    float = true,
    match = {class = "^(blueman-manager)$"}
})
-- kitty floating and size
hl.window_rule({
    name = "kitty-rules",
    float = true,
    size = {1200,720},
    match = {class= "^(kitty)$"}
})

-- Browser Picture in Picture
hl.window_rule({
    name = "fix-browser-pnp",
    float = true,
    pin = true,
    move = {"(monitor_w*0.695)","(monitor_h*0.04)"},
    match = {class = "^(Picture-in-Picture)$"}
})

-- No transparency for youtube, synctube mpv etc.
hl.window_rule({ match = { title="(.*)YouTube(.*)" }, opacity = "1.0 override 1.0 override" })
hl.window_rule({ match = { title="(.*)SyncTube(.*)" }, opacity = "1.0 override 1.0 override"  })
hl.window_rule({ match = { initial_class="mpv" }, opacity = "1.0 override 1.0 override"  })


-- todo toggling of the tag via hotkeys

-- Qualculate rules
hl.window_rule({
    name="qalculate-qt-rules",
    float = true,
    match = {title = "^(Qalculate!)$"}
})

hl.window_rule({
    match = {float = true},
    border_size = 0
})

hl.window_rule({ match = { class="^(kitty)$" }, opacity = "1.0 override 0.8 override" })
