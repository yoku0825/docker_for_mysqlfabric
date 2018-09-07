FROM centos:centos6.9
MAINTAINER yoku0825
WORKDIR /root

RUN yum upgrade -y && yum clean all
RUN test -d /opt/setup || mkdir /opt/setup
RUN ln -sf /usr/share/zoneinfo/Japan /etc/localtime

RUN yum install -y http://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm && yum clean all
RUN yum install -y mysql-community-server patch && yum clean all

COPY . /opt/setup
RUN service mysqld start
RUN patch /etc/my.cnf /opt/setup/my.cnf.patch
RUN patch /usr/bin/mysqld_safe /opt/setup/mysqld_safe.patch
RUN bash /opt/setup/init.sh

CMD service mysqld start && tail -f /dev/null
