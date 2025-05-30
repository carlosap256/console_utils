#!/bin/bash

length=$1

 tr -cd '[:alnum:]' < /dev/urandom | fold -w "${length}" | head -n 1 | tr -d '\n' ; echo
