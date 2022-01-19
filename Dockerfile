FROM ruby:2.7

COPY Gemfile Gemfile.lock ./

RUN bundle install

RUN echo 'alias jekyll-serve="jekyll serve -H 0.0.0.0 --drafts"' >> /etc/bash.bashrc

RUN export uid=1000 gid=1000 && \
echo "jekyll:x:${uid}:${gid}:jekyll::/bin/bash" >> /etc/passwd && \
echo "jekyll:x:${uid}:" >> /etc/group

USER jekyll

WORKDIR /work

ENTRYPOINT ["jekyll"]
CMD ["--help"]
