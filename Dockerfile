FROM centos:7

WORKDIR /mock

RUN yum -y install deltarpm; \
 yum -y update; \
 yum -y groupinstall 'Development tools'; \
 \
 yum install -y epel-release; \
 rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7; \
 \
 yum install -y fedora-packager; \
 \
 yum clean all;

RUN useradd -G mock builduser; \
 mkdir -p /builds /mock/fuse /mock/s3fs-fuse /rpmbuild; \
 \
 install -g mock -m 2775 -d /rpmbuild/cache/mock; \
 echo "config_opts['cache_topdir'] = '/rpmbuild/cache/mock'" >> /etc/mock/site-defaults.cfg;

RUN chown -R builduser /mock /builds /rpmbuild
USER builduser

VOLUME ["/builds", "/rpmbuild"]

COPY s3fs/* /mock/s3fs-fuse/
COPY build-rpm.sh /

CMD ["/build-rpm.sh"]
