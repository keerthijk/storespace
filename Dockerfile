# Base our image on an official, minimal image of our preferred Ruby

FROM ruby:2.4
# Install essential Linux packages

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client nodejs
# Define where our application will live inside the image

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock
# Copy the Rails application into place

COPY . .
# Prevent bundler warnings; ensure that the bundler version executed is >= that which created Gemfile.lock

RUN gem install bundler
# Finish establishing our Ruby environment

RUN bundle install
# Define the script we want run once the container boots

CMD puma -C config/puma.rb
