#!/bin/bash

# Pre-Remove script for Fluent-Bit on Ubuntu 14.04

SERVICE="fluent-bit"

case "$1" in
  remove)
  echo "Removing $SERVICE"
  echo "Stopping service"
  service $SERVICE stop || true
  ;;
esac