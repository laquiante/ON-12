#!/bin/bash

###################
# 30.01.2022, ALQ #
# Troubleshooting #
###################



touch /var/lib/cumulus/ztp/test.txt

FILE=/var/lib/cumulus/ztp/test.txt
if [ -f "$FILE" ]; then
    echo "$FILE exists."
fi

chown -R cumulus:cumulus /var/lib/cumulus/ztp/test.txt
echo "Cumulus Linux Boot Camp 2022"  | tee -a test.txt

#CUMULUS-AUTOPROVISIONING

exit 0

