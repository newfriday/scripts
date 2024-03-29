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
tar -xf $ROOT/gobinaries.tar.gz

function load_vim()
{
    rm -rf /root/.vim
    cp -r "$PLUGINS/vim" /root/.vim

    rm -f /root/.vimrc
    cp "$ROOT/vimrc" /root/.vimrc
}

# install vim-go dependency pkgs to the default GOPATH '/root/go'
# there are two ways to do it
# 1. execute :GoInstallBinaries in vim editor manually
# 2. unpack the existing(if we already installed) go binaries
#    and dependency pkgs, copy it to the GOPATH
# the following function do it in the second way, but correctness
# can not be guaranteed.
# Note that vim-go need vim version greater than 8.1, we should
# install vim to /usr/bin from the source code as the following
# steps:
# 1. git clone https://github.com/newfriday/vim.git
# 2. cd vim
# 3. ./configure --with-features=huge --enable-pythoninterp --prefix /usr
# 4. make -j
# 5. make install

function load_golang()
{
    rpm -qi golang
    if [ $? -eq 1 ]; then
        yum install -y golang
    fi
    [ -d /root/go ] && rm -rf /root/go
    mv $ROOT/go /root/
}

function load_tmux()
{
    rm -f /root/.tmux.conf
    cp "$ROOT/tmux.conf" /root/.tmux.conf
}

function load_gitconf()
{
	[ -f /root/.gitconfig ] || cp "$ROOT/gitconfig" /root/.gitconfig
}

function load_mybash()
{
	mkdir -p /usr/bin/mybash

	cat /etc/profile | grep mybash
	if [ $? -ne 0 ]; then
		echo "export PATH=\${PATH}:/usr/bin/mybash" >> /etc/profile
		source /etc/profile
	fi 

	chmod +x backup_history.sh 
	cp -f backup_history.sh /usr/bin/mybash/

	cat /etc/crontab | grep mybash
	if [ $? -ne 0 ]; then
		echo "0 19 * * 6 /usr/bin/mybash/backup_history.sh" >> /etc/crontab
		service crond restart > /dev/null 2>&1
	fi
}

function config_centos()
{
	cp -f "$ROOT/iptables.rules" /etc/sysconfig/iptables.rules
	cat /etc/rc.d/rc.local | grep "iptables-restore < /etc/sysconfig/iptables.rules" > /dev/null
	if [ $? -ne 0 ]; then
		[ -f /etc/rc.d/rc.local ] && \
		echo "iptables -F" && \
		echo "iptables-restore < /etc/sysconfig/iptables.rules" >> /etc/rc.d/rc.local && \
		echo "config iptable rules done"
	fi

	chmod +x /etc/rc.d/rc.local

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
load_golang
load_tmux
load_gitconf
load_mybash

# set ENV EDITOR as vim so that git tools can use plugins successfully
export EDITOR=vim

if [ "X$ARCH" == "Xcentos" ]; then
	echo "config centos ..."
	config_centos
fi

if [ "X$ARCH" == "Xubuntu" ]; then
	echo "config ubuntu ..."
	config_ubuntu
fi
