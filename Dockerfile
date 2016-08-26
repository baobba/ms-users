# docker build -t userms-image .
# docker run -d -p 3000:3000 --name userms userms-image

FROM ruby:latest

MAINTAINER Ariel Aleksandrus

ENV RAILS_ENV=development
ENV PORT=3000
COPY . /userms
WORKDIR /userms

RUN apt-get update -qq && apt-get install -y build-essential

RUN apt-get install -y mongodb
RUN apt-get install -y nodejs
RUN apt-get install -y git

RUN gem install rails --no-ri --no-rdoc
RUN bundle install


EXPOSE $PORT

CMD service mongodb start; rails s -e $RAILS_ENV -b 0.0.0.0
