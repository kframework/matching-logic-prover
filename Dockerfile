FROM ubuntu:bionic

ENV TZ=America/Chicago
RUN    ln --symbolic --no-dereference --force /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

RUN    apt update                                                          \
    && apt upgrade --yes                                                   \
    && apt install --yes                                                   \
           autoconf build-essential curl flex gcc git libffi-dev libmpfr-dev \
           libtool make maven ninja-build netcat openjdk-8-jdk pandoc      \
           pkg-config python python3 python3-distutils wget zlib1g-dev zip

RUN update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java

RUN apt install --yes cvc4
RUN    git clone 'https://github.com/z3prover/z3' --branch=z3-4.8.4 \
    && cd z3                                                        \
    && python scripts/mk_make.py                                    \
    && cd build                                                     \
    && make -j8                                                     \
    && make install                                                 \
    && cd ../..                                                     \
    && rm -rf z3

ARG USER_ID=1000
ARG GROUP_ID=1000
RUN    groupadd --gid $GROUP_ID user                                        \
    && useradd --create-home --uid $USER_ID --shell /bin/sh --gid user user
USER $USER_ID:$GROUP_ID

ENV LC_ALL=C.UTF-8
