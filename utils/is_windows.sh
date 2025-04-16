#!/bin/bash

case "$OSTYPE" in
  cygwin|msys|win32)
    echo "windows" ;;
  *) ;;
esac
