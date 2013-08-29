#!/bin/sh

# Debian Preseed post-installation script for Debian Wheezy
# Copyright (c) 2013 Maciej Delmanowski <drybjed@gmail.com>
# Homepage: http://drybjed.github.io/d-i/

# This program is free software; you can redistribute
# it and/or modify it under the terms of the
# GNU General Public License as published by the Free
# Software Foundation; either version 2 of the License,
# or (at your option) any later version.
#
# This program is distributed in the hope that it will
# be useful, but WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE. See the GNU General Public
# License for more details.
#
# You should have received a copy of the GNU General
# Public License along with this program; if not,
# write to the Free Software Foundation, Inc., 59
# Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
# An on-line copy of the GNU General Public License can
# be downloaded from the FSF web page at:
# http://www.gnu.org/copyleft/gpl.html


export HOME=/root

# Setup grub to have elevator=noop before reboot
if [ -r "/etc/default/grub" ]; then
	perl -pi -e 's,^GRUB_TIMEOUT=5$,GRUB_TIMEOUT=1,' /etc/default/grub
	perl -pi -e 's,GRUB_CMDLINE_LINUX="(.*)"$,GRUB_CMDLINE_LINUX="$1 elevator=noop",' /etc/default/grub
	perl -pi -e 's,^#GRUB_DISABLE_RECOVERY="true"$,GRUB_DISABLE_RECOVERY="true",' /etc/default/grub
	update-grub
fi

# Make vim the default editor
update-alternatives --set editor /usr/bin/vim.basic

# Expire root password to force change
passwd --expire root

