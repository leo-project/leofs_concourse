FROM ubuntu:14.04
RUN \
apt-get -qq update && \
apt-get -qq install wget software-properties-common gcc g++ cmake make check libtool lsb-release git && \
apt-get -qq clean && \
rm -rf /var/lib/apt/lists/
RUN \
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb -O /tmp/esl.deb && \
dpkg -i /tmp/esl.deb && \
rm /tmp/esl.deb && \
apt-get -qq update && \
apt-get -qq install esl-erlang &&\
apt-get -qq clean && \
rm -rf /var/lib/apt/lists/
