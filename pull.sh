#!/bin/bash -ex
BASEURL="https://launchpad.net/debian/+archive/primary/+sourcefiles/collectd/5.12.0-11/"

# download revision source
REVISION_FILE="collectd_5.12.0-11.debian.tar.xz"
wget $BASEURL$REVISION_FILE
tar xf $REVISION_FILE
rm $REVISION_FILE

# download version source
VERSION_FILE="collectd_5.12.0.orig.tar.xz"
wget $BASEURL$VERSION_FILE
tar xf $VERSION_FILE --strip 1
rm $VERSION_FILE

cp aggregation-cpu.patch debian/patches
echo 'aggregation-cpu.patch' >> debian/patches/series

sed -i 's/, default-jre-headless//g' debian/control

cp logs.patch debian/patches
echo 'logs.patch' >> debian/patches/series

echo -e "$(cat changelog)\n\n$(cat debian/changelog)" > debian/changelog
