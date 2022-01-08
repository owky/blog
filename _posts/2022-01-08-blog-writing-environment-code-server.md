---
layout: post
title: iPad上でのブログ執筆環境としてcode-serverを試したが文字入力まわりの不具合がしんどかった。
date: 2022-01-08 00:50 +0000
---
iPadでのブログ執筆環境を模索している。今回は[code-server](https://github.com/coder/code-server)を試した感想。

このブログはサイトジェネレーターとしてjekyllを使っており、GitHubでソースを管理して、GitHub Pagesで公開している。記事を書いて公開するまでは以下のような手順になる。

1. markdown形式で記事を書く
2. `jekyll build`でプレビューしてチェックする
3. GitHubにpushする → 自動で公開される

iPad上でこれらの操作を、楽しく・ストレスなく実行できる環境を模索している。

## code-server

[code-server](https://github.com/coder/code-server)はブラウザから利用できるVisual Studio Codeであり、サーバーアプリケーションとしてオンプレミスで構築できる。Visual Studio Codeはターミナルも備えているため、エディタとして記事が書けるだけでなく、jekyllのビルドができて、GitHubへのpushもできる。とても高機能で使いやすいエディタだ。

自宅のubuntuサーバーにcode-serverを立てて、iPadからアクセスすると、iPadのブラウザ上でVisual Studio Codeを利用することができる。プレビューのチェックもブラウザから行うので、iPad上では一つのアプリの中で執筆から公開まで完結できるのが良い。

ただし、いくつかの不具合に悩まされた。

### 日本語が重複入力されてしまう
日本語入力モードで`a`を入力すると「あ」が変換未確定の状態で表示され、変換候補が出てくる。`Enter`を入力すると変換が確定され「あ」が入力された状態になる。ここで改行しようと再度`Enter`を入力すると、なぜかもう一つ「あ」が入力されて「ああ」になってしまう。これが不具合。主に文末に読点「。」を入力して改行するという場面で発生する。。 (←こうなる)

Windowsからだと発生せず、iPadOSまたはiOSからだと発生する。おそらく、iOS・iPadOSの日本語変換の仕組みと相性が悪いのだろう。

結構な頻度で発生し、その度に文章を修正しないといけないので、地味にストレスが溜まる。

### 別のアプリに移ってから戻ってくるとキーボード入力ができなくなる場合がある

Slackに書いていたメモをコピーしてきたりとか、集中が切れてTwitterを見に行ったりとか、執筆中に別アプリに移動して戻ってくるというのはよくある操作だ。その際に、入力フォーカスは表示されているのに入力を受け付けてくれない症状に陥ることがある。

これはGitHubにIssueが登録されていた。

[iPad pro editor lose focus after swipping back from safari browser · Issue #4182 · coder/code-server](https://github.com/coder/code-server/issues/4182)

Issueは解決されてないが、iPadの使い勝手を改善するためのマイルストーンを計画しているようで、そこにリストアップされている。

[4.1.0 - improve iPad UX Milestone](https://github.com/coder/code-server/milestone/31)
> The goal of this milestone is to improve the UX for iPad users.

この不具合もそれなりの頻度で発生するし、いろいろ操作しないとキーボード入力できる状態に戻らないので、めっちゃストレスが溜まる。

## 感想まとめ

持っている機能は申し分ないのだが、前述の不具合のため執筆時のストレスが高く、使うことは諦めた。code-serverは現在も活発に開発がされており、iPadの使い勝手を改善するための開発も計画されているようなので、今後に期待して継続してウォッチしていきたい。