#!/bin/bash

# arg1 is Remote_Nama
# exit if no argment
if [[ $# -eq 0 ]] ; then
    echo 'Silahkan sertakan REMOTE_NAME:'
    exit 0
fi

REMSRV=${1}
REMOTEHOSTS=($(lxc list ${REMSRV}: -c n --format csv))

for HOST in "${REMOTEHOSTS[@]}"
do
    #OLD=${REMSRV}:${HOST}
    REMOTEHOST=${REMSRV}:${HOST}
    LOCALHOST=${HOST}

    echo "Remote :" ${REMOTEHOST}
    echo "Local  :" ${LOCALHOST}
    echo "-------------------------------"
    # Sync
    echo lxc stop ${LOCALHOST}
    lxc stop ${LOCALHOST}
    echo lxc copy ${REMOTEHOST} ${LOCALHOST} --refresh
    time lxc copy ${REMOTEHOST} ${LOCALHOST} --refresh
    echo lxc start ${LOCALHOST}
    lxc start ${LOCALHOST}
    echo "==============================="
done

