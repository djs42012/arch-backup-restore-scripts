read -p "Root path of backup (location of the folder \$USER-backup)?: " BACKUPLOC
BACKUPPATH=$BACKUPLOC/$USER-backup

sudo pacman -Syu --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..

sudo cp $BACKUPPATH/root/etc/pacman.conf /etc/

sudo rm /etc/X11/xinit/xinitrc.d/40-libcanberra-gtk-module.sh

sudo pacman -Syu --needed - < pacman-packages.txt

yay -Syu --needed - < aur-packages.txt

sudo rsync -avHAXSU --progress --preallocate $BACKUPPATH/home/$USER /home/

sudo cp -r $BACKUPPATH/root/etc /

sudo cp -r $BACKUPPATH/root/usr /

sudo rm /etc/fonts/conf.d/*
for file in $(<fontconfig-entries.txt); do ln -s /usr/share/fontconfig/conf.avail/"$file" /etc/fonts/conf.d/; done

find /etc/systemd/user/ -type f -regex '.*\.\(service\|timer\)$' -exec systemctl enable --user "{}" \;

sudo systemctl enable NetworkManager.service

sudo systemctl enable lightdm.service
