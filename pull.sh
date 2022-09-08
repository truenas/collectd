#!/bin/bash -ex
VERSION=5.12.0
REVISION=11

wget http://deb.debian.org/debian/pool/main/c/collectd/collectd_$VERSION-$REVISION.debian.tar.xz
tar xf collectd_$VERSION-$REVISION.debian.tar.xz
rm collectd_$VERSION-$REVISION.debian.tar.xz

wget http://deb.debian.org/debian/pool/main/c/collectd/collectd_$VERSION.orig.tar.xz
tar xf collectd_$VERSION.orig.tar.xz --strip 1
rm collectd_$VERSION.orig.tar.xz

cp aggregation-cpu.patch debian/patches
echo 'aggregation-cpu.patch' >> debian/patches/series

sed -i 's/, default-jre-headless//g' debian/control

cp logs.patch debian/patches
echo 'logs.patch' >> debian/patches/series

echo -e "$(cat changelog)\n\n$(cat debian/changelog)" > debian/changelog
