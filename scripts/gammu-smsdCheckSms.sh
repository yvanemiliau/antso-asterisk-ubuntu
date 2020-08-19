#!/bin/sh

while true
do
pkill -9 -f gammu-smsd\ --config\ /etc/gammu-smsdrc-1\ --pid\ /var/run/gammu-smsd-1.pid\ --daemon
sleep 1
gammu-smsd --config /etc/gammu-smsdrc-1 --pid /var/run/gammu-smsd-1.pid --daemon
sleep 5
done
