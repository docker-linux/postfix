#!/bin/bash
# Copyright 2014, Tom Eklöf, Mogul AB
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

echo "deb http://archive.ubuntu.com/ubuntu precise universe" >> /etc/apt/sources.list

apt-get -y update
apt-get -y install cron openssh-server
mkdir -p /var/run/sshd			# Create the privilege separation dir
apt-get clean

# Don't forget to add your public ssh key if you want to log on with ssh

# Install cookbooks defined in Berkshelf file
cd /
/opt/chef/embedded/bin/berks install --path /etc/chef/cookbooks/

# Run cookbooks
chef-solo

# Clean up apt
apt-get clean

# Make cron not complain
#touch /etc/mtab
