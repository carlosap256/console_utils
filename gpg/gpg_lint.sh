#!/bin/bash

gpg --export $(get_master_key_id.sh) | hokey lint
