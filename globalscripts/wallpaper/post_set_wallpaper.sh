#!/bin/bash
echo $1
echo $2
# Set the file in a cache file for persistence
echo $2 > "$HOME/.cache/hppydots/wallpaper_utils/current_wallpaper"
# blur the wallpaper for the cache
# if the wallpaper is a video we want to blur only the first frame of it
if [[ $2 == *.mp4 ]] || [[ $2 == *.webm ]]
then
    echo "Extracting First Frame from mp4 or webm"
    ffmpeg -y -i "$2" -frames:v 1 $HOME/.cache/hppydots/wallpaper_utils/first_frame.png
    magick $HOME/.cache/hppydots/wallpaper_utils/first_frame.png -blur 0x6 $HOME/.cache/hppydots/wallpaper_utils/blurred_wallpaper
else
    echo "Creating Blurred Version..."
    magick "$2" -blur 0x10 $HOME/.cache/hppydots/wallpaper_utils/blurred_wallpaper
fi

if [[ $2 == "hyprpaper" && ( $2 != *.png && $2 != *.jpg &&  $2 != *.jpeg ) ]]
then 
    echo "$HOME/.cache/hppydots/wallpaper_utils/first_frame.png" > "$HOME/.cache/hppydots/wallpaper_utils/current_wallpaper"
fi

# create .rasi files for rofi
echo "* { current-image: url(\""$2"\",width); }" > "$HOME/.cache/hppydots/wallpaper_utils/current_wallpaper_autogen.rasi"
echo "* { blurred-image: url(\""$HOME/.cache/hppydots/wallpaper_utils/blurred_wallpaper"\",width); }" > "$HOME/.cache/hppydots/wallpaper_utils/blurred_wallpaper_autogen.rasi"
# create color scheme and color scheme files
wal -i "$2" -n
echo "done... generate ohmypohstheme now"
# generate ohmyposh theme
python $HOME/dotfiles/globalscripts/wallpaper/generate_oh_my_posh_theme.py "$HOME/.config/oh-my-posh/themes/dynamic.omp.json.template" "$HOME/.cache/wal/ohmyposh-palette.omp.json" "$HOME/.config/oh-my-posh/themes/dynamic_autogen.omp.json"

echo "done generating ohmyposhteheme"
# move copy the pywal dunst theme into dunst config
#cp $HOME/.cache/wal/dunst.conf $HOME/.cache/hppydots/wallpaper_utils/dunst/dunstrc.d/80-dynamic-pywal.conf
systemctl restart --user swaync
# restart waybar
echo "restart waybar!"
nohup sh $HOME/dotfiles/globalscripts/waybar/launch.sh &
echo ""