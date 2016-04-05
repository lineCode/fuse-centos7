# Fuse Building for epel-7-x86_64

* Fuse 2.9.4 backported from Fedora Rawhide.
* s3fs-fuse from git master branch HEAD, RPM spec from https://github.com/juliogonzalez/s3fs-fuse-rpm

```shell
$ make build # build Docker build environment
$ make rpms # build RPMs

$ make shell # enter an interactive environment
$ make clean # clean host cache
```

### Notes

* Build RPMs end up in: `/builds`
* Some changes are made to `s3fs-fuse.spec` at run-time in `./build-rpm.sh`
* Uses `--privileged=true`.
* Mounts `/tmp/rpmbuild` from the host to use as cache for mock.
* RPMs are tagged centos but should work for anything `el7` `x86_64`.

### References

* https://github.com/mmornati/docker-mock-rpmbuilder
* https://github.com/juliogonzalez/s3fs-fuse-rpm
* https://apps.fedoraproject.org/packages/fuse
* http://centos-packages.com/7/package/fuse/
