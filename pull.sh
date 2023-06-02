#!/bin/bash -ex
VERSION=5.12.0
REVISION=14
BASEURL="https://launchpad.net/debian/+source/collectd/$VERSION-$REVISION"

# download revision source
REVISION_FILE="collectd_$VERSION-$REVISION.debian.tar.xz"
wget "$BASEURL/$REVISION_FILE"
tar xf $REVISION_FILE
rm $REVISION_FILE

# download version source
VERSION_FILE="collectd_$VERSION.orig.tar.xz"
wget "$BASEURL/$VERSION_FILE"
tar xf $VERSION_FILE --strip 1
rm $VERSION_FILE

cp aggregation-cpu.patch debian/patches
echo 'aggregation-cpu.patch' >> debian/patches/series

sed -i 's/, default-jre-headless//g' debian/control

cp logs.patch debian/patches
echo 'logs.patch' >> debian/patches/series

echo -e "$(cat changelog)\n\n$(cat debian/changelog)" > debian/changelog
