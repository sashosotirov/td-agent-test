FROM centos:7

ENV APP_LOG_PATH /tmp/
ENV APP_NAME wildfly

USER root

COPY td-agent.repo /etc/yum.repos.d/td-agent.repo

RUN rpmkeys --import file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
RUN yum update -y
RUN rpm --import https://packages.treasuredata.com/GPG-KEY-td-agent
RUN yum -y install td-agent

COPY td-agent.conf /etc/td-agent/
COPY entrypoint.sh /
COPY test.log /tmp/


# install td-agent plugins
#RUN /usr/sbin/td-agent-gem install fluent-plugin-gcloud-pubsub

ENTRYPOINT ["/entrypoint.sh"]


