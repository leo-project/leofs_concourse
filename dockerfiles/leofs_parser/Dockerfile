FROM ubuntu:14.04.4
RUN \
apt-get -qq update && apt-get -qq install wget libfontconfig
RUN \
wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
&& tar xf phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN \
cd phantomjs-2.1.1-linux-x86_64/bin && wget \
https://gist.githubusercontent.com/windkit/179486f732d0335376d29dbae824fb9f/raw/280f2c0eb4957faf7fe31763bcb1dd653a0afe51/capture_5s.js
RUN \
apt-get -qq install git
RUN \
apt-get -qq install curl
