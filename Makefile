.PHONY: build clean rpms shell

build:
	@docker build -t rjocoleman/fuse-build .

clean:
	@rm -rf /tmp/rpmbuild

rpms:
	@docker run --privileged=true --rm -v /tmp/rpmbuild:/rpmbuild -v ${PWD}/builds:/builds -t -i rjocoleman/fuse-build /build-rpm.sh

shell:
	@docker run --privileged=true --rm -v /tmp/rpmbuild:/rpmbuild -v ${PWD}/builds:/builds -t -i rjocoleman/fuse-build /bin/bash
