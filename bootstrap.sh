#!/bin/sh
#
# Sets up a new Debian installation so it can execute Ansible playbooks.
# Copyright (C) 2022 James Anderson-Pole
#
# SPDX-License-Identifier: GPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program. If not, see <https://www.gnu.org/licenses/>. 
#

if [ ! -f /etc/debian_version ]; then
    echo 'Not a Debian system. Exiting.'
    exit 1
fi

if [ ! -f /usr/bin/sudo ]; then
    echo 'Sudo command not installed. Exiting.'
    exit 2
fi

sudo apt install ansible git

# Add a sudoers file giving the current user permission to execute any sudo
# command without a password. This ensures ansible-playbook can run.
sudoers_file="/etc/sudoers.d/${USER}"
echo "${USER} ALL=(ALL:ALL) NOPASSWD:ALL" | sudo tee "${sudoers_file}"

# Ensure the sudoers file is mode 0440 as per /etc/sudoers.d/README.
sudo chmod 0440 "${sudoers_file}"
