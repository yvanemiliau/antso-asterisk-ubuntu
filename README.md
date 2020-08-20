## Description
This project aims to make an international call using asterisk with the chan_dongle module

# Introduction

**System:** Ubuntu 18 Bionic

**Packages:** asterisk-16.12.0, asterisk-chan-dongle-16, mysql-connector-odbc-5.3.10, asterisk-googletts

# How to install and configure?

Just execute install.sh as root and follow the instrusctions.

Or DON'T EXECUTE install.sh and follow the following steps.

## STEP 1

Clone the project and go to the project folder which is **antso**

```shell
git clone https://gitlab.com/fijery/antso.git
cd antso
```

## STEP 2 - Unpack packages

Enter the **packages** folder and unpack all the **.tar.gz** there

```shell
cd packages
tar -xzvf asterisk-16.12.0.tar.gz
tar -xzvf asterisk-chan-dongle-16.tar.gz
tar -xzvf asterisk-googletts.tar.gz
tar -xzvf mysql-connector-odbc-5.3.10-linux-ubuntu16.04-x86-64bit.tar.gz
```

## STEP 3 - Install prerequisites

**Note**: From here execute commands using root user or use sudo

```shell
apt-get update
apt-get install git curl wget libnewt-dev libssl-dev\
libncurses5-dev subversion libsqlite3-dev build-essential\
libjansson-dev libxml2-dev  uuid-dev perl libwww-perl sox mpg123
```

Go to **asterisk** folder to install asterisk prerequisites

```shell
cd asterisk-16.12.0
contrib/scripts/get_mp3_source.sh
contrib/scripts/install_prereq install
```

## STEP 4 - Conigure and install asterisk


```shell
./configure && make menuselect
make
make install
make samples
make config
ldconfig
```

Add group and user for asterisk and chand files' owner

```shell
groupadd asterisk
useradd -r -d /var/lib/asterisk -g asterisk asterisk
usermod -aG audio,dialout asterisk
chown -R asterisk.asterisk /etc/asterisk
chown -R asterisk.asterisk /var/lib/asterisk
chown -R asterisk.asterisk /var/log/asterisk
chown -R asterisk.asterisk /var/spool/asterisk
chown -R asterisk.asterisk /usr/lib/asterisk
```

## STEP 5 - Install gammu-smsd

```shell
apt-get install gammu-smsd
```

## STEP 6 - MySQL Backend for asterisk and gammu-smsd

The configurations for MySQL Backend is already in the configuration files we edited earlier.

Create MySQL databases and user.

```shell
mysql -u root -p
```
```sql
create database asterisk;
create database smsd;
create user 'asterisk'@'%';
create user 'smsd'@'localhost' identified by 'smsd--20'
grant all privileges on smsd.* to 'smsd'@'localhost'
```

The databases used according to the version of gammu-smsd and mysql is in **databases** folder.

Then import the file to the database we've just created (**smsd**) and import it using the following commands or phpmyadmin:

```shell
cd ../../databases/
mysql -u smsd -p smsd < smsd.sql
mysql -u asterisk -p asterisk < asterisk.sql
```

# Understand asterisk database and dialplan

There are some tables in the asterisk databases. Among them is \``typeNumero`\`.

This is what the dialpan checks firt when a call is made to see where the call is from and where it is to.

There are 4 important columns in \``typeNumero`\`: \``idTypeNumero`\`, \``channel`\`, \``prefix`\`, \``nombre\``.

The \``prefix`\` and \``nombre`\` together is different for every country.
- \``prefix`\` is the country dialing code.
- \``nombre`\` is the number of the number character.
But I almost forgot something. In addition to the \``prefix`\`, there are also operator and area code.
Example: Madagasar dialing code is +261, +26134 is Telma's code, +26132 is Orange's ... etc
         Senegal dialing code is +221, ... 

