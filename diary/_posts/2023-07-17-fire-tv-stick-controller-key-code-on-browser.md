---
layout: post
title:  "FireTVリモコンのKeyCode"
---
Fire TV StickのSilkブラウザーで自作のWebアプリを表示させた場合に、リモコンでの操作が面倒だった。
リモコン入力の操作に最適化するために入力イベントを拾ってみようと思って調べてみた。

なお、ブラウザの操作モードが「空間ナビゲーション」になってないと方向キー系は取得できないので注意。

| ボタン | key | keyCode |
|---|---|---|
| 方向キー 上 | ArrowUp | 38 |
| 方向キー 下 | ArrowDown | 40 |
| 方向キー 左 | ArrowLeft | 37 |
| 方向キー 右 | ArrowRight | 39 |
| 選択 | Enter | 13 |
| 再生/一時停止 | MediaPlayPause | 179 |
| 巻き戻し | MediaRewind | 227 |
| 早送り | MediaFastForward | 228 |


公式情報にある通り！  
[ウェブアプリのコントローラー対応 Amazon Fire TV](https://developer.amazon.com/ja/docs/fire-tv/supporting-controllers-in-web-apps.html)