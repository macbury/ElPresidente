FROM ruby:3-alpine

RUN apk add --no-cache build-base tzdata && cp -r -f /usr/share/zoneinfo/Europe/Warsaw /etc/localtime

ENV UID=9666
ENV GID=9666

RUN mkdir -p /elpresidente
WORKDIR /elpresidente

RUN addgroup -g $GID -S elpresidente 
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/elpresidente" \
    --ingroup "elpresidente" \
    --no-create-home \
    --uid "$UID" \
    "elpresidente"

COPY Gemfile .
COPY Gemfile.lock .
COPY elpresidente.gemspec .
COPY lib/elpresidente/version.rb lib/elpresidente/version.rb 

RUN bundle config set without 'test development' \
    && bundle install --path=vendor/bundle \
    && rm -rf vendor/bundle/ruby/3.0.0/cache/*.gem \
    && find vendor/bundle/ruby/3.0.0/gems/ -name "*.c" -delete \
    && find vendor/bundle/ruby/3.0.0/gems/ -name "*.o" -delete

COPY . .

RUN chown -R elpresidente:elpresidente /elpresidente
USER elpresidente

CMD ["exe/elpresidente"]