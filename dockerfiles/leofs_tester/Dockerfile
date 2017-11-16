FROM ubuntu:16.04
RUN \
   apt-get -qq update \
&& apt-get -qq install git curl software-properties-common build-essential cmake \
&& apt-get -qq clean \
&& rm -rf /var/lib/apt/lists/
RUN \
   add-apt-repository ppa:gophers/archive

RUN \
   apt-get update \
&& apt-get install -y erlang \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/

RUN \
   apt-get update \
&& apt-get install -y golang-1.8 \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/

RUN \
   apt-get update \
&& apt-get install -y ant openjdk-8-jdk maven \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/

RUN \
   apt-get update \
&& apt-get install -y php php-curl php-xml \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/

RUN \
   apt-get update \
&& apt-get install -y ruby ruby-dev libmagic-dev zlib1g-dev \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/ \
&& gem install aws-sdk content_type

RUN \
   apt-get update \
&& apt-get install -y python python-pip \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/ \
&& pip install boto filechunkio boto3

ENV PATH=/usr/lib/go-1.8/bin:$PATH

RUN \
   go get github.com/aws/aws-sdk-go/service/s3

## aws-sdk-cpp
RUN \
   apt-get update \
&& apt-get install -y libssl-dev libcurl4-openssl-dev \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/

##RUN \
##   curl -sL https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb -o /tmp/esl.deb \
##&& dpkg -i /tmp/esl.deb \
##&& rm /tmp/esl.deb
##RUN \
##  apt-get update && \
##FROM ubuntu:14.04
##RUN \
##apt-get update && apt-get install -y git curl software-properties-common build-essential
##RUN \
##add-apt-repository -y ppa:ubuntu-lxc/lxd-stable
##RUN \
##apt-get update && apt-get install -y golang
##RUN \
##apt-get install -y ant openjdk-7-jdk
##RUN \
##apt-get install -y php5 php5-curl
##RUN \
##apt-get install -y ruby ruby-dev libmagic-dev zlib1g-dev
##RUN \
##apt-get install -y python python-pip
##RUN \
##(curl -sL http://packages.erlang-solutions.com/site/esl/esl-erlang/FLAVOUR_1_general/esl-erlang_19.3.6-1~ubuntu~trusty_amd64.deb -o esl-erlang.deb && \
##dpkg -i esl-erlang.deb; \
##apt-get install -y -f && \
##rm esl-erlang.deb)
##RUN \
##apt-get install -y maven
##RUN \
##mkdir $HOMR/go && export GOPATH=$HOME/go && go get github.com/aws/aws-sdk-go/service/s3 && \
##gem install aws-sdk content_type && \
##pip install boto filechunkio boto3
