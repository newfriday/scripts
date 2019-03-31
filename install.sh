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
