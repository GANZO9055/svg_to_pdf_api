FROM ruby:3.4.5

WORKDIR /app
COPY Gemfile* ./
RUN bundle install

COPY . .

EXPOSE 8080
CMD ["bundle", "exec", "puma", "-b", "tcp://0.0.0.0:8080", "-e", "development"]
