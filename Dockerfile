FROM ruby:3.4.5

WORKDIR /app
COPY Gemfile* ./
RUN bundle install

COPY . .

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
