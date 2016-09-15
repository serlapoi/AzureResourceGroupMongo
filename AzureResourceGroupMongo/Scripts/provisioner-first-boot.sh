#!/bin/sh

BASE_URL=https://downloads.bitnami.com/files/harpoon-bundle
shift
APP=$1
shift

# download application and retry
for RETRY in 1 2 3 4 5 ; do
  curl "$BASE_URL/provisioner-$APP-bundle.tar.gz" | tar -C / -xz
  if [ "x$?" = "x0" ] ; then
    break
  fi
  sleep $RETRY
done

mkdir -p /opt/bitnami/var/log
/opt/harpoon-linux-x64/bin/provisioner "$@" firstboot >/opt/bitnami/var/log/first-boot.log 2>&1
exit $?

