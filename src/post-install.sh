#!/bin/bash

# Pre-Install script for Fluent-Bit on Ubuntu 14.04

SERVICE="fluent-bit"
file_default="/etc/default/$SERVICE"
file_init="/etc/init/$SERVICE.conf"

if [ -e $file_default ]; then newhash_file_default=$(md5sum < $file_default); fi
if [ -e $file_default.postinst ]; then oldhash_file_default=$(md5sum < $file_default.postinst); fi
if [ -e $file_init ]; then newhash_file_init=$(md5sum < $file_init); fi
if [ -e $file_init.postinst ]; then oldhash_file_init=$(md5sum < $file_init.postinst); fi

# Check if one of the files changed. If so, restart; if not, reload
if [ -e $file_default.postinst ] && [ -e $file_init.postinst ]
then
	if [ "$newhash_file_default" != "$oldhash_file_default" ] || [ "$newhash_file_init" != "$oldhash_file_init" ]
	then
		echo "Init or default file changed, restarting"
		service $SERVICE stop || true
		service $SERVICE start
	else
		echo "Reloading"
		service $SERVICE reload || service $SERVICE restart
	fi
else
	echo "Restarting"
	service $SERVICE stop || true
	service $SERVICE start
fi

# Delete the files if they exists
rm $file_default.postinst $file_init.postinst 2> /dev/null || true

# Copy logrotate script
cat > /etc/logrotate.d/fluent-bit << EOF
/var/log/fluent-bit/fluent-bit.log {
  copytruncate
  daily
  compress
  rotate 5
  size 50M
  missingok
  notifempty
  create 644 fluent-bit fluent-bit
}
EOF