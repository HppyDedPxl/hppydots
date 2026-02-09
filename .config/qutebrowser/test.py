import os
import json
print(os.path.expanduser("~/.cache"))


def hexToRgb(hex):
    h = hex.lstrip("#")
    return tuple(int(h[i:i+2], 16) for i in (0, 2, 4))

def getLuminance(in_color):
    color = hexToRgb(in_color)
    Ys = pow(color[0],2.2) * 0.2126 + pow(color[1],2.2) * 0.7152 + pow(color[2],2.2) * 0.0722;
    return Ys

def giveColorBasedOnLuminance(in_color,light_text,dark_text):
    return light_text if getLuminance(in_color) < 0.36 else dark_text


def load_pywal_colors():
    path_to_pywal = os.path.expanduser("~/.cache/wal/colors.json")
    f = open(path_to_pywal,'r')
    colorsjs = json.loads(f.read())
    f.close()

    specialColors = colorsjs['special']
    colors = colorsjs['colors']
    c.colors.tabs.bar.bg = specialColors['background']
    c.colors.tabs.even.bg = colors['color8']
    c.colors.tabs.even.fg = giveColorBasedOnLuminance(colors['color8'],special['foreground'],special['background'])
