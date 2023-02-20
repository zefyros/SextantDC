FROM ubuntu:22.04

ENV PORT 8080
ENV TOMCAT_MAJOR_VERSION 8
ENV TOMCAT_MINOR_VERSION 8.0.23

# INSTALL PREREQUISITIES
RUN apt-get update \
 && apt-get install -y \
    wget \
    openjdk-8-jdk \
    curl \
    git \
    mercurial \
    unzip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

USER root

# INSTALL TOMCAT
RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz \
 && wget -qO- https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz.md5 | md5sum -c - \
 && tar zxf apache-tomcat-*.tar.gz \
 && rm apache-tomcat-*.tar.gz \
 && mv apache-tomcat* tomcat

RUN curl -O -L https://github.com/zefyros/Sextant-DeepCube/raw/master/JerseyServer/target/Sextant-3.0.0.war \
 && mv Sextant-3.0.0.war /tomcat/webapps/SextantDC.war

CMD ["/tomcat/bin/catalina.sh", "run"]

EXPOSE $PORT

