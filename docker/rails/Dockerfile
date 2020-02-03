FROM ruby:2.6.3
RUN apt-get update -qq && \
  apt-get install -y apt-utils \
  build-essential \
  libpq-dev \
  nodejs \
  default-mysql-client \
  yarn
RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install -j4

ADD . /app

RUN mkdir -p tmp/sockets

EXPOSE 3000

