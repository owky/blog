---
layout: post
title: "ワンタッチでミュートを解除してTeams会議に戻るボタンを作る"
---

用意するもの

* Touch Bar付きのMacbook Pro
* Microsoft Teams

Web会議の最中に別のアプリを開いて作業していて、急に呼びかけられて発言しないといけないということがよくある。
このときに、ミュートを解除する操作がけっこう手間である。そこで「押すだけでいつでもミュートを解除して会議に戻れる」ボタンをTouch Barに常に表示しておく。これでいつでもどこでもワンタッチで会議に戻って発言できる。

Microsoft Teamsの場合、Web会議中に別アプリにフォーカスを移すと、右下にTeamsの小画面が表示されるようになる。
この小画面の中のミュートボタンにマウスカーソルを合わせて押すというのが、咄嗟にやろうとすると結構だるい。
もしくは、Teamsの画面に戻って "Cmd + Shift + M" のショートカットでミュートを解除するか。これもだるい。
この操作に手間取って発言するのが遅れたりすると「聞いてなかったのかな？」と思われそうなのも嫌だ。というのがモチベーション。

### AutomatorでTeamsのミュートを解除するクイックアクションを作成する

Teamsアプリを開いてショートカットキーでミュートを解除する。というのをApple Scriptで実現できる。
操作のフィードバックが欲しいので "Unmute." と喋らせているが、これは無くても良い。
Automatorを使ってクイックアクションとして保存すると、macのシステムから呼び出すことができる。

```
tell application "Microsoft Teams"
	activate
	say "Unmute."
	tell application "System Events"
		keystroke "m" using {command down, shift down}
	end tell
end tell
```

![Automator](https://res.cloudinary.com/owky/9EDA35FD-DEAF-45FE-B4BE-207A5298CAC8_k1sm6a.jpg)

### 作成したクイックアクションをTouch Barに表示する

システム環境設定の「キーボード」設定に「Touch Barに登録する項目」があるので、それを「クイックアクション」に設定する。
そうすると、先に登録していたクイックアクションが常にTouch Barに表示されるようになる。

![システム環境設定 - キーボード](https://res.cloudinary.com/owky/1685D168-537E-42E7-9242-9E238648F0E7_in0qw2.jpg)

![Touch Bar](https://res.cloudinary.com/owky/80C1B587-CB58-46A3-838A-12EAC53B89C4_f5sksc.jpg)

これを押すだけでミュート解除された状態で会議に戻れる！
隣に表示されている「Teams会議を終了」というのも同様に自作したクイックアクション。

### キーボードショートカットからクイックアクションを呼び出すこともできる

システム環境設定の「キーボード」設定の「ショートカット」から「サービス」を選ぶと、一番下に登録したクイックアクションが確認できる。そこでショートカットキーを設定できる。
結果としては、グローバルなショートカットキーでいい感じのものが思いつかなかったので、Touch Barという方式を選んだ。