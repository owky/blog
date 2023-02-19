FROM ruby:3.0

COPY Gemfile Gemfile.lock ./

RUN bundle install

RUN echo 'alias jekyll-serve="jekyll serve -H 0.0.0.0 --drafts"' >> /etc/bash.bashrc

WORKDIR /work
