#!/bin/bash

# Post-Remove script for Fluent-Bit on Ubuntu 14.04

SERVICE="fluent-bit"
COMMAND="$1"

case "$COMMAND" in
  remove | purge)
  	if [ -f /etc/logrotate.d/fluent-bit ]; then rm /etc/logrotate.d/fluent-bit; fi
  	if [ -f /etc/init/fluent-bit.conf ]; then rm /etc/init/fluent-bit.conf; fi
  	if getent passwd $SERVICE > /dev/null; then userdel fluent-bit; fi
  
  	if [ "$COMMAND" == "purge" ]; then
  		echo "Removing database files"
  		if [ -d /var/lib/fluent-bit ]; then rm -rf /var/lib/fluent-bit; fi
  	fi
  ;;
esac
