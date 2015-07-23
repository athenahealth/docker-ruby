FROM centos:7
MAINTAINER Stas Alekseev <stas.alekseev@gmail.com>

ENV RUBY_VERSION 2.1.5
ENV RBENV_ROOT /usr/local/rbenv
ENV PATH $RBENV_ROOT/bin:$PATH

WORKDIR /root
    
RUN yum -y --color=never clean all \
    && yum -y --color=never install \
         gcc \
         make \
         patch \
         gcc-c++ \
         readline \
         readline-devel \
         libyaml \
         libyaml-devel \
         libffi \
         libffi-devel \
         openssl-devel \
         bzip2 \
         autoconf \
         automake \
         libtool \
         bison \
         libicu \
         libicu-devel \
         zlib-devel \
         git \
    && git clone https://github.com/sstephenson/rbenv.git $RBENV_ROOT \
    && git clone https://github.com/sstephenson/ruby-build.git $RBENV_ROOT/plugins/ruby-build \
    && git clone https://github.com/sstephenson/rbenv-gem-rehash.git $RBENV_ROOT/plugins/rbenv-gem-rehash \
    && RUBY_CONFIGURE_OPTS=--disable-install-doc rbenv install --verbose $RUBY_VERSION \
    && rbenv global $RUBY_VERSION \
    && rbenv rehash \
    && echo "gem: --no-document --no-ri --no-rdoc\n" >> ~/.gemrc \
    && yum -y --color=never autoremove \
         gcc \
         patch \
         gcc-c++ \
         readline-devel \
         libyaml-devel \
         libffi-devel \
         openssl-devel \
         bzip2 \
         autoconf \
         automake \
         libtool \
         bison \
         libicu-devel \
         zlib-devel \
         git \
    && yum -y --color=never clean all
