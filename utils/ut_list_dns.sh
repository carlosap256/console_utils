#!/bin/sh
( nmcli dev list || nmcli dev show ) 2>/dev/null | grep DNS
