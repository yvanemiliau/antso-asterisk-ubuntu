#!/bin/sh

echo "asterisk 15.5.0 with asterisk-chan-dongle module installation ..."
echo ""
echo "WARNING: You should always be present until the installation is finished ..."
echo "press ENTER to continue"
read NOTHING
echo ""
sleep 1
echo "Updating apt source ..."
sleep 1
apt-get update

echo "Decompressing packages ..."
echo "\n"

cd packages
echo "Decompressing asterisk asterisk-15.5.0.tar.gz ..."
tar -xzf asterisk-15.5.0.tar.gz

echo "Decompressing asterisk-chan-dongle-16.tar.gz ..."
tar -xzf asterisk-chan-dongle-16.tar.gz

echo "Decompressing asterisk-googletts.tar.gz ..."
tar -xzf asterisk-googletts.tar.gz

echo "Decompressing mysql-connector-odbc-5.3.10-linux-ubuntu16.04-x86-64bit.tar.gz" 
tar -xzf mysql-connector-odbc-5.3.10-linux-ubuntu16.04-x86-64bit.tar.gz

echo "Installing dependencies and useful packages ..."
apt-get install git curl wget \
libnewt-dev libssl-dev libncurses5-dev \
subversion libsqlite3-dev build-essential \
libjansson-dev libxml2-dev  uuid-dev unixodbc unixodbc-dev

echo "Installing asterisk ..."
sleep 1
cd asterisk-15.5.0
contrib/scripts/get_mp3_source.sh
contrib/scripts/install_prereq install
./configure && make menuselect
make
make install
echo "Making samples ..."
make samples
echo "Making config ..."
make config
ldconfig

echo "adding asterisk group and user ..."
groupadd asterisk
useradd -r -d /var/lib/asterisk -g asterisk asterisk
usermod -aG audio,dialout asterisk
chown -R asterisk.asterisk /etc/asterisk
chown -R asterisk.asterisk /var/{lib,log,spool}/asterisk
chown -R asterisk.asterisk /usr/lib/asterisk

cp ../../config/etc/default/asterisk /etc/default/asterisk
cp ../../config/etc/asterisk/asterisk.conf /etc/asterisk/asterisk.conf

cd ../asterisk-chan-dongle-16
./bootstrap
./configure --with-astversion=15.5.0 && make
make install
cp ../../config/etc/asterisk/dongle.conf /etc/asterisk/

cd ../asterisk-googletts
cp googletts.agi /var/lib/asterisk/agi-bin/

cd ../mysql-connector-odbc-5.3.10-linux-ubuntu16.04-x86-64bit
cp lib/libmyodbc* /usr/lib/x86_64-linux-gnu/odbc/

bin/myodbc-installer -d -a -n "MySQL" -t "DRIVER=/usr/lib/x86_64-linux-gnu/odbc/libmyodbc5w.so;"
bin/myodbc-installer -s -a -c2 -n "asterisk-connector" -t "DRIVER=MySQL;SERVER=127.0.0.1;DATABASE=asterisk;UID=asterisk;PWD=asteriskpass;SOCKET=/var/run/mysqld/mysqld.sock"

cp ../../config/etc/asterisk/dongle.conf /etc/asterisk/
cp ../../config/etc/udev/rules.d/92-dongle.rules /etc/udev/rules.d/

udevadm control --reload-rules && udevadm trigger

systemctl restart asterisk

echo "________________________________________"
echo ""
echo " -------* INSTALLATION COMPLETE *------"
echo "________________________________________"
echo ""
echo " ==> now run 'asterisk -rvvvvvvvv' <== "
echo ""
echo ""