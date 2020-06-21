ARG K_COMMIT
FROM runtimeverificationinc/kframework-k:ubuntu-bionic-${K_COMMIT}

ENV TZ=America/Chicago
RUN    ln --symbolic --no-dereference --force /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

RUN    apt update                                                          \
    && apt upgrade --yes                                                   \
    && apt install --yes                                                   \
        autoconf             \
        bison                \
        clang-8              \
        cmake                \
        curl                 \
        debhelper            \
        flex                 \
        gcc                  \
        git                  \
        libboost-test-dev    \
        libffi-dev           \
        libgmp-dev           \
        libjemalloc-dev      \
        libmpfr-dev          \
        libtool              \
        libyaml-dev          \
        libz3-dev            \
        lld-8                \
        llvm-8-tools         \
        make                 \
        maven                \
        ninja-build          \
        opam                 \
        openjdk-11-jdk       \
        openjdk-8-jdk        \
        pandoc               \
        pkg-config           \
        python3              \
        python3-graphviz     \
        time                 \
        z3                   \
        zlib1g-dev

RUN update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java

RUN apt install --yes cvc4 z3

ARG USER_ID=1000
ARG GROUP_ID=1000
RUN    groupadd --gid $GROUP_ID user                                        \
    && useradd --create-home --uid $USER_ID --shell /bin/sh --gid user user
USER $USER_ID:$GROUP_ID

ADD --chown=user . /home/user/matching-logic-prover
WORKDIR /home/user/matching-logic-prover/prover
RUN ./build -v unit-tests smoke-tests

ENV LC_ALL=C.UTF-8
