FROM centos:centos6.6
MAINTAINER yoku0825
WORKDIR /root

RUN yum upgrade -y
RUN test -d /tmp/setup || mkdir /tmp/setup
RUN ln -sf /usr/share/zoneinfo/Japan /etc/localtime

RUN yum install -y http://dev.mysql.com/get/mysql57-community-release-el6-8.noarch.rpm
RUN yum install -y mysql-community-server
RUN service mysqld start

RUN yum install -y git python-devel rpm-build zip patch
COPY . /tmp/setup
RUN bash /tmp/setup/mikasafabric_build.sh
RUN yum install -y /root/rpmbuild/RPMS/noarch/mikasafabric-*.rpm

RUN patch /etc/my.cnf /tmp/setup/my.cnf.patch
RUN patch /etc/mysql/fabric.cfg /tmp/setup/fabric.cfg.patch
RUN bash /tmp/setup/init.sh

CMD service mysqld start && mysqlfabric manage start
