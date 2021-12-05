FROM ruby:2.7

COPY Gemfile Gemfile.lock ./

RUN bundle install

WORKDIR /work

CMD ["jekyll", "serve", "-H", "0.0.0.0"]