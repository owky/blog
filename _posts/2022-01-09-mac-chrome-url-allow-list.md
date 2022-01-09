---
layout: post
title: macでChromeから外部アプリを開く際の確認ダイアログを出さないように設定する
date: 2022-01-09 12:14 +0000
---
ブラウザからアプリを呼び出すときに、確認ダイアログが毎回出るのがうるさいのでOFFにしたい。

> Notionを開きますか？
> ウェブサイトがこのアプリケーションを開く許可を求めています。

![確認ダイアログ](https://res.cloudinary.com/owky/image/upload/w_500/v1641729463/34DC5F20-AED5-4DAB-AD0E-C24D677B66C1_sqwubm.jpg)

こういうやつを二度と表示しないようにしたい。

## Chromeのポリシー設定で制御できる

[Chrome Enterprise のポリシーリストと管理 URLAllowlist](https://chromeenterprise.google/policies/#URLAllowlist)

> また、このポリシーでは、リストで指定したプロトコル（「tel:」、「ssh:」など）のプロトコル ハンドラとして登録されている外部アプリケーションをブラウザから自動で呼び出すことも許可できます。

URLAllowlistというポリシーで設定を入れてやればよい。

## macではdefaultsコマンドで設定する

ターミナルから以下のように設定する。
Notionを設定する例。
```
$ defaults write com.google.Chrome URLAllowlist -array "notion://*"
```
Chromeで `chrome://policy/` を開くと反映されているポリシーを確認できる。

![ポリシーの確認](https://res.cloudinary.com/owky/image/upload/w_700/v1641729464/7051CF3B-F580-4B7D-BB91-0F40167B95F8_er7u6z.jpg)
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTc0MDQ5Njc5NSwxOTQ3MzEwNzU4LDEwMD
YyMDkyMjNdfQ==
-->