FROM ruby
ENV RAILS_ENV production

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs cron vim && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /app
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install

#RUN echo '-------------- env ---------------'
#RUN env

COPY . ./

#RUN bundle exec whenever --update-crontab
RUN bundle exec rake assets:precompile assets:clean

CMD rm -f /app/tmp/pids/server.pid
CMD cron && bundle exec rails server -b 0.0.0.0 -p ${PORT:-3000}
#EXPOSE 3000
#CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
