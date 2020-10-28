FROM ruby:2.6.6-stretch

RUN curl -sL https://deb.nodesource.com/setup_10.x

RUN apt-get update && apt-get install \
  build-essential \
  postgresql-client \
  nodejs \
  xorg \
  libssl-dev \
  libxrender-dev \
  wget \
  gdebi

RUN wget https://downloads.wkhtmltopdf.org/0.12/0.12.5/wkhtmltox_0.12.5-1.stretch_amd64.deb
RUN dpkg -i wkhtmltox_0.12.5-1.stretch_amd64.deb

WORKDIR /app
ADD Gemfile Gemfile.lock /app/
RUN bundle install
