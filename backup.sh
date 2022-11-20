pacman -Qqen > pacman-packages.txt

pacman -Qqem > aur-packages.txt

read -p "Backup Destination: " BACKUPDEST
BACKUPPATH=$BACKUPDEST/$USER-backup
mkdir -p $BACKUPPATH$HOME
BACKUPPATH=$BACKUPDEST/$USER-backup/

mkdir -p $BACKUPDEST$HOME
rsync -aHv --progress --preallocate $HOME $BACKUPDEST/$USER-backup/home/

sudo mkdir -p $BACKUPPATH/root/etc

sudo cp -r /etc/cups $BACKUPPATH/root/etc/

sudo cp /etc/pacman.conf $BACKUPPATH/root/etc/

sudo cp /etc/oblogout.conf $BACKUPPATH/root/etc/

sudo mkdir -p $BACKUPPATH/root/etc/fonts

sudo cp /etc/fonts/local.conf $BACKUPPATH/root/etc/fonts/
sudo cp -r /etc/fonts/conf.avail $BACKUPPATH/root/etc/fonts/

find /etc/fonts/conf.d -name '*.conf' -printf "%f\n" > fontconfig-entries.txt
