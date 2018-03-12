FROM ruby
ENV RAILS_ENV production

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /app
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . ./

RUN bundle exec rake assets:precompile assets:clean

CMD bundle exec rails server -b 0.0.0.0 -p ${PORT:-3000}
#EXPOSE 3000
#CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
