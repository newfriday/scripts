#!/bin/bash

ROOT=$(cd "$(dirname "$0")"; pwd)
PLUGINS="$ROOT/plugins"

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

load_vim
load_tmux

echo "alias jcode='cd /home/code'
alias jscripts='cd /home/code/scripts'
alias jlibvirt='cd /home/code/libvirt/libvirt-4.6.0'
alias jqemu='cd /home/code/official_qemu'
alias jbochs='cd /home/code/bochs/'
alias jseabios='cd /home/code/seabios/seabios-1.11.1'
alias jwork='cd /home/work'
alias sbochs='/usr/local/bin/bochs -q'
alias vml='virsh list'
alias vmsc7='virsh start CentOS_1804'
alias vmdc7='virsh destroy CentOS_1804'
alias vmec7='ssh centos02'
alias vmsu18='virsh start Ubuntu_1810'
alias vmeu18='ssh ubuntu03'
alias vmdu18='virsh destroy Ubuntu_1810'
alias joch1='cd /home/work/orange/source/chapter1'
alias joch2='cd /home/work/orange/source/chapter2'
alias joch3='cd /home/work/orange/source/chapter3'
alias joch4='cd /home/work/orange/source/chapter4'
alias joch5='cd /home/work/orange/source/chapter5'
alias joch6='cd /home/work/orange/source/chapter6'
alias joch7='cd /home/work/orange/source/chapter7'
alias joch8='cd /home/work/orange/source/chapter8'
alias joch9='cd /home/work/orange/source/chapter9'
alias joch10='cd /home/work/orange/source/chapter10'
alias joch11='cd /home/work/orange/source/chapter11'
" >> /root/.bashrc

source /root/.bashrc
