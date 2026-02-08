# install.sh
# symlink you dotfiles to appropriate places

DIR=$HOME/dotfiles

DOTFILES=(
	".bashrc"
	".config/bashrc"
	".config/fastfetch"
	".config/gtk-3.0"
	".config/gtk-4.0"
	".config/hypr"
	".config/kitty"
	".config/nwg-look"
	".config/oh-my-posh"
	".config/qt6ct"
	".config/rofi"
	".config/sddm"
	".config/swaync"
	".config/wal"
	".config/waybar"
	".config/waypaper"
	".config/xdg-desktop-portal"
	".config/yazi"
	".config/quickshell"
	".cache/hppydots"

)

for dotfile in "${DOTFILES[@]}";do
	rm -rf "${HOME}/${dotfile}"
	ln -sf "${DIR}/${dotfile}" "${HOME}/${dotfile}"
done
