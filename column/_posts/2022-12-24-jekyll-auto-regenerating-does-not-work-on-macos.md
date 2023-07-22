---
layout: post
title:  "jekyll serveのAuto-regenerationが動作しないので、--force_pollingオプションで回避する"
---
`jekyll serve`でブログをプレビューする際に、ファイル編集後に自動で再生成がされない。
以前はちゃんと動いていた気がするが、いつからか動かなくなっている。

このように `Auto-regeneration: enabled` と表示されているが、実際は auto regenerate されない。

```shell
# jekyll serve
Configuration file: /work/_config.yml
            Source: /work
       Destination: /work/_site
 Incremental build: disabled. Enable with --incremental
      Generating...
                    done in 0.96 seconds.
 Auto-regeneration: enabled for '/work'
    Server address: http://127.0.0.1:4000/
  Server running... press ctrl-c to stop.
```

調べてみると `--force_polling` オプションを付けると動作するとのこと。
発生条件に「macの場合」とあるが、その真偽はわからない。

[Auto-regeneration doesn't work even when enabled - Help - Jekyll Talk](https://talk.jekyllrb.com/t/auto-regeneration-doesnt-work-even-when-enabled/4178)

たしかに `--force_polling` オプションを付けたら再生成された。
ポーリングだからなのか、10秒くらい待たされる。微妙・・・。
Auto-regenerationが正常に動いていたときは、待たされなかった気がする。

```
# jekyll serve --force_polling
Configuration file: /work/_config.yml
            Source: /work
       Destination: /work/_site
 Incremental build: disabled. Enable with --incremental
      Generating...
                    done in 1.034 seconds.
 Auto-regeneration: enabled for '/work'
    Server address: http://127.0.0.1:4000/
  Server running... press ctrl-c to stop.
      Regenerating: 1 file(s) changed at 2022-12-24 10:24:47
                    _posts/2022-12-24-jekyll-auto-regenerating-does-not-work-on-macos.md
                    ...done in 0.732444 seconds.
```
