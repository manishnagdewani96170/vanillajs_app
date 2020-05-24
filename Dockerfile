FROM ruby:2.5.3

# Setup environment variables that will be available to the instance
ENV APP_HOME /web

# Installation of dependencies
RUN apt-get update && \
apt-get install -y nodejs

# Create a directory for our application
# and set it as the working directory

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Add our Gemfile
# and install gems

ADD Gemfile* $APP_HOME/
RUN bundle install

# Copy over our application code
ADD . $APP_HOME

RUN bundle exec rake db:migrate assets:precompile

# Run our app
CMD rails s