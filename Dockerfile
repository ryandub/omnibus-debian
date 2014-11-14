FROM debian:6
MAINTAINER ryan.walker@rackspace.com 

RUN echo 'deb http://ppa.launchpad.net/git-core/ppa/ubuntu lucid main\ndeb-src http://ppa.launchpad.net/git-core/ppa/ubuntu lucid main' > /etc/apt/sources.list.d/git.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E1DF1F24
RUN echo 'deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu lucid main\ndeb-src http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu lucid main' > /etc/apt/sources.list.d/ruby.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C3173AA6

RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    ruby1.9.3 \
    rubygems \
    ruby-switch \
    libssl-dev \
    libreadline-dev \
    libxslt1-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    zlib1g-dev \
    libexpat1-dev \
    libicu-dev \
    python2.6

RUN ln -s /usr/bin/python2.6 /usr/bin/python

RUN gem install bundler --no-ri --no-rdoc

RUN git config --global url."https://".insteadOf git://
RUN git config --global user.email ryan.walker@rackspace.com
RUN git config --global user.name "Ryan Walker"

RUN git clone https://github.com/ryandub/omnibus-ohai-solo.git && \
    cd omnibus-ohai-solo && \
    bundle install --binstubs

WORKDIR /omnibus-ohai-solo
