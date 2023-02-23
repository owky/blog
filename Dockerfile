FROM ruby:2.7.4

COPY Gemfile Gemfile.lock ./

RUN bundle install

RUN echo 'alias jekyll-serve="jekyll serve -H 0.0.0.0 --drafts"' >> /etc/bash.bashrc

WORKDIR /work
