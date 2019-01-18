FROM ubuntu:14.04
COPY . /debian
RUN apt-get update && apt-get install -y \
  ruby \
  ruby-dev \
  build-essential \
  wget \
  cmake

RUN gem install --no-ri --no-rdoc fpm