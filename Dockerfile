FROM oraclelinux:7.1
MAINTAINER Stas Alekseev <stas.alekseev@gmail.com>

ENV RUBY_VERSION 2.1.6
ENV RBENV_ROOT /usr/local/rbenv
ENV PATH $RBENV_ROOT/shims:$RBENV_ROOT/bin:$PATH
ENV RBENV_VERSION $RUBY_VERSION

WORKDIR /root

RUN yum --enablerepo ol7_optional_latest -y --color=never install \
         gcc \
         make \
         patch \
         gcc-c++ \
         readline-devel \
         libyaml-devel \
         libffi-devel \
         openssl-devel \
         tar \
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
    && git clone https://github.com/garnieretienne/rvm-download.git $RBENV_ROOT/plugins/rvm-download \
    && git clone https://github.com/sstephenson/rbenv-gem-rehash.git $RBENV_ROOT/plugins/rbenv-gem-rehash \
    && RUBY_CONFIGURE_OPTS=--disable-install-doc rbenv install $RUBY_VERSION \
    && find $RBENV_ROOT -type f | xargs strip -g -S -d --strip-debug \
    && rbenv global $RUBY_VERSION \
    && rbenv rehash \
    && echo "gem: --no-document --no-ri --no-rdoc\n" >> ~/.gemrc \
    && yum -y --color=never autoremove \
         gcc \
         patch \
         gcc-c++ \
         readline-devel \
         libyaml-devel \
         openssl-devel \
         tar \
         bzip2 \
         autoconf \
         automake \
         libtool \
         bison \
         libicu-devel \
         zlib-devel \
         git \
    && yum -y --color=never clean all

CMD ["irb"]
