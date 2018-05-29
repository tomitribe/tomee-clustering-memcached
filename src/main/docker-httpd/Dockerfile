FROM centos:latest

RUN yum -y install httpd
RUN yum clean all

COPY mod_proxy.conf /etc/httpd/conf.d/

EXPOSE 80

CMD /usr/sbin/httpd -D FOREGROUND