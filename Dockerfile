FROM ruby:3.4.2

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  nodejs \
  watchman \
  postgresql-client \
  build-essential \
  chromium-driver \
  chromium \
  && rm -rf /var/lib/apt/lists/*

RUN gem install foreman

WORKDIR /app
COPY Gemfile ./
RUN bundle install
COPY . .


