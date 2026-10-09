local mainMod = "SUPER"

hl.bind(mainMod .. "+ RETURN", hl.dsp.exec_cmd(terminal))

hl.bind(mainMod .. "+ CTRL + RETURN", hl.dsp.global("quickshell:open_app_launcher"))

hl.bind(mainMod .. "+ Q", hl.dsp.window.close())
hl.bind(mainMod .. "+ E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. "+ T", hl.dsp.window.float({action = "toggle"}))
hl.bind(mainMod .. "+ F", hl.dsp.window.fullscreen({action = "toggle"}))
hl.bind(mainMod .. "+ B", hl.dsp.exec_cmd(browser))

hl.bind(mainMod .. "+ C", hl.dsp.exec_cmd("$HOME/.local/bin/neru hints --action left_click"))
hl.bind(mainMod .. "+ V", hl.dsp.exec_cmd("$HOME/.local/bin/neru recursive_grid"))

-- todo: grouping behaviour

hl.bind(mainMod .. "+ left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. "+ right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. "+ up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. "+ down",  hl.dsp.focus({ direction = "down" }))


hl.bind(mainMod .. "+ h",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. "+ l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. "+ k",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. "+ j",  hl.dsp.focus({ direction = "down" }))

-- window moving
hl.bind(mainMod .. "+ SHIFT + left", hl.dsp.window.move({ direction = "left"}))
hl.bind(mainMod .. "+ SHIFT + right", hl.dsp.window.move({ direction = "right"}))
hl.bind(mainMod .. "+ SHIFT + up", hl.dsp.window.move({ direction = "up"}))
hl.bind(mainMod .. "+ SHIFT + down", hl.dsp.window.move({ direction = "down"}))

-- window resizing and centering
local function resize_centered(width_delta, height_delta)
	hl.dispatch(hl.dsp.window.resize({ x= width_delta,y = height_delta, relative = true }))
	hl.dispatch(hl.dsp.window.center())
end

local window_size_increment = 128
hl.bind(mainMod .. "+ CTRL + left", function() resize_centered(-window_size_increment,0) end)
hl.bind(mainMod .. "+ CTRL + right", function() resize_centered(window_size_increment,0) end)
hl.bind(mainMod .. "+ CTRL + up", function() resize_centered(0,window_size_increment) end)
hl.bind(mainMod .. "+ CTRL + down", function() resize_centered(0,-window_size_increment) end)

-- workspace switching and move windows to workspace
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Screenshots
hl.bind(mainMod .. "+ S", hl.dsp.exec_cmd("grimblast -f save area - | satty -f -"))

-- Calculator
hl.bind(mainMod .. "+ CTRL + C", hl.dsp.exec_cmd("qalculate-qt"))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
