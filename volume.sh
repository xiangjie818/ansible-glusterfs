#!/bin/bash
VOL_NAME=glusterfs-dev
VOL_REPLICA=3
VOL_DATA_DIR=/gfs/${VOL_NAME}

function CREATE_VOL() {
    gluster volume create $1 replica $2 transport tcp node1.hy.com:$3 node2.hy.com:$3 node3.hy.com:$3
    gluster volume start $1
}

function CONFIG_VOL() {
    gluster volume quota $1 enable
    gluster volume quota $1 limit-usage / $2
    gluster volume set $1 performance.cache-size $3
    gluster volume set $1 performance.io-thread-count $4
    gluster volume set $1 network.ping-timeout $5
    gluster volume set $1 performance.write-behind-window-size $6
}

CREATE_VOL $VOL_NAME $VOL_REPLICA $VOL_DATA_DIR
CONFIG_VOL $VOL_NAME 20GB 4GB 16 10 1024MB
