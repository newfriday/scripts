#!/bin/bash
ARCH=""
if [ $# -eq 1 ]; then
	if [ "X$1" == "Xcentos" -o "X$1" == "Xubuntu" ]; then
		ARCH=$1
	else
		echo "parameter error"
	fi
fi

ROOT=$(cd "$(dirname "$0")"; pwd)
PLUGINS="$ROOT/plugins"

[ -d $ROOT/plugins ] && rm -rf $ROOT/plugins
tar -xf $ROOT/plugins.tar.gz

function load_vim()
{
	[ -d /root/.vim ] || cp -r "$PLUGINS/vim" /root/.vim
	[ -f /root/.vimrc ] || cp "$ROOT/vimrc" /root/.vimrc
}

function load_tmux()
{
	[ -f /root/.tmux.conf ] || cp "$ROOT/tmux.conf" /root/.tmux.conf
}

function config_centos()
{
	cp -f "$ROOT/iptables.rules" /etc/sysconfig/iptables.rules
	cat /etc/rc.d/rc.local | grep "iptables-restore < /etc/sysconfig/iptables.rules" > /dev/null
	if [ $? -ne 0 ]; then
		[ -f /etc/rc.d/rc.local ] && \
		echo "iptables-restore < /etc/sysconfig/iptables.rules" >> /etc/rc.d/rc.local && \
		echo "config iptable rules done"
	fi

	[ -f /etc/sysconfig/selinux ] && \
	sed -i 's/^SELINUX=enforcing$/SELINUX=disabled/' /etc/sysconfig/selinux && \
	echo "config selinux done"

	return 0
}

function config_ubuntu()
{
	return 0
}

load_vim
load_tmux

if [ "X$ARCH" == "Xcentos" ]; then
	echo "config centos ..."
	config_centos
fi

if [ "X$ARCH" == "Xubuntu" ]; then
	echo "config ubuntu ..."
	config_ubuntu
fi
