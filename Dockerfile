# This file describes how to build Redis into a runnable linux container with all dependencies installed
# To build:
# 1) Install docker (http://docker.io)
# 2) Build: docker build - < Dockerfile
# 3) Run: docker run -d <imageid> OR docker run -d <imageid> /usr/local/bin/redis-server -c /path/to/config/file
#
# VERSION 2.8-unstable
# DOCKER-VERSION 0.4.0
#
# start Redis with `docker run <imageid>` for the default parameters
# OR `docker run <imageid> /usr/local/bin/redis-server -c /path/to/config/file` if you need to customize

FROM ubuntu
MAINTAINER John Costa <john.costa@gmail.com>

# install your dependencies
RUN apt-get update
RUN apt-get upgrade
RUN apt-get install -y wget make gcc tcl8.5 git 
RUN apt-get install -y expect

# Download and Install Redis
RUN git clone -b 2.8 https://github.com/antirez/redis.git
RUN cd /redis/src/; make install; make test

# Redis installs with prompts to control configuration
# Use the expect script to select the default configuration 
RUN cd /redis/utils/; wget --no-check-certificate https://raw.github.com/johncosta/redis/2.8-dockerized/utils/expect_configure.sh 
RUN chmod 755 /redis/utils/expect_configure.sh 
RUN /redis/utils/expect_configure.sh

# Expose the default redis port
EXPOSE :6379

# Start Redis
CMD /usr/local/bin/redis-server 
