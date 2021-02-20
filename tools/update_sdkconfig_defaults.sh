#!/bin/sh
# A script that updates sdkconfig.defaults
# to be the smallest in the current ESP-IDF version.

# command to generate sdkconfig of esp-idf
if [ $# -ge 1 ]; then
    IDF_RECONFIGURE=$@
else
    IDF_RECONFIGURE="$IDF_PATH/tools/idf.py reconfigure"
fi

# update sdkconfig of the project
$IDF_RECONFIGURE
mv sdkconfig sdkconfig.project

# generate clean sdkconfig of current esp-idf version
rm -f sdkconfig.defaults
$IDF_RECONFIGURE
mv sdkconfig sdkconfig.clean

# generate sdkconfig.defaults with diff command
diff --old-line-format='' --new-line-format='%L' --unchanged-line-format='' \
    sdkconfig.clean sdkconfig.project \
    >sdkconfig.defaults
# remove comment lines
sed -i '/^# .*/d' sdkconfig.defaults

# place sdkconfig
mv sdkconfig.project sdkconfig

# cleaning
rm sdkconfig.clean

echo 'updated sdkconfig and sdkconfig.default to current ESP-IDF version'
