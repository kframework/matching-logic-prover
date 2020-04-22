FROM ubuntu:bionic

ENV TZ=America/Chicago
RUN    ln --symbolic --no-dereference --force /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

RUN    apt update                                                          \
    && apt upgrade --yes                                                   \
    && apt install --yes                                                   \
        autoconf curl flex gcc libffi-dev libmpfr-dev libtool make         \                                          
        maven ninja-build opam openjdk-8-jdk pandoc pkg-config python3     \                                          
        python-pygments python-recommonmark python-sphinx time zlib1g-dev

RUN update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java

RUN apt install --yes cvc4 wget

ARG USER_ID=1000
ARG GROUP_ID=1000
RUN    groupadd --gid $GROUP_ID user                                        \
    && useradd --create-home --uid $USER_ID --shell /bin/sh --gid user user
USER $USER_ID:$GROUP_ID

RUN    cd /home/user/                                                                               \
    && wget https://github.com/Z3Prover/z3/releases/download/z3-4.8.7/z3-4.8.7-x64-ubuntu-16.04.zip \
    && unzip z3-4.8.7-x64-ubuntu-16.04.zip 
ENV PATH="/home/user/z3-4.8.7-x64-ubuntu-16.04/bin:${PATH}"

ADD --chown=user . /home/user/matching-logic-prover
WORKDIR /home/user/matching-logic-prover/prover
RUN ./build -v unit-tests smoke-tests

ENV LC_ALL=C.UTF-8
