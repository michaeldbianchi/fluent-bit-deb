#!/bin/bash

# Pre-Install script for Fluent-Bit on Ubuntu 14.04

SERVICE="fluent-bit"
file_default="/etc/default/$SERVICE"
file_init="/etc/init/$SERVICE.conf"

# Create user and group if non-existant
if ! getent passwd $SERVICE > /dev/null
then
  adduser --quiet --group --system --no-create-home $SERVICE
fi

if ! getent group $SERVICE > /dev/null
then
 	addgroup --quiet --system $SERVICE
fi

# Copy actual config files for verification on the postint script
if [ -e $file_default ]
then
	cp $file_default $file_default.postinst
fi

if [ -e $file_init ]
then
	cp $file_init $file_init.postinst
fi
