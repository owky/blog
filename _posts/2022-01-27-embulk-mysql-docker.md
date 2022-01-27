---
layout: post
title: Embulkを使ってデータをMySQLに投入する環境をDockerで構築する
date: 2022-01-27 00:00 +0000
---
ログデータをEmbulkでMySQLにロードし、それをダッシュボードツールで見れるようにするというのを仕事でよくやる。その環境をDockerで構築する、というのを勉強のためにやってみた。

## DockerでEmbulk実行環境を用意する
まずはベースとなるコンテナ上でEmbulkをインストールしてみて、上手く行ったらDockerfileを作成するという段取り。

### java8のコンテナにEmbulkをインストールしてみる

java8のイメージ

https://hub.docker.com/_/java

```
$ docker run -it java:8
```

java8のコンテナ上でEmbulkをインストールする。
公式ドキュメントに従う。

https://github.com/embulk/embulk#linux--mac--bsd

```
root@cf9fb92c44a3:/# curl --create-dirs -o ~/.embulk/bin/embulk -L "https://dl.embulk.org/embulk-latest.jar"
root@cf9fb92c44a3:/# chmod +x ~/.embulk/bin/embulk
root@cf9fb92c44a3:/# echo 'export PATH="$HOME/.embulk/bin:$PATH"' >> ~/.bashrc
root@cf9fb92c44a3:/# source ~/.bashrc
root@cf9fb92c44a3:/# embulk -v
Embulk v0.9.14
(略)
```

できた！

### Dockerfileをつくる
java8のベースイメージに、EmbulkをインストールするDockerfile。
`$HOME`下にパスを通すのが難しかったので、`/usr/local/bin`に実行ファイルを置くようにした。

```
FROM java:8

# embulk
RUN curl --create-dirs -o /usr/local/bin/embulk -L "https://dl.embulk.org/embulk-latest.jar" &&\
    chmod +x /usr/local/bin/embulk
```

buildして確かめる。

```
$ docker build -t embulk-test .
$ docker run -it embulk-test
```

Embulkの動作確認。

```
root@c5a6629627d1:/# embulk -v
Embulk v0.9.14
(略)
```

できた！


## MySQLをDockerで立てる
MySQLは公式のイメージをそのまま使う。

https://hub.docker.com/_/mysql

* ホスト側のポートは13306を割り当てた
* mysqlクライアントが古いので認証方式を`mysql_native_password`にした

```
$ docker run --name mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d -p 13306:3306 mysql mysqld --default-authentication-plugin=mysql_native_password
```

手元から接続できるか試す。
すぐに試すと、まだコンテナ側でMySQLが立ち上がってない場合があり、以下のエラーが出る。

```
ERROR 2013 (HY000): Lost connection to MySQL server at 'reading initial communication packet', system error: 0
```

ちょっと待てば大丈夫。

```
$ mysql -u root -p -h 127.0.0.1 -P 13306
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 8
Server version: 8.0.15 MySQL Community Server - GPL

Copyright (c) 2000, 2016, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
```

できた！

## Embulk → MySQL のコンテナ間通信
Dockerのネットワーク設定を作成し、そのネットワークを使うように docker run する。

```
$ docker network create my-network
$ docker run --name embulk --network my-network -it embulk-test
$ docker run --name mysql --network my-network -e MYSQL_ROOT_PASSWORD=my-secret-pw -p 13306:3306 -d mysql mysqld --default-authentication-plugin=mysql_native_password
```

EmbulkコンテナからMySQLコンテナにpingしてみる。

```
root@be9157abefa8:/# ping mysql
PING mysql (172.18.0.3): 56 data bytes
64 bytes from 172.18.0.3: icmp_seq=0 ttl=64 time=0.129 ms
64 bytes from 172.18.0.3: icmp_seq=1 ttl=64 time=0.114 ms
64 bytes from 172.18.0.3: icmp_seq=2 ttl=64 time=0.118 ms
```

できた！

## EmbulkでMySQLにデータを投入する

まずはコンテナ上で`embulk-output-mysql`プラグインを入れて試す。

https://github.com/embulk/embulk-output-jdbc/tree/master/embulk-output-mysql

```sh
$ docker attach embulk
root@be9157abefa8:/# embulk gem install embulk-output-mysql
```

サンプルデータのconfig.ymlを作成。

```
root@be9157abefa8:/# embulk example ./try1
root@be9157abefa8:/# embulk guess   ./try1/seed.yml -o config.yml
```

MySQLに出力するようにconfig.ymlを書き換える。

```
out:
  type: mysql
  host: mysql
  user: root
  password: "my-secret-pw"
  database: testdb
  table: sample
  mode: replace
```

MySQL側では事前に`CREATE DATABASE`しておく。
実行。

```
root@be9157abefa8:/# embulk run config.yml
```

結果の確認。

```
$ mysql -u root -p -h 127.0.0.1 -P 13306
mysql> use testdb
mysql> SELECT * FROM sample;
+------+---------+---------------------+---------------------+----------------------------+
| id   | account | time                | purchase            | comment                    |
+------+---------+---------------------+---------------------+----------------------------+
|    1 |   32864 | 2015-01-27 19:23:49 | 2015-01-27 00:00:00 | embulk                     |
|    2 |   14824 | 2015-01-27 19:01:23 | 2015-01-27 00:00:00 | embulk jruby               |
|    3 |   27559 | 2015-01-28 02:20:02 | 2015-01-28 00:00:00 | Embulk "csv" parser plugin |
|    4 |   11270 | 2015-01-29 11:54:36 | 2015-01-29 00:00:00 | NULL                       |
+------+---------+---------------------+---------------------+----------------------------+
4 rows in set (0.00 sec)
```

入った！

## 今後やること
* Embulkコンテナはあくまで実行環境として、投入データの配置やconfig.ymlの編集はホスト側でできるようにする
* MySQLのデータを永続化する
* ダッシュボードツールの環境もDockerで構築

## 参考文献
* https://qiita.com/pottava/items/452bf80e334bc1fee69a
* http://docs.docker.jp/v1.12/engine/userguide/eng-image/dockerfile_best-practice.html#env
* https://stackoverflow.com/questions/49019652/not-able-to-connect-to-mysql-docker-from-local
* https://knowledge.sakura.ad.jp/16082/

<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEwMTAyMTE5NDAsMTY1MTE4NDQyOCwtMT
k1MjM0MDY5OF19
-->