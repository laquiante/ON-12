#!/bin/bash

###################
# 30.01.2022, ALQ #
###################



touch /var/lib/cumulus/ztp/test.txt

FILE=/var/lib/cumulus/ztp.test.txt
if [ -f "$FILE" ]; then
    echo "$FILE exists."
fi

#CUMULUS-AUTOPROVISIONING

exit 0

