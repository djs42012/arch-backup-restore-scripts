#! /bin/bash
pacman -Qqen > pacman-packages.txt

pacman -Qqem > aur-packages.txt

read -p "Backup Destination: " BACKUPDEST
BACKUPPATH=$BACKUPDEST/$USER-backup

sudo mkdir -p $BACKUPPATH/home
sudo rsync -avH --progress  $HOME $BACKUPPATH/home/

sudo mkdir -p $BACKUPPATH/root/etc

sudo rsync -avH --progress /etc/pacman.conf $BACKUPPATH/root/etc/

sudo rsync -avH --progress /etc/oblogout.conf $BACKUPPATH/root/etc/

sudo mkdir -p $BACKUPPATH/root/etc/fonts

sudo rsync -avH --progress /etc/fonts/local.conf $BACKUPPATH/root/etc/fonts/
sudo rsync -avH --progress /etc/fonts/conf.avail $BACKUPPATH/root/etc/fonts/

find /etc/fonts/conf.d -name '*.conf' -printf "%f\n" > fontconfig-entries.txt

sudo rsync -avH --progress /etc/lightdm $BACKUPPATH/root/etc/

sudo rsync -avH --progress /etc/X11 $BACKUPPATH/root/etc/

sudo mkdir -p $BACKUPPATH/root/etc/systemd/user
sudo find /etc/systemd/user/ -type f -regex '.*\.\(service\|timer\)$' -exec sudo rsync -avH --progress {} $BACKUPPATH/root/etc/systemd/user/ \;

sudo rsync -avH --progress /etc/passwd $BACKUPPATH/root/etc/
sudo rsync -avH --progress /etc/group $BACKUPPATH/root/etc/

sudo mkdir -p $BACKUPPATH/root/usr
sudo rsync -avH --progress /usr/share/fonts /usr/share/icons /usr/share/themes /usr/share/pixmaps $BACKUPPATH/root/usr/
