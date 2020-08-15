FROM ubuntu:bionic

ENV TZ=America/Chicago
RUN    ln --symbolic --no-dereference --force /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

RUN    apt update                                                          \
    && apt upgrade --yes                                                   \
    && apt install --yes                                                   \
        autoconf curl flex gcc libffi-dev libmpfr-dev libtool make         \                                          
        maven ninja-build opam openjdk-8-jdk pandoc pkg-config python3     \                                          
        time zlib1g-dev z3 cvc4 wget

RUN update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java

ARG USER_ID=1000
ARG GROUP_ID=1000
RUN    groupadd --gid $GROUP_ID user                                        \
    && useradd --create-home --uid $USER_ID --shell /bin/sh --gid user user
USER $USER_ID:$GROUP_ID

ADD --chown=user . /home/user/prover
WORKDIR /home/user/prover/

RUN git submodule update --init --recursive
RUN cd linear-temporal-logic && ./build prover-kore
RUN cd separation-logic      && ./build prover-smt
RUN cd separation-logic-2    && ./build prover-kore prover-smt

ENV LC_ALL=C.UTF-8
