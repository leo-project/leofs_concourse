FROM williamyeh/ansible:ubuntu14.04
RUN apt-get -qq update && apt-get -qq install wget make git
RUN apt-get -qq remove ansible
RUN wget https://github.com/ansible/ansible/releases/download/v2.0.0.1-1/ansible-2.0.0.1.tar.gz && \
	tar xf ansible-2.0.0.1.tar.gz && \
	cd ansible-2.0.0.1 && \
	make && make install
RUN echo "[defaults]" > ~/.ansible.cfg; \
	echo "host_key_checking = False" >> ~/.ansible.cfg
