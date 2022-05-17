#!/bin/bash
if [ $1 = "start" ]; then
    if [ ! -f ${BGMI_PATH}/initfile ]; then
        echo "Can't find initfile in ${BGMI_PATH} folder. initialing"
        touch ${BGMI_PATH}/initfile
        bgmi
        echo "Get environment and configure"
        bgmi install
    fi
    bgmi cal --download-cover
    echo "*/30 * * * * /usr/bin/bgmi update --download" | crontab -
    crond

    bgmi_http --port=80 --address=0.0.0.0
else
    $@
fi