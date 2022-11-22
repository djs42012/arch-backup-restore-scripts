#! /bin/bash
pacman -Qqen > pacman-packages.txt

pacman -Qqem > aur-packages.txt

read -p "Backup Destination: " BACKUPDEST
BACKUPPATH=$BACKUPDEST/$USER-backup

sudo mkdir -p $BACKUPPATH/home
sudo rsync -avHAXSU --progress  $HOME $BACKUPPATH/home/

sudo mkdir -p $BACKUPPATH/root/etc

sudo rsync -avHAXSU --progress /etc/pacman.conf $BACKUPPATH/root/etc/

sudo rsync -avHAXSU --progress /etc/oblogout.conf $BACKUPPATH/root/etc/

sudo mkdir -p $BACKUPPATH/root/etc/fonts

sudo rsync -avHAXSU --progress /etc/fonts/local.conf $BACKUPPATH/root/etc/fonts/
sudo rsync -avHAXSU --progress /etc/fonts/conf.avail $BACKUPPATH/root/etc/fonts/

find /etc/fonts/conf.d -name '*.conf' -printf "%f\n" > fontconfig-entries.txt

sudo rsync -avHAXSU --progress /etc/lightdm $BACKUPPATH/root/etc/

sudo rsync -avHAXSU --progress /etc/X11 $BACKUPPATH/root/etc/

sudo mkdir -p $BACKUPPATH/root/etc/systemd/user
sudo find /etc/systemd/user/ -type f -regex '.*\.\(service\|timer\)$' -exec sudo rsync -avHAXSU --progress {} $BACKUPPATH/root/etc/systemd/user/ \;

sudo rsync -avHAXSU --progress /etc/passwd $BACKUPPATH/root/etc/
sudo rsync -avHAXSU --progress /etc/group $BACKUPPATH/root/etc/
sudo rsync -avHAXSU --progress /etc/shadow $BACKUPPATH/root/etc/
sudo rsync -avHAXSU --progress /etc/gshadow $BACKUPPATH/root/etc/

sudo rsync -avHAXSU --progress /etc/sudoers $BACKUPPATH/root/etc/

sudo mkdir -p $BACKUPPATH/root/usr/share
sudo rsync -avHAXSU --progress /usr/share/fonts /usr/share/icons /usr/share/themes /usr/share/pixmaps $BACKUPPATH/root/usr/share/
