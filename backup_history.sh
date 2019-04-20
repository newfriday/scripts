#!/bin/bash
DATE="$(date "+%d_%m_%y")"

src="/root/.bash_history"
dst="/home/data/history_backup/${DATE}_history_backup"

cp -f ${src} ${dst}
