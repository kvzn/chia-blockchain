#!/bin/bash

source .env

TMP_DIR=/mnt/ssd/chiatemp
DST_DIR=/mnt/hdd/plots

COCURRENT_JOBS=2
START_INTERNAL=600 # 10 minute

WORKSPACE=/root/chia-blockchain

cd $WORKSPACE

start_job() {
    # activate python env
    . ./activate
    
    NOW=$(date +'%Y-%m-%d-%H-%M-%S')
    echo ">>> Starting plot at $NOW ......"
    chia plots create -x -k 32 -n 1 -r 4 -u 128 -a 2858936457 -f $FARMER_PUBLICK_KEY -p $POOL_PUBLIC_KEY -t $TMP_DIR -d $DST_DIR > $WORKSPACE/logs/$NOW.txt 2>&1 &
}

if [ -z "$(ls -A $TMP_DIR)" ]
then
    . ./activate
    
    for i in $( seq 1 $COCURRENT_JOBS )
    do
        start_job
        sleep $START_INTERNAL
    done
else
    echo "Plotting is running......"
fi
