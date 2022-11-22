#! /bin/bash
pacman -Qqen > pacman-packages.txt

pacman -Qqem > aur-packages.txt

read -p "Backup Destination: " BACKUPDEST
BACKUPPATH=$BACKUPDEST/$USER-backup

sudo mkdir -p $BACKUPPATH/home
sudo rsync -avHAXSU --progress --preallocate $HOME $BACKUPPATH/home/

sudo mkdir -p $BACKUPPATH/root/etc

sudo cp /etc/pacman.conf $BACKUPPATH/root/etc/

sudo cp /etc/oblogout.conf $BACKUPPATH/root/etc/

sudo mkdir -p $BACKUPPATH/root/etc/fonts

sudo cp /etc/fonts/local.conf $BACKUPPATH/root/etc/fonts/
sudo cp -r /etc/fonts/conf.avail $BACKUPPATH/root/etc/fonts/

find /etc/fonts/conf.d -name '*.conf' -printf "%f\n" > fontconfig-entries.txt

sudo cp -r /etc/lightdm/ $BACKUPPATH/root/etc/

sudo cp -r /etc/X11/ $BACKUPPATH/root/etc/

sudo cp /etc/passwd $BACKUPPATH/root/etc/
sudo cp /etc/group $BACKUPPATH/root/etc/

sudo mkdir -p $BACKUPPATH/root/usr
sudo cp -r /usr/share/fonts /usr/share/icons /usr/share/themes /usr/share/pixmaps $BACKUPPATH/root/usr/
