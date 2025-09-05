FROM ruby:3.4.5

WORKDIR /app
COPY Gemfile* ./
RUN bundle install

COPY . .

ENV SECRET_KEY_BASE=secret_key

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
