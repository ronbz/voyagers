ARG IMAGE="mcr.microsoft.com/cbl-mariner/base/core"
ARG TAG="2.0"
FROM ${IMAGE}:${TAG}

LABEL "Author"="Microsoft"
LABEL "Support"="Microsoft OpenJDK Support <openjdk-support@microsoft.com>"

ARG package="msopenjdk-21"
ARG PKGS="tzdata ca-certificates freetype shadow-utils"

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
ENV JAVA_HOME=/usr/lib/jvm/msopenjdk-21

RUN tdnf update -y && \
    tdnf install -y ${package} ${PKGS} && \
    tdnf clean all && \
    groupadd --system --gid=101 app && \
    adduser --uid 101 --gid 101 --system app && \
    install -d -m 0755 -o 101 -g 101 "/home/app" && \
    rm -rf /var/cache/tdnf && \
    rm -rf /usr/lib/jvm/${package}/lib/src.zip && \
    echo java -Xshare:dump && \
    java -Xshare:dump
