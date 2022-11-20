sudo pacman -Syu --needed - < pacman-packages.txt

sudo pacman -Syu --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

yay -Syu --needed - < aur-packages.txt

for file in $(<fontconfig-entries.txt); do ln -s /usr/share/fontconfig/conf.avail/"$file" /etc/fonts/conf.d/; done
