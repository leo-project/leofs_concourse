FROM windkithk/leofs_deploy:latest
MAINTAINER Yoshiyuki.Kanno <nekotaroh@gmail.com>
RUN set -x && \
    cd && \
    apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install curl build-essential libncurses5-dev libssl-dev && \
    curl https://raw.githubusercontent.com/kerl/kerl/master/kerl -o /usr/local/bin/kerl && \
    chmod a+x /usr/local/bin/kerl && \
    kerl build 17.5 17.5_ssl && \
    kerl install 17.5_ssl /usr/local/erlang && \
    echo "source /usr/local/erlang/activate" >> .bashrc
EXPOSE 22
CMD ["/bin/bash"]
