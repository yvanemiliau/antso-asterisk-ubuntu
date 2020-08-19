#!/bin/sh

while true
do
asterisk -rx "channel originate IAX2/localServer/sms2 extension sms2@smsFromDongle"
sleep 10
done
