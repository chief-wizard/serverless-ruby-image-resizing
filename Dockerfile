FROM ruby:2.5.3
WORKDIR /deploy

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -qq --no-install-recommends \
  nodejs \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN npm install -g serverless

RUN gem install bundler

COPY . .

# install ruby dependencies
RUN bundle install --path vendor/bundle

RUN ["chmod", "+x", "deploy.sh"]

CMD ./deploy.sh
