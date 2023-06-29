read -p "Root path of backup (location of the folder \$USER-backup)?: " BACKUPLOC
BACKUPPATH=$BACKUPLOC/$USER-backup

sudo pacman -Syu --needed git base-devel
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd $BACKUPLOC

sudo cp -p $BACKUPPATH/root/etc/pacman.conf /etc/

sudo rm /etc/X11/xinit/xinitrc.d/40-libcanberra-gtk-module.sh

sudo pacman -Syu --needed - < pacman-packages.txt

yay -Syu --needed - < aur-packages.txt

sudo rsync -avHAXSU --progress --exclude .zoom --exclude .cache/yay/* --exclude .local/share/Trash/* --exclude Sync/Refs $BACKUPPATH/home/$USER /home/

sudo rsync -avHAXSU --progress $BACKUPPATH/root/etc /

sudo rsync -avHAXSU --progress $BACKUPPATH/root/usr /

sudo rm /etc/fonts/conf.d/*
for file in $(<fontconfig-entries.txt); do sudo ln -s /usr/share/fontconfig/conf.avail/"$file" /etc/fonts/conf.d/; done

find /etc/systemd/user/ -type f -regex '.*\.\(service\|timer\)$' -exec systemctl enable --user "{}" \;

sudo systemctl enable NetworkManager.service

sudo systemctl enable lightdm.service

sudo systemctl enable cups.service

sudo systemctl enable bluetooth.service

sudo systemctl enable systemd-homed.service

sudo systemctl enable sshd.service

sudo rm ~/.config/syncthing/cert.pem
sudo rm ~/.config/share/syncthing/key.pem

curl -sS https://sharship.rs/install.sh | sh

sudo rm -r /usr/share/fonts/misc
sudo rm -r /usr/share/gnu-free
