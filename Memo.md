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

- yum
sudo yum update -y
sudo yum install -y git tmux epel-release iptables-services logwatch denyhosts
- vps基本設計
https://qiita.com/ryo_dg/items/2395de5b29aa44681aa0
visudo
- base secrity
https://dogmap.jp/2011/05/12/vps-security/

- github
https://qiita.com/katsukii/items/9fd5bbe822904d7cdd0a


- postgres
postgres=# alter role postgres with password '';
ALTER ROLE
postgres=# create role thoth createdb login password '';
CREATE ROLE
postgres=# create database bookrep_db;
CREATE DATABASE

- docker
https://qiita.com/progrhyme/items/116948c9fef37f3e995b
docker tag temy13/bookrep:v1.2 localhost:5000/temy13/bookrep:v1.2
docker push localhost:5000/temy13/bookrep:v1.2
-
https://qiita.com/irotoris/items/f3b98feb69807f450984
https://qiita.com/miwato/items/9770a2a757d3f5e369a4

sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT
sudo iptables -A FORWARD -j REJECT --reject-with icmp-host-prohibited
sudo iptables -I INPUT 2 -p tcp ! --syn -m state --state NEW -j DROP
sudo iptables -I INPUT 2 -p tcp --tcp-flags ALL ALL -j DROP
sudo iptables -A INPUT -s 172.18.0.0/24 -p tcp --dport 5432 -j ACCEPT
sudo iptables -A INPUT -s 172.18.0.2 -p tcp --dport 5432 -j ACCEPT
sudo iptables -A INPUT -s 172.18.0.3 -p tcp --dport 5432 -j ACCEPT
sudo iptables -A INPUT -j LOG --log-prefix "IPTABLES DROP:" --log-level=debug
sudo iptables -A INPUT -J REJECT --reject-with icmp-host-prohibited
sudo iptables -A INPUT -j DROP

-A INPUT -s 192.0.2.100 -p tcp --dport 3306 -j ACCEPT
 iptables -A INPUT -s 172.18.0.0/24 -i eth0 -p tcp -m state --state NEW -m tcp --dport 5432 -j ACCEPT


 docker run --rm -p 443:443 -p 80:80  --name letsencrypt  -v "/etc/letsencrypt:/etc/letsencrypt"  -v "/var/lib/letsencrypt:/var/lib/letsencrypt" certbot/certbot certonly -n -m "bookrep.contact@gmail.com" -d bookrep.tokyo -d www.bookrep.tokyo  --standalone --agree-tos


no "ssl_certificate" is defined in server listening on SSL port while SSL handshaking,
listen 443 ssl default_server;
