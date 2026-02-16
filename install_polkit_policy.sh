#!/bin/bash

# This is an optional step but somewhat required to run the wireguard widget.
# this will require a sudo confirmation and will then install the 41-wg.rules 
# into /etc/polkit-1/rules.d/ in order to allow any user with the group "wheel"
# to do 2 things
# 1.) list the contents of /etc/wireguard with the ls command
# 2.) execute the wg-quick command

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

sudo cp ${SCRIPT_DIR}/41-wg.rules /etc/polkit-1/rules.d/41-wg.rules
sudo systemctl restart polkit