FROM ruby:2.6.6
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Add yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update && apt install yarn

# Add project 
RUN mkdir /mentor.io
WORKDIR /mentor.io
COPY Gemfile /mentor.io/Gemfile
COPY Gemfile.lock /mentor.io/Gemfile.lock
RUN gem update --system
RUN bundle install
COPY . /mentor.io

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 8080

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
