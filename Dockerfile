FROM debian:jessie

RUN apt-get update \
  && apt-get install -y build-essential make unrar-free autoconf automake libtool gcc g++ gperf \
  flex bison texinfo gawk ncurses-dev libexpat-dev python python-serial sed \
  git unzip bash wget libtool-bin help2man python-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && useradd --no-create-home micropython

RUN git clone --recursive https://github.com/pfalcon/esp-open-sdk.git \
  && git clone https://github.com/micropython/micropython.git \
  && cd micropython && git submodule update --init \
  && chown -R micropython:micropython ../esp-open-sdk ../micropython

USER micropython

RUN cd esp-open-sdk && make STANDALONE=y

ENV PATH=/esp-open-sdk/xtensa-lx106-elf/bin:$PATH

RUN cd micropython/esp8266 && make axtls && make

