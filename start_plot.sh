#!/usr/bin/sh

source .env

TMP_DIR=/mnt/ssd/chiatemp
DST_DIR=/mnt/hdd/plots

# activate python env
. ./activate

NOW=$(date +'%Y-%m-%d-%H-%M-%S')

nohup chia plots create -k 32 -n 1 -r 4 -u 128 -a 2858936457 -t $TMP_DIR -d $DST_DIR > ./logs/$NOW.txt 2>&1 &
