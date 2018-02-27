# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...



rails-dokcer-sample
=====

## 起動方法

**Docker version 1.9 以上**

* コンテナのイメージのビルド

```
docker build --build-arg SECRET_KEY_BASE=$(bundle exec rake secret) -t takigawa/bookrep .
```

* app.1 コンテナの起動

```
docker run -d --name app.1 --hostname app.1 -p 3000:3000 -e DATABASE_URL="Your Database url" takigawa/bookrep
```

* app.2 コンテナの起動

```
docker run -d --name app.2 --hostname app.2 -p 3001:3000 -e DATABASE_URL="Your Database url" takigawa/bookrep
```
