FROM ruby:3.4.2

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  nodejs \
  postgresql-client \
  chromium-driver \
  chromium \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY Gemfile ./
RUN bundle install
COPY . .
