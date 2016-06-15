FROM erlang:17.5
RUN \ 
git clone https://github.com/leo-project/basho_bench.git && \
cd basho_bench && \
git checkout 1.4 && \
make
RUN \
git clone https://github.com/leo-project/leofs_concourse
