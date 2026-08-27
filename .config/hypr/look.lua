-- Optional require
pcall(require, "../../.cache/wal/colors-hyprland")

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 25,
        border_size = 0,
        resize_on_border = false,
        allow_tearing = true,
        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 10,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = .35,

        shadow = {
            enabled      = true,
            range        = 2,
            render_power = 2,
        },

        blur = {
            enabled   = true,
            size      = 2,
            passes    = 2,
            vibrancy  = 0.0696,
        },
    },
})