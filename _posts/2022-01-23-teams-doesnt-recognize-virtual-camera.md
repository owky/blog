---
layout: post
title: Microsoft TeamsでIriun WebcamやEpocCamなどのバーチャルカメラが認識されない場合の解決方法
date: 2022-01-23 13:02 +0000
---
iPhoneなどスマートフォンのカメラをWebカメラとして使うためのアプリ [Iriun Webcam](https://iriun.com/) や [EpocCam](https://www.elgato.com/ja/epoccam) がMicrosoft Teamsで認識されない場合の解決方法。

いろいろ調べたけどなかなか有効な解決策に辿り着けず。しかし、Teamsのバージョン番号を含めて検索したら解決した。以下のページを参考にすれば良い。

* [-   Virtual Cam broken for Teams Version 1.3.00.28778 Mac. codesign --remove-signature does not work ... - Microsoft Q&A](https://docs.microsoft.com/en-us/answers/questions/148337/virtual-cam-broken-for-teams-version-130028778-mac.html)
* [msteams_tfmac/microsoft-teams-mac-os-client-is-not-recognizing/d9e863be-d9a4-4d03-a4b8-1b5c7df58828](https://answers.microsoft.com/en-us/msteams/forum/msteams_tfb-msteams_tfmac/microsoft-teams-mac-os-client-is-not-recognizing/d9e863be-d9a4-4d03-a4b8-1b5c7df58828)

情報を検索するときにIriun WebcamやEpocCamを指す総称が難しかった。英語だと "Virtual Camera" になるようで、日本語だと「仮想カメラ」「バーチャルカメラ」というキーワードでいろいろ出てきた。今回の場合は "External Camera" でも同じ情報に辿り着けそうだ。

## 解決手順

※ Microsoft Teams v1.3.00.28778

Teamsを終了する。

Terminalを開く。

Xcodeをインストールする。

```
$ xcode-select --install
xcode-select: error: command line tools are already installed, use "Software Update" to install updates
```
既に入っていた。

以下を実行する。

```
$ sudo codesign --remove-signature "/Applications/Microsoft Teams.app"
$ sudo codesign --remove-signature "/Applications/Microsoft Teams.app/Contents/Frameworks/Microsoft Teams Helper.app"
$ sudo codesign --remove-signature "/Applications/Microsoft Teams.app/Contents/Frameworks/Microsoft Teams Helper (GPU).app"
$ sudo codesign --remove-signature "/Applications/Microsoft Teams.app/Contents/Frameworks/Microsoft Teams Helper (Plugin).app"
$ sudo codesign --remove-signature "/Applications/Microsoft Teams.app/Contents/Frameworks/Microsoft Teams Helper (Renderer).app"
```

Teamsを起動する。

キーチェーンの情報にアクセスするための許可を求められるので、パスワードを入れて「常に許可」する。
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTA5MTQ2MDE1OSwtNTQ3NTQ3NzNdfQ==
-->