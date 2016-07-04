FROM ubuntu:14.04.4
RUN \
apt-get -qq update && apt-get -qq install git curl software-properties-common build-essential
RUN \
add-apt-repository -y ppa:ubuntu-lxc/lxd-stable
RUN \
apt-get -qq update && apt-get -qq install golang
RUN \
apt-get -qq install ant openjdk-7-jdk
RUN \
apt-get -qq install php5 php5-curl
RUN \
apt-get -qq install ruby ruby-dev libmagic-dev zlib1g-dev
RUN \
apt-get -qq install python python-pip
RUN \
(curl -O https://packages.erlang-solutions.com/erlang/esl-erlang/FLAVOUR_1_general/esl-erlang_17.5.3-1~ubuntu~trusty_amd64.deb && \
dpkg -i esl-erlang_17.5.3-1~ubuntu~trusty_amd64.deb; \
apt-get -qq install -f && \
rm esl-erlang_17.5.3-1~ubuntu~trusty_amd64.deb)
RUN \
apt-get -qq install maven
RUN \
mkdir $HOMR/go && export GOPATH=$HOME/go && go get github.com/aws/aws-sdk-go/service/s3 && \
gem install aws-sdk content_type && \
pip install boto filechunkio
