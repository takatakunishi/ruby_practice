FROM ruby:2.7.6-bullseye

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs vim
# build-essential => 開発に必須のビルドツールを提供しているパッケージ. gcc(GNU C Compiler)とかg++(GNU C++ Compiler), makeとかその他色々入る.
# libpq-dev => Header files and static library for compiling C programs to link with the libpq library in order to communicate with a PostgreSQL database backend.
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp


# # yarnパッケージ管理ツールをインストール
# RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
# curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
# echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
# apt-get update && apt-get install -y yarn

# RUN apt-get update -qq && apt-get install -y nodejs yarn
# RUN mkdir /myapp
# WORKDIR /myapp
# COPY Gemfile /myapp/Gemfile
# COPY Gemfile.lock /myapp/Gemfile.lock
# RUN bundle install
# COPY . /myapp

# RUN yarn install --check-files
# RUN bundle exec rails webpacker:compile

# # コンテナ起動時に実行させるスクリプトを追加
# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
# EXPOSE 3000

# # Rails サーバ起動
# CMD ["rails", "server", "-b", "0.0.0.0"]