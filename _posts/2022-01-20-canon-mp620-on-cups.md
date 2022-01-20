---
layout: post
title: Canon PIXUS MP620プリンターをiPhone / iPad / Chromebookから使う
date: 2022-01-20 14:07 +0000
---
Chrome OSではGoogle Cloud Printか、プリントサーバーを使っての印刷しかできない。
手元のCanon MP620はGoogle Cloud Printには対応してできないので、プリントサーバーを立てて使えるようにする。
この方法で、iPhoneやiPadからもプリンタを利用できるようになった。

* Chrom OS : 87.0.4280.109 (Official Build)
* Server : Ubuntu 20.04.1 LTS
* Printer : Canon PIXUS MP620

## CUPSでプリントサーバーを立てる

ubuntuでの作業。

Canonプリンター向けのCUPSバックエンドをインストール。

```
$ sudo apt-get install cups-backend-bjnp
```

[こちら](https://qiita.com/taiyodayo/items/02ae998119d4d57bd46d)を参考に、CUPSの設定を変更し、ポート631を開けた。

CUPSのWebコンソールにアクセスする。

`http://サーバーのIP:631`

Webコンソールからプリンタを追加することができる。

1. <b>"管理"</b>タブ
1. <b>"プリンターの追加"</b>
1. <b>"その他のネットワークプリンター"</b>から「Canon network printer」を選択し<b>"続ける"</b>
1. <b>"接続"</b>欄に `bjnp://プリンタのIP:8611` と入力し<b>"続ける"</b>
1. <b>"名前"</b>は `MP620` とする。ここは任意。
1. <b>"このプリンターを共有する"</b>をチェックして<b>"続ける"</b>
1. <b>"メーカー"</b>は「Canon」を選んで<b>"続ける"</b>
1. <b>"モデル"</b>は「Canon PIXUS MP620 - CUPS+Gutenprint v5.3.3 (カラー)」を選んで<b>"プリンターの追加"</b>

これでubuntuサーバーからの印刷ができるようになる。
CUPSのWebコンソールからテスト印刷ができる。

#### ※プリンタの登録時に、プリンタが自動検出される場合もある
手元の環境では、ファイアウォール (ufw) をOFFにしたら自動検出された。
自動検出されたものを選ぶと、いろいろ入力の手間が省ける

## Chromebookからプリントサーバーを利用する

Chromebookの設定画面から<b>"プリンタの追加"</b>を行う。

* 名前
  * 任意
* アドレス
  * プリントサーバーのIP:631
* プロトコル
  * インターネット印刷プロトコル（IPP）
* キュー
  * printers/MP620

これでChromebookからプリンタが利用できるようになる。

#### ※プリントサーバーの認証に失敗する場合がある

CUPSからのプリンタ登録時に「このプリンターを共有する」をOFFにしていると、以下のエラーが出る。

`Returning IPP client-error-not-authorized for Create-Job (ipp://192.168.xx.xx:631/printers/MP620) from 192.168.xx.xx.`

## iPhoneやiPadでも利用可能

プリンタを選択する際にMP620を見つけることができる。

## 参考文献

* [Ubuntu18で爆速でプリントサーバ立てて iPhone とか Chromebook でも印刷する](https://qiita.com/taiyodayo/items/02ae998119d4d57bd46d)
* [Linuxで Canon MP620 への無線接続設定](https://www.nemuifukari.com/2018/11/fedora-canon-mp620.html)
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE5OTc1NjEzMjQsLTE3NDk3MjY1MjNdfQ
==
-->