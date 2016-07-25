#!/bin/bash
set -euo pipefail
set -o errexit
set -o errtrace
IFS=$'\n\t'

cd /mock/fuse
curl -O https://kojipkgs.fedoraproject.org/packages/fuse/2.9.7/1.fc24/src/fuse-2.9.7-1.fc24.src.rpm
/usr/bin/mock --yum  --no-cleanup-after --no-clean --resultdir=/builds --postinstall --rebuild /mock/fuse/fuse-2.9.7-1.fc24.src.rpm

cd /mock/s3fs-fuse
S3FS_COMMIT=$(git ls-remote https://github.com/s3fs-fuse/s3fs-fuse HEAD | awk '{ print $1 }')
curl -L https://github.com/s3fs-fuse/s3fs-fuse/archive/${S3FS_COMMIT}.tar.gz -o s3fs-fuse-${S3FS_COMMIT}.tar.gz
sed -i -e "s/Version:        1.79/Version:        ${S3FS_COMMIT}/g" s3fs-fuse.spec
sed -i -e "s/README/README.md/g" s3fs-fuse.spec
/usr/bin/mock --yum  --no-cleanup-after --no-clean --resultdir=/builds --buildsrpm --spec=s3fs-fuse.spec --sources=/mock/s3fs-fuse
/usr/bin/mock --yum  --no-cleanup-after --no-clean --resultdir=/builds --rebuild /builds/s3fs-fuse-${S3FS_COMMIT}-1.el7.centos.src.rpm

rm -rf /builds/*.log
