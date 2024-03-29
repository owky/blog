---
layout: post
title:  "要件定義を専任化して開発チームから剥がしてみる"
---
どんな機能を搭載するかという製品戦略は企画部門の責任となっている。いざ機能開発が始まるときには「こういう機能でヨロシク」というパワポ一枚が渡されて、そこから先は開発の責任範囲となっている。もちろん機能の目的やユースケースなどのヒアリングには企画も応対してくれるが、要求を整理して、実現仕様を検討して、開発のゴールとスコープを定めて要件定義するというところは開発チームが主体的に推進する必要がある。ここに課題を感じている。

我々のプロダクトは機能実現に対してのコストが高く、スピードも遅く、開発力の改善が求められている。その原因の一つとして「開発チームが要件定義を担うことで作業効率が下がりスピードが落ちてしまう」という仮説をもっている。企画から情報を集めて、各方面のステークホルダーとの合意形成をして、妥当な開発範囲を決める、といった作業が要件定義の際には必要になる。これをエンジニアが行う際には開発とは異なるスキルが要求されるため、作業の能率は落ちるし、ストレスも感じてしまう。また作業分担が難しく、大抵は開発チームのリーダーがその役割を負うことになり、要件定義フェーズを終えるころにはリーダーが疲弊していることがよくある。

そこで、要件定義の作業を専門に担う「要件定義チーム」の立ち上げを考えたい。要件定義と開発を分業することで全体の効率化とリードタイムの改善を図る。そのときのメリット・デメリットを考えてみる。

- メリット
    - 専門化が進んで要件定義も開発も作業の効率と品質が上がる
    - より製品戦略を意識した要件定義が行われるようになる。必要十分な機能を実現でき、過剰性能や過剰品質を避けられる。
    - 要件定義だけ先行着手できるので、これまでクリティカルパスだった工程をカットできる。
    - 責任とタスクを分散できるので、身体的にもメンタル的にも疲弊しない。
- デメリット
    - 要件定義の完了を開発が待つようだとボトルネックになってしまう。
    - 要件定義スキルを得たいエンジニアにとっては成長機会が失われる

思ったよりもデメリットが無かった。要件定義フェーズがボトルネックにならないように、体制規模やプロセスを丁寧に設計する必要がある。デメリットに挙げたものは回避可能だ。興味がある人こそ要件定義チームに引き込みたい。

これは実行に移すべき施策だと整理できた。