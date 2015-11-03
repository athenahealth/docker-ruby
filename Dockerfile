FROM oraclelinux:7.1

MAINTAINER Stas Alekseev <stas.alekseev@gmail.com>

RUN yum --assumeyes install \
      scl-utils \
      https://www.softwarecollections.org/en/scls/rhscl/rh-ruby22/epel-7-x86_64/download/rhscl-rh-ruby22-epel-7-x86_64.noarch.rpm \
    && yum --enablerepo ol7_optional_latest -y install \
      rh-ruby22 \
      rh-ruby22-rubygem-bundler \
    && echo "gem: --no-document --no-ri --no-rdoc\n" >> /etc/gemrc \
    && echo "source /opt/rh/rh-ruby22/enable" >> /root/.bashrc \
    && yum --assumeyes clean all \
    && rm -rf /var/cache/yum/*

CMD ["scl", "enable", "rh-ruby22", "irb"]
