FROM centos:centos7
MAINTAINER yoku0825
WORKDIR /root

RUN yum upgrade -y && yum clean all
RUN test -d /opt/setup || mkdir /opt/setup
RUN ln -sf /usr/share/zoneinfo/Japan /etc/localtime

RUN yum install -y http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm && yum clean all
RUN yum install -y mysql-router-2.0.4 && yum clean all

COPY router.ini /opt/setup/router.ini

ENTRYPOINT ["/usr/sbin/mysqlrouter", "--extra-config=/opt/setup/router.ini"]
