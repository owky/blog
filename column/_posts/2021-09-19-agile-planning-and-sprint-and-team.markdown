---
layout: post
title: "開発計画とその進捗管理、そして開発チームに求めること"
---

開発計画の管理を開発チームに権限委譲するにあたって、いろいろと考えを整理した。
これは私のチームの、我々のプロダクトのやり方であるので一般的なベストプラクティスとは限らない。

* 開発計画とその進捗管理とは何なのか
* 段階的に詳細化しアジャイルに管理すること
* 開発チームのスプリントへの向き合い方として求めること

## 開発計画とその進捗管理

開発チームは、プロダクトが生み出す価値をユーザーが実際に享受できる形で実現することを責務として負う。

**開発計画**とは、その価値がいつデリバリーされるかというコミットメントである。
プロダクトのビジネス戦略と開発計画は密接な関係を持ち、開発計画を前提にビジネスは進むし、ビジネス戦略が変われば開発計画も変更する。
ビジネス戦略と開発計画のどちらとも、柔軟性を持つ必要があるし、その進捗は繰り返し評価されるべきだ。

**開発計画の進捗確認**とは、計画の達成に向けて開発が順調に進んでいるのかを客観的に評価することである。
あとどれくらいでゴールに着くか？なので、「時間 ＝ 道のり ÷ 速さ」と同じように考えられる。

時間 → あとどれくらいで予定した開発が終わるか  
道のり → 予定した開発が完了するまでの全タスク量  
速さ → 1スプリントあたりのベロシティ

道のりと速さで進捗の評価は決まるので、道のりと速さの妥当性は繰り返し確かめる。

* 予定しているタスクは本当に全部なのか？
* 見直した方がよい見積りはないか？
* ベロシティは安定しているか？

## 段階的に詳細化しアジャイルに管理する

開発計画は、その解像度が段階的に高くなるように、4つのスコープに分けて管理する。

* 年間計画 (1年のスコープ)
* バージョン (2〜4ヶ月のスコープ)
* 機能 (2週間〜2ヶ月のスコープ)
* スプリント (1〜2週間のスコープ)

スプリントの計画は最も解像度が高く信頼できるものである。
そしてその実績は、より解像度の低いスコープの計画(機能・バージョン・年間)を見直すための材料となる。

2週間のスプリントで予定した作業が予定通りに終わらなかった場合、現在の計画は理想的な進捗を期待し過ぎているかもしれない。また、新しく使う技術の調査を行ったところ懸念点が解消されたという場合、大きめにしていた見積もりを見直すことで、より早く機能を届けられる計画となる。

実績から得た学びを計画にフィードバックしていく。

## 開発チームのスプリントへの向き合い方

スプリントにおける作業は、開発チームにとって扱いやすいサイズに細分化されている。
そのため、開発チームにはスプリントの計画とその達成についてコミットメントを求める。
具体的には

* ベロシティを安定させること
* 見積もりに自信が無いものから進めること

を考えながら開発に取り組んでほしい。

ベロシティが安定しているというのは、チームが一定の走さで走り続けることができるということなので「時間 ＝ 道のり ÷ 速さ」で求めた計画の精度が高くなる。
より速く走る(ベロシティを上げる)にはどうするか？と考えたくなるかもしれないが、そうではなく、一定のペースで走ることを阻害する要因を排除することを考えてほしい。
そうすると、今よりも速いペースで走れるようになる。

見積もりに自信が無い作業には不確実性が隠れている。あまり触ったことがないモジュールを修正するので思ったより時間がかかるかもしれないとか、この機能はテストをするのに特別なツールが必要だがその使い方に手間取るかもしれないとか。こういうものは計画の達成におけるリスクになるので、早く対処できるほど計画の達成確率は上がる。後回しにしたりすると取り返しのつかない状況に追い込まれたりする(休日出勤してのリカバリとか)。このような不確実性を効率よく解消する方法は、さっさとその作業に取り掛かることである。