# docker build -t userms-image .
# docker run -d -p 3000:3000 --name userms userms-image

FROM ruby:latest

MAINTAINER Ariel Aleksandrus

COPY . /userms
WORKDIR /userms

RUN apt-get update -qq && apt-get install -y build-essential

RUN apt-get install -y nodejs
RUN apt-get install -y git

RUN gem install rails --no-ri --no-rdoc
RUN bundle install


EXPOSE 3000

CMD rails s -e $RAILS_MODE -p 3000 -b 0.0.0.0
