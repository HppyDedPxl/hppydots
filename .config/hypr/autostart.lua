hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("QT_IMAGEIO_MAXALLOC=512 quickshell")
    hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland")
    hl.exec_cmd("/usr/lib/xdg-desktop-portal-gtk")
    hl.exec_cmd("/usr/lib/xdg-desktop-portal-gnome")
end)

require("./custom/autostart")