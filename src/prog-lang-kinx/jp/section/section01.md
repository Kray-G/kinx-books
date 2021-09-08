
# はじめに

## Kinx とは

世の人気を二分するメジャーなスクリプト言語として Ruby と Python があります。
それぞれ多くのユーザーを抱え、現実に存在する世の中の問題を解決するために非常に多くのシーンで使われています。
ですが、どちらも C ライクではありません。
なぜでしょうか。

また、最近ではより安全と言われる静的型付け言語が人気です。
しかし動的型付け言語は、スキルさえ問題なければ[^highskill]より高い生産性を発揮できる非常に使い勝手の良い道具であるはずです。
C 系統のシンタックスという意味では JavaScript または TypeScript で node.js、という選択肢もありますが、
node.js は全く Lightweight ではありません。
また、イベントループによる制御自体がスクリプト言語として使いづらいといった側面もありました。

[^highskill]: 特に大規模開発において、この「スキルさえ問題なければ」の部分に疑問符が付けられているのが現状です。それが、静的型付け言語人気の理由です。

そこで Ruby、Python と同様の目的を持つ、
動的型付けの特徴と C 系統のシンタックスを備えた、
使いやすいスクリプト言語が欲しいという願望から本プロジェクトはスタートしました。

つまり、Kinx を一言で言えば、**「手に馴染んでいる伝統的な C 言語系統のシンタックスを受け継いだ、汎用スクリプト言語」**となります。

ただし、Kinx には簡単な型アノテーションの機能をサポートしています。
判断可能な場合に限られますが、型を指定することによって明らかに期待と異なる型を使用しているといったケースでの指摘・警告を行うことができます。
詳細は「\\nameref{型アノテーション}」をご参照ください。

## Kinx の特徴

### コンセプト

Kinx のコンセプトは、
**Looks like JavaScript, feels like Ruby, and it is a script language fitting in C programmers.**
です。

見た目は JavaScript のようであり、使った感触はまるで Ruby のように柔軟な、
それでいて C プログラマー（C 系統のシンタックスに慣れ親しんだ多くのプログラマー）に最も馴染むスクリプト言語を目標としています。
あなたが C プログラマーであれば、Ruby、Python よりもずっと快適で、手に馴染むような感覚を得ることができるでしょう。

### 主な特徴

Kinx は **動的型付け言語** であり、**オブジェクト指向プログラミング言語** です。
その主な特徴は以下の通りです。

* 動的型付け言語、ただし型アノテーションも可能
* オブジェクト指向プログラミング言語
* C 系統（ほぼ JavaScript）のシンタックス
* クラスと継承、モジュールとミックスイン、ファイバーのサポート
* 高次関数・レキシカル・スコープ・クロージャのサポート
* ガーベジ・コレクションによるメモリ管理
* JIT コンパイルされる `native` 関数。

### 本書について

本書は「プログラミング言語 Kinx」をまとめた初めての本です。
現在サポートされている機能は一通り網羅する予定ですが、
今後変更される可能性も勿論あります。
あらかじめ、ご了承ください。
なお、本書の付録として各種リソース情報を掲載していますので、
最新情報などにつきましては、ぜひリンク先をご覧ください。