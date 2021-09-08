
# データ型

## 数値
### 整数

Kinx は整数を内部的に 2 種類の形で扱っています。
1つは 64 bit 整数であり、1つは多倍長整数です。
基本的に内部構造として 64 bit 整数、多倍長整数の区別はありますが、
これらは自動的に相互変換されて扱われるためユーザー（プログラマー）が特に意識する必要はありません。

#### 64 bit 整数

Kinx では基本的に整数は 64 bit 整数です。
整数リテラルを書く際は、8進数、10 進数、16 進数で記述できます。
表現形式は C 言語と同様で「\\nameref{Table:KinxInteger}」のルールに従います。

<context label="Table:KinxInteger"/>
<context caption="整数表記ルール"/>

|  整数  |        表記ルール         |
| :----: | ------------------------- |
| 8進数  | `0` で始まる数値。        |
| 10進数 | `1` ～ `9` で始まる数値。 |
| 16進数 | `0x` で始まる数値。       |

値が整数の場合、`.isInteger` が true になります。

```javascript
var a = 0x10;
System.println([10, a, 010]);
System.println(a.isInteger ? "true" : "false");
```

```console
[10, 16, 8]
true
```

#### 多倍長整数

値が 64 bit の範囲を超えると、自動的に多倍長整数で扱うようになります。
多倍長整数は基本的にどんな数でも扱え、非常に大きい値を扱うことができます。
ただし、多倍長整数をリテラルで記述する際は 10 進数のみが利用可能です。

```javascript
var n = 9223372036854775808;    // 多倍長整数
System.println("%d.isBigInteger = %s" % n % (n.isBigInteger ? "true" : "false"));
System.println("%d x 2 = %d" % n % (n * 2));
```

```console
9223372036854775808.isBigInteger = true
9223372036854775808 x 2 = 18446744073709551616
```

値が多倍長整数の場合、`.isBigInteger` が true になります。
この時 `.isInteger` も true となりますので、
多倍長整数では `.isInteger` と `.isBigInteger` の両方が true となります。

#### 64 bit 整数と多倍長整数の自動変換

64 bit 整数として扱われている整数の値の範囲が 64 bit の範囲を超えると、自動的に多倍長整数に拡張されます。
逆に、値が 64 bit の範囲に戻ってきた際には自動的に 64 bit 整数として扱われます。
この変換は自動的に行われるため、プログラマーが意識する必要はありません。

多倍長整数と 64 bit 整数の境目を以下のプログラムで確認してみましょう。
まず、64 bit 整数の値の範囲は -9223372036854775808 から 9223372036854775807 までとなります。
そこで、9223372036854775806 あたりからプラスの方向に増やし、その後、順に元に戻してみます。

```javascript
function disp(n) {
    System.println("%d = %10s %13s"
        % n
        % (n.isInteger ? ".isInteger" : "")
        % (n.isBigInteger ? ".isBigInteger" : "")
    );
}
var n = 9223372036854775806;
for (var i = 0; i < 4; ++i, ++n) {
    disp(n);
}
for (var i = 0; i < 4; ++i, --n) {
    disp(n);
}
```

```console
9223372036854775806 = .isInteger
9223372036854775807 = .isInteger
9223372036854775808 = .isInteger .isBigInteger
9223372036854775809 = .isInteger .isBigInteger
9223372036854775810 = .isInteger .isBigInteger
9223372036854775809 = .isInteger .isBigInteger
9223372036854775808 = .isInteger .isBigInteger
9223372036854775807 = .isInteger
```

64 bit 整数と多倍長整数の相互変換が自動的にされているのが分かります。

#### 多倍長整数の例

最後に多倍長整数の例として、階乗の計算をしてみましょう。

```javascript
function fact(n) {
    if (n < 1) return 1;
    return n * fact(n-1);
}
System.println(fact(500));
```

```console
12201368259911100687012387854230469262535743428031928421924135883858453731538819
97605496447502203281863013616477148203584163378722078177200480785205159329285477
90757193933060377296085908627042917454788242491272634430567017327076946106280231
04526442188787894657547771498634943677810376442740338273653974713864778784954384
89595537537990423241061271326984327745715546309977202781014561081188373709531016
35632443298702956389662891165897476957208792692887128178007026517450776841071962
43903943225364226052349458501299185715012487069615681416253590566934238130088562
49246891564126775654481886506593847951775360894005745238940335798476363944905313
06232374906644504882466507594673586207463792518420045936969298102226397195259719
09452178233317569345815085523328207628200234026269078983424517120062077146409794
56116127629145951237229913340169552363850942885592018727433795173014586357570828
35578015873543276888868012039988238470215146760544540766353598417443048012893831
38968816394874696588175045069263653381750554781286400000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000
```

多倍長整数の演算であっても、
この程度の演算であれば体感的に一瞬で完了します[^bigintspeed]。

[^bigintspeed]: 5000! の計算でも一瞬でしたが、結果が長すぎて紙面に入りきらなかったので 500! のサンプルにしました。

### 実数

実数は C 言語でいう double を示します。
実数リテラルの書き方としては通常の実数表記のみサポートしており、指数表記には現在対応していません[^dblexp]。

値が実数の場合は、`.isDouble` が true になります。
また、整数同士の演算であっても、演算結果が実数となる場合は自動的に実数に変換されます。

[^dblexp]: このくらい対応したほうが良いか。。。

```javascript
var d = 0.5;    // 実数リテラル
function eval(f) {
    r = f(3, 2);
    System.println("r = %3s, r.isDouble = %s" % r % (r.isDouble ? "true" : "false"));
}
eval({ => _1 + _2 });
eval({ => _1 - _2 });
eval({ => _1 * _2 });
eval({ => _1 / _2 });
```

```console
r =   5, r.isDouble = false
r =   1, r.isDouble = false
r =   6, r.isDouble = false
r = 1.5, r.isDouble = true
```

## 文字列

文字列が扱いやすくなっているのもスクリプト言語の特徴の一つです。
C 言語ではメモリリークやバッファー・オーバーランといったバグを埋め込みやすく、
文字列は、良く利用する割に非常に使いづらいものです。
そこで、Perl 時代より文字列の扱いが容易だということが、
スクリプト言語が人気となった大きな理由でもありました。

Kinx でも同様に文字列を容易に扱えます。

### 文字列リテラル

文字列のリテラルは、ダブルクォート、またはシングルクォートで囲みます。
意味は同じですが、ダブルクォート内ではダブルクォートを、シングルクォート内ではシングルクォートをエスケープする必要があります。

```javascript
var a = "\"aaa\", 'bbb'";
var b = '"aaa", \'bbb\'';
System.println(a == b ? "same" : "different");
```

```console
same
```

### 文字列の演算

文字列の四則演算は、文字列に合わせた動作をします。
まず、加算と乗算は以下のように動作します。
加算は単純な文字列の連結、乗算は文字列の繰り返し（の連結）です。

```javascript
var a = "123456789,";
System.println(a + a + a);
System.println(a * 4);
```

```console
123456789,123456789,123456789,
123456789,123456789,123456789,123456789,
```

文字列に除算を適用すると、文字列を「`/`」で区切ったパスとして連結します。
この時、重複する「`/`」は一つにまとめられます。

```javascript
var a = "path/to";
System.println(a / "file.txt");
System.println(a / "/file.txt");
```

```console
path/to/file.txt
path/to/file.txt
```

また、剰余演算を適用した場合、フォーマッタ・オブジェクトを返します。

```javascript
System.println("0x%02x" % 10);
```

```console
0x0a
```

フォーマッタ・オブジェクトは、C 言語の `printf` のようなフォーマットを行うためのオブジェクトです。
詳しくは「\\nameref{フォーマッティング}」を参照ください。

### 添え字アクセス

文字列を添え字でアクセスをした場合、
その位置にある文字コードを整数値で返します。
したがって、「5 文字目が `'a'` である」という判断をする場合は以下のように書きます。

```javascript
if (str[5] == 'a'[0]) {
    /* ... */
}
```

右辺でも添え字アクセスをしていることに注意してください。
文字 `'a'` は実際には文字ではなく **文字列リテラル** のため、最初の文字を示す `[0]` が必要となります。

また、`str[-1]` と負の数を指定することによって文字列の末尾からアクセスすることもできます。
この場合の `str[-1]` は最後の文字の文字コードを返します。

### `=~` 演算子

文字列に対して `=~` を適用した場合、右辺値の正規表現[^regex]にマッチするかどうかを確認します。
右辺値が正規表現のオブジェクトではなかった場合、例外が送出されます。
復帰値はマッチしたグループの集合となり、
マッチしなかった場合は `False` オブジェクトが返ります。

[^regex]: 正規表現に関しては「\\nameref{正規表現}」を参照ください。

```javascript
if (g = ("abc" =~ /(.)(bc)/)) {
    g.each { => System.println(_1) };
}
```

```console
{"begin":0,"end":3,"string":"abc"}
{"begin":0,"end":1,"string":"a"}
{"begin":1,"end":3,"string":"bc"}
```

なお、左辺値が正規表現オブジェクトで右辺値が文字列の場合でも同様の動作を行います。

### `!~` 演算子

文字列に対して `!~` を適用した場合は、右辺値の正規表現にマッチ**しないこと**を確認します。
右辺値が正規表現のオブジェクトではなかった場合、例外が送出されます。
復帰値は true または false になります。
true の場合が、マッチしなかった場合です。

```javascript
if ("axc" !~ /(.)(bc)/) {
    System.println("not matched");
}
```

```console
not matched
```

こちらのケースでも同様に、左辺値と右辺値が逆でも同様の動作を行います。

### 単項 `*` 演算子

単項 `*` 演算子を文字列に適用した場合、文字列を配列に変換します。
また、逆に配列に単項 `*` 演算子を適用すると、文字列に戻ってきます。

```javascript
var a = *"abc";
var b = *a;
System.println(a);
System.println(b);
```

```console
[97, 98, 99]
abc
```

このように、いくつかの型同士での相互変換が可能です。
詳しくは「\\nameref{データ型の相互変換}」をご参照ください。

### 内部式

文字列の内部で `%{...}` 形式を使うと、文字列内部に直接式を記述することができます。

```javascript
for (var i = 0; i < 5; ++i) {
    System.println("i = %{i}, i * 2 = %{i * 2}");
}
```

```console
i = 0, i * 2 = 0
i = 1, i * 2 = 2
i = 2, i * 2 = 4
i = 3, i * 2 = 6
i = 4, i * 2 = 8
```

### Raw 文字列

内部式ではなく、`%{...}` という形式で文字列を記載すると Raw 文字列を作成できます[^rawstr]。
`%-{...}` を使うと、先頭と末尾の改行文字をトリミングします。
また、`%<...>`、`%(...)`、`%[...]` を使うこともできます。
次のように記載できます。

[^rawstr]: ヒアドキュメントのように扱えるため、Kinx ではヒアドキュメントをサポートしていません。

```javascript
var a = 100, b = 10;
var str1 = %{
This is a string without escaping control characters.
New line is available in this area.
{ and } can be nested here.
};
var str2 = %-{
This is a string without escaping control characters.
New line is available in this area.
But newlines at the beginning and the end are removed when starting with '%-'.
Variable a is %{a} and b is %{b}.
};
System.println("---");
System.println(str1);
System.println(str2);
System.println("---");
```

```console
---

This is a string without escaping control characters.
New line is available in this area.
{ and } can be nested here.

This is a string without escaping control characters.
New line is available in this area.
But newlines at the beginning and the end are removed when starting with '%-'.
Variable a is 100 and b is 10.
---
```

この表記方法を使うと、複数行にまたがる文字列を直接扱うことができます。
ただし、ネストした形にならない「`{`」や「`}`」に対しては「`\`」でエスケープする必要があります。
また、「`%{expr}`」を内部式として使わない場合、「`%\{expr\}`」とエスケープする必要があります。

閉じカッコは対応する開きカッコに対応するものを使用しますが、
以下の文字を使うことも可能です。
その場合は、開始文字と終了文字は同じ文字となります。
例えば、`%|...|` のような形で使用します。

* ''`|`''、''`!`''、''`^`''、''`~`''、''`_`''、''`.`''、''`,`''、''`+`''、''`*`''、''`@`''、''`&`''、''`$`''、''`:`''、''`;`''、''`?`''、''`'`''、'`"`'

### フォーマッティング

文字列に対する `%` 演算子は、フォーマッタ・オブジェクトを作成します。

```javascript
var fmt = "This is %1%, I can do %2%.";
System.println(fmt % "Tom" % "cooking");
```

```console
This is Tom, I can do cooking.
```

`%1%` の `1` はプレースホルダ番号を示し、`%` 演算子で適用した順に合わせて整形します。
適用場所が順序通りであれば、`%s` といった C の printf と同様の指定の仕方も可能です。

```javascript
var fmt = "This is %s, and %d years old, I like %s.";
System.println(fmt % "Tom" % 22 % "cooking");
```

```console
This is Tom, and 22 years old, I like cooking.
```

また、さらに C の printf と同じ指定子を使いながら同時にプレースホルダも指定したい場合、
`$` の前に位置指定子を書き、`$` で区切って記述する事もできます。

例えば、16進数で表示したい場合は以下のようにします。

```javascript
var fmt = "This is %2%, I am 0x%1$02x years old in hex.";
System.println(fmt % 27 % "John");
```

```console
This is John, I am 0x1b years old in hex.
```

フォーマッタ・オブジェクトに後から値を適用していく場合は、`%=` 演算子を使って適用していきます。

```javascript
var fmt = "This is %1%, I can do %2%.";
fmt %= "Tom";
fmt %= "cooking";
System.println(fmt);
```

```console
This is Tom, I can do cooking.
```

実際のフォーマット処理は、以下のタイミングで行われます。

* `System.println` 等で表示するとき。
* 文字列との加算が行われるとき。

明示的にフォーマッタ・オブジェクトからフォーマット文字列を作成するには、`format()` メソッドを使います。

```javascript
var fmt = "This is %1%, I can do %2%.";
fmt %= "Tom";
fmt %= "cooking";
setString(fmt.format());
```

### 文字色・文字装飾

コンソール端末に文字列を表示する際、
エスケープシーケンスに則った形で色や装飾を付けることが可能です。

Kinx ではこれを実現するために、文字列に対して直接メソッドが定義されています[^specialstr]。
指定できるのは、前景色、背景色、および文字装飾です。

[^specialstr]: これも「特殊オブジェクト」によって実現されています。特殊オブジェクトに関する詳細は、「\\nameref{特殊オブジェクト}」をご参照ください。

#### 前景色・背景色

以下のような形で指定すると、前景色を赤色に、背景色を黄色に設定します。

```javascript
System.println("The text".red(.white));
```

![](ximg/redwhite.png)

背景色は、前景色を指定するメソッドの引数として指定します。
`.white` といった形で、`.` で始まることに注意してください。
文字色として指定できるものを「\\nameref{Table:KinxStringColors}」に示します。

<context label="Table:KinxStringColors"/>
<context caption="文字色"/>

|    色    |    前景色    |   背景色   |
| :------: | ------------ | ---------- |
|    黒    | `.black()`   | `.black`   |
|    赤    | `.red()`     | `.red`     |
|    緑    | `.green()`   | `.green`   |
|   黄色   | `.yellow()`  | `.yellow`  |
|    青    | `.blue()`    | `.blue`    |
| マゼンタ | `.magenta()` | `.magenta` |
|  シアン  | `.cyan()`    | `.cyan`    |
|    白    | `.white()`   | `.white`   |

#### 文字装飾

文字装飾も文字色と同様に指定します。

```javascript
System.println("The text".red(.white).bold().underline());
```

![](ximg/redboldwhite.png)

このように、文字色と文字装飾は同時に指定できます。

文字装飾として指定できるのは、「\\nameref{Table:KinxStringAttrs}」に示す 5 種類です。
ただし、端末やフォントによって表現されないケースがあることにご注意ください[^strcolor]。

[^strcolor]: Windows では `italic` と `blink` は機能しないようです。

<context label="Table:KinxStringAttrs"/>
<context caption="文字装飾"/>

|    装飾    |    メソッド    |            意味             |
| :--------: | -------------- | --------------------------- |
|  ボールド  | `.bold()`      | **太字**にする。            |
|    下線    | `.underline()` | \\underline{下線}を付ける。 |
| イタリック | `.italic()`    | 斜体にする。                |
|  リバース  | `.reverse()`   | 色を反転させる。            |
|  ブリンク  | `.blink()`     | 点滅させる。                |

## 配列

配列は、複数のデータを格納するための入れ物であり、リストです。
配列を使うことで、複数のデータを一括して扱うことができるようになります。
配列の要素として配列を格納することも可能です。
これによって多次元配列を扱うこともできます。

### 配列リテラル

配列のリテラルは、`[...]` の形で記述し、任意のデータを混在させて格納することができます。
また、最後の要素の後にカンマ（`,`）を書くこともできます。
これは C 言語同様に要素を縦に並べた際に書きやすくするためのものです。
最後の要素の後にカンマが置けると、
ソースコード上での並べ替えや要素の追加が容易になります。

```javascript
var a = [1, 2, 3, 4, 5];
var b = [
    "item1",
    "item2",
    "item3",
    "item4",
];
```

### 添え字アクセス

配列は添え字でアクセスできます。

```javascript
var a = [1, 2, 3];
var b = [a, 1, 2];
System.println(b[0][1]);
System.println(a[-1]);
```

```console
2
3
```

この例のように、配列の要素として配列を格納した場合、
最初の添え字で中身となる配列要素を取り出し、
次の添え字でその配列の要素を取り出すことができます。
つまり、単純に添え字を重ねることで配列内配列の要素に簡単にアクセスすることができます。

また、添え字に負の数を与えると末尾からアクセスするように動作します。
つまり、`a[-1]` は配列 `a` の最後の要素にアクセスします。

### 配列の代入

スプレッド演算子で配列をコピーできます。
ただし、このコピーは ''浅いコピー'' となります。
この例では `val[2][1]` を書き換えることで `ary[0][1]` も書き換わっていることが分かります。

```javascript
var ary = [[1, 2], 1, 2, 3, 4];
var val = [10, 20, ...ary, 30, 40];
val[2][1] = 200;
System.println(ary);
System.println(val);
```

```console
[[1, 200], 1, 2, 3, 4]
[10, 20, [1, 200], 1, 2, 3, 4, 30, 40]
```

配列構造は左辺値で使用すると右辺値の配列を個々の変数に取り込むことが可能です。
これを使用して値をスワップすることも可能です。

```javascript
[a, b] = [b, a];    // Swap
```

スプレッド・レスト演算子を使った分割代入も可能です。

```javascript
var [a, ...b] = [1, 2, 3, 4, 5];
System.println("a = ", a);
System.println("b = ", b);
```

```console
a = 1
b = [2, 3, 4, 5]
```

分割代入の詳細は「\\nameref{分割代入とパターンマッチ}」を参照してください。

## バイナリ

バイナリはバイト配列です。
全ての要素は 0x00 ～ 0xFF の範囲にアジャストされ、配列のようにアクセス可能です。

### バイナリ・リテラル

バイナリ・リテラルは `<...>` の形式で記述します。

```javascript
var bin = <0x01, 0x02, 0x03, 0x04>;
System.println(bin);
```

```console
<0x01, 0x02, 0x03, 0x04>
```

### バイナリの代入

スプレッド演算子でバイナリ列をコピーできます。

```javascript
var bin = <0x01, 0x02, 0x03, 0x04>;
var val = <0x10, 0x20, ...bin, 0x30, 0x40>;
System.println(val);
```

```console
<0x10, 0x20, 0x01, 0x02, 0x03, 0x04, 0x30, 0x40>
```

また、バイナリと配列は相互にスプレッド演算子で分割、結合することが可能です。

```javascript
var bin = <0x01, 0x02, 0x03, 0x04>;
var ary = [...bin];
System.println(ary);

var ary = [10, 11, 12, 257];
var bin = <...ary>;
System.println(bin);
```

```console
[1, 2, 3, 4]
<0x0a, 0x0b, 0x0c, 0x01>
```

ただし、バイナリになった瞬間に 0x00-0xFF に丸められるのでご注意ください。

### 添え字アクセス

バイナリも配列同様に添え字でアクセスできます。
また、同様に添え字に負の数を指定すると末尾からアクセスするように動作します。

```javascript
var a = <1, 2, 3>;
System.println(a[1]);
System.println(a[-1]);
```

```console
2
3
```

## オブジェクト

オブジェクトとは、キー・バリュー形式で格納された連想配列のことです。

### オブジェクト・リテラル

オブジェクトの形式は、端的に言えば JSON 形式で書くことができます。

```json
{
    "key1": "value1",
    "key2": "value2"
}
```

純粋な JSON オブジェクトと異なる部分として、以下があります。

* キー部分のクォーテーションが不要。
* バリュー部分には式を書くことが可能。
* 最後の要素の後にカンマを付けることが可能。
* キー名とバリューに指定する変数名が同じ場合、短縮表記が可能。

これらを組み合わせると、次のような記述が可能です。

```javascript
var x = 10, y = 100;
var obj = {
    a: x + 1,
    b: y + 2,
    x,          // x: x
    y           // y: y
};
System.println(obj);
```

```console
{"a":11,"b":102,"x":10,"y":100}
```

### 要素へのアクセス

オブジェクトは連想配列であり、
配列同様の形で、添え字を文字列にすることでアクセスできます。
また、`obj["a"]` は `obj.a` とも書けます。

```javascript
var obj = { a: 100, b: 200, c: [1, 2] };
System.println(obj["a"]);
System.println(obj.a);
```

```console
100
100
```

### オブジェクトの代入

スプレッド演算子を使うと、次のようにオブジェクトのコピーが可能です。
ただし、このコピーは ''浅いコピー'' となります。
この例では `val.c[0]` を書き換えることで `obj.c[0]` も書き換わっていることが分かります。

```javascript
var obj = { a: 100, b: 200, c: [1, 2] };
var val = { ...obj, e: 400, f: 500};
val.c[0] = 10;
System.println(obj);
System.println(val);
```

```console
{"a":100,"b":200,"c":[10,2]}
{"a":100,"b":200,"c":[10,2],"e":400,"f":500}
```

オブジェクトの分割代入も可能です。
キーに対応する値が変数に代入されます。

```javascript
{ a, b, x: c } = { a: 100, b: 200, x: 300 };
System.println({ a, b, c });
```

```console
{"a":100,"b":200,"c":300}
```

この代入方法は宣言や関数の引数でも利用できます。
なお、キーが存在しない場合は null が設定されます。

```javascript
var obj = { a: 100, b: 200, x: 300 };
var { a, b, x: c } = obj;
System.println({ a, b, c });

function check({ a, b, x: c, y: d }) {
    System.println({ a, b, c, d });
}
check(obj);
```

```console
{"a":100,"b":200,"c":300}
{"a":100,"b":200,"c":300,"d":null}
```

分割代入の詳細は「\\nameref{分割代入とパターンマッチ}」を参照してください。

## 正規表現
### 正規表現リテラル

正規表現リテラルは `/.../` の形式で扱います。
この中では `/` 以外、例えば改行コードなどにエスケープを行う必要はありません。
リテラル内の「`/`」のみ「`\`」でエスケープする必要があります。

```javascript
/ab+[\t\n]/
```

また、これは以下と同じ意味になります。
この書き方の場合、改行などもエスケープが必要です。
Raw 文字列の書き方であればエスケープは不要です。

```javascript
new Regex("ab+[\\t\\n]");  // same as /ab+[\t\n]/
new Regex(%|ab+[\t\n]|);   // same as /ab+[\t\n]/
```

正規表現オブジェクトとして、`/` の記号を変更したい場合は、`%m` プレフィックスを付けて任意の記号を利用可能です。
使用した記号以外はエスケープする必要がありません。
このとき、Raw 文字列とは違い正規表現文字列で使っていない文字で囲うことが可能ですので、
次のような書き方もできます[^regexpat]。

[^regexpat]: できたほうが良いのかと言われると、そうでもありませんが。

```javascript
%m1ab+[\t\n]1  // same as /ab+[\t\n]/
```

囲み文字としてカッコを使う場合は対応する閉じカッコで対応させるように記述します。

```javascript
%m<ab+[\t\n]>  // same as /ab+[\t\n]/
%m(ab+[\t\n])  // same as /ab+[\t\n]/
```


### 文字列メソッドへの適用

正規表現オブジェクトは、文字列に対する以下のメソッドの条件として使用できます。

#### replace

`String.replace()` 関数は、変換元の文字列条件を正規表現で指定することが可能です。

```javascript
var s = "xabbbbbcabbc".replace(/ab+/, ",");
System.println(s);
```

```console
x,c,c
```

#### find

`String.find()` 関数は、検索文字列として正規表現を指定することが可能です。

```javascript
System.println("abcdefg".find("cd"));
System.println("abcdefg".find(/cd/));
```

```console
2
[{"begin":2,"end":4,"string":"cd"}]
```

通常の文字列で指定した場合は検出した場所のインデックスを返しますが、
正規表現で指定した場合は検出したグループの配列を返します。

#### split

`String.split()` 関数は、区切り文字列を正規表現で指定することが可能です。

```javascript
var s = "xabbbbbcabbc".split(/ab+/);
s.each(&(e) => System.println(e));
```

```console
x
c
c
```

### 基本的な使い方

正規表現の基本的な使い方の例を示します。

```javascript
var a = "111/aaa/bbb/ccc/ddd";
while (group = (a =~ /\w+\//)) {
    for (var i = 0, len = group.length(); i < len; ++i) {
        System.println("found[%2d,%2d) = %s"
            % group[i].begin
            % group[i].end
            % group[i].string);
    }
}
```

```console
found[ 0, 4) = 111/
found[ 4, 8) = aaa/
found[ 8,12) = bbb/
found[12,16) = ccc/
```

「`/`」を多用するような正規表現の場合、`%m` プレフィックスを付け、別のクォート文字を使うことで回避することもできます。
例えば `%m(...)` といった記述が可能です。
これを使って先の例を書き直すと、次のようになります。

```javascript
var a = "111/aaa/bbb/ccc/ddd";
while (group = (a =~ %m(\w+/))) {
    for (var i = 0, len = group.length(); i < len; ++i) {
        System.println("found[%2d,%2d) = %s"
            % group[i].begin
            % group[i].end
            % group[i].string);
    }
}
```

### 正規表現リテラルに対する注意

正規表現リテラルを `while` 等の条件式に入れることができますが、注意点があります。

例えば次のように記述した場合、`str` の文字列に対してマッチしなくなるまでループを回すことができます（`group` にはキャプチャ一覧が入ります）。
その際、最後のマッチまで実行せずに途中で `break` 等でループを抜けると、
正規表現リテラルの対象文字列が次回のループで正しくリセットされない場合があります。

```javascript
while (group = (str =~ /ab+/)) {
    /* block */
    if (expr) {
        break;
    }
}
```

`break` で一旦抜けた後に再度同じ `while` ループに戻ってきた場合、
検索開始場所が前回の続きとなってしまうという動作になります。
最後までループが回った場合（見つからない状態までループした場合）は問題ありません。
また、`str` の示す文字列が変化していた場合も問題ありません。

まとめると、正規表現リテラルがリセットされるタイミングは次の 2 パターンあり、
この条件に合えば問題ありません。

*   初回（前回のマッチが失敗して再度式が評価された場合を含む）。
*   `str` の内容が変化した場合。

現時点で本動作は仕様となります。
扱う際にはご注意願います。

## 範囲表現

範囲は「ある値からある値まで」を示す Range クラスのインスタンス（Range オブジェクト）を示します。

### `Range` クラス

Range オブジェクトは以下のように構築できます。
作成されたインスタンスは、指定された値に従って「ある値からある値まで」の範囲を示します。

```javascript
new Range(初値, 終値, 終値除外フラグ)
```

### 範囲リテラル（ドット記法）
#### 数値

Range はドット記法で記載することもできます。
ドット 2 つの場合は終端を含みます。
ドットを 3 つにすると、終端を含まない範囲となります。

```javascript
var a = 2..10;  // new Range(2, 10)
var b = 2...10; // new Range(2, 10, true)
```

初値、終値の部分には、変数や式も使うことができます。

```javascript
function makeRange(begin, len) {
    return begin..(begin+len);
}
System.println(makeRange(100, 2).end());
```

```console
102
```

#### 文字列

文字列の範囲も定義できます。

```javascript
var a = "a".."z";     // new Range("a", "z")
var b = "ab"..."ax";  // new Range("ab", "ax", true)
```

ダブルクォートでもシングルクォートでも同じ意味です。

```javascript
var l = 'a'..'g';  // 'a', 'b', 'c', ..., 'g'
l.each { => System.println(_1) };
```

```console
a
b
c
d
e
f
g
```

#### 日付

日付も範囲で扱えます。

```javascript
using DateTime;
var l = DateTime("2000/1/1")..DateTime("2000/1/6");
l.each { => System.println(_1.format("%MMMM% %DD%, %YYYY%")) };
```

```console
January 01, 2000
January 02, 2000
January 03, 2000
January 04, 2000
January 05, 2000
January 06, 2000
```

#### 初値と終値

終値は省略できます。
終端の無い範囲を示します。
たとえば、`1..` とすると、これは自然数を示します。
ただし、初値は省略できません。
どうしても省略したい場合は、null を使用します。

```javascript
1..;        // => Okay
1...;       // => Okay
..10;       // => error
...10;      // => error
null..10;   // => Okay
```

### `Enumerable` クラス

Range オブジェクトは Enumerable モジュールを mixin しているため、
Enumerable のインタフェースが利用できます。

現時点で実装しているインターフェースは以下の通りです。
**「遅」** にマークされているものは、`lazy()` 呼び出しをした際に Enumerator オブジェクトを返し、
遅延評価実行されるようになるメソッドです。

<context label="Table:KinxEnumerable"/>
<context caption="Enumerable メソッド"/>
<context limit-column="2"/>

|     メソッド     |                                       内容                                        |  遅   |
| ---------------- | --------------------------------------------------------------------------------- | :---: |
| `filter(f)`      | 各要素に対し `f` 関数の結果が真となる要素でフィルタする。                         |   O   |
| `map(f)`         | 各要素に対し `f` 関数を適用させた結果を返す。                                     |   O   |
| `flatMap(f)`     | 各要素に対し `f` 関数を適用させた結果をフラットにして返す。                       |   O   |
| `take(n)`        | 先頭から `n` 個の要素を抽出する。                                                 |   O   |
| `takeWhile(f)`   | `f` に適合している間、要素を抽出する。                                            |   O   |
| `drop(n)`        | 先頭から `n` 個の要素を捨てて残りを抽出する。                                     |   O   |
| `dropWhile(f)`   | `f` に適合している間の要素を捨てて、残りを抽出する。                              |   O   |
| `each(f)`        | 全ての要素を `f` に順に流す。                                                     |   O   |
| `reduce(f, itr)` | 初期値から開始し、順に `f` 関数を適用した結果で `reduce` する。                   |       |
| `sort(f)`        | `f` を比較関数としてソートを実施する。                                            |       |
| `all(f)`         | 全ての要素が `f` 適用結果で真となる場合、真となる。                               |       |
| `any(f)`         | 要素の中で `f` 適用結果が真となるものが 1 つでも存在する場合、真となる。                   |       |
| `toArray()`      | 要素をすべて抽出し、配列として返す。                                              |       |
| `println()`      | 全ての要素を出力する。                                                            |       |
| `lazy()`         | 上記「遅：O」のメソッドを遅延評価メソッドとして動作するようにして自分自身を返す。 |       |

なお、遅延評価ではないものに無限数列のような Range を与えると返ってこなくなりますので注意してください。

### Range for Switch-Case

`switch-case/when` の `case` または `when` 文で Range オブジェクトを指定できます。
指定した範囲にマッチするか確認します。
次の例は数値で指定した例です。

```javascript
for (var i = 0; i <= 10; ++i) {
    switch (i) {
    when 1..4:
        System.println("okay 1 (%{i})");
    when 7...9:
        System.println("okay 2 (%{i})");
    else:
        System.println("out of range (%{i})");
    }
}
```

```console
out of range (0)
okay 1 (1)
okay 1 (2)
okay 1 (3)
okay 1 (4)
out of range (5)
out of range (6)
okay 2 (7)
okay 2 (8)
out of range (9)
out of range (10)
```

次の例は文字列で指定した例です。

```javascript
for (var i in 's'..'af') {
    switch (i) {
    when 'ac'..'ae':
        System.println("okay 1 (%{i})");
    when 't'...'w':
        System.println("okay 2 (%{i})");
    else:
        System.println("out of range (%{i})");
    }
}
```

```console
out of range (s)
okay 2 (t)
okay 2 (u)
okay 2 (v)
out of range (w)
out of range (x)
out of range (y)
out of range (z)
out of range (aa)
out of range (ab)
okay 1 (ac)
okay 1 (ad)
okay 1 (ae)
out of range (af)
```

## データ型の相互変換

## 特殊オブジェクト

特殊オブジェクトとは、特定のデータ型に対して直接メソッド呼び出しを行うためのメソッドが定義されたオブジェクトのことで、
String、Integer、Double、Binary、Array があります。
また、特殊オブジェクトが対象としているオブジェクト（String なら文字列）に対して直接作用させるメソッドのことを特殊メソッドと呼びます。

ただし、以下の観点から特殊オブジェクトに対する特殊メソッドの追加はお勧めしません。

* **ライブラリの追加（組み込み特殊メソッドの追加）で使う可能性がある** こと。
* **標準ライブラリの中での挙動が変わり、正しく動作しなくなる可能性がある** こと。

ライブラリ作成などでこの仕組みを使うと便利なのですが、
他のライブラリとの競合などに注意する必要があります。
ここでは「仕組みとしての特殊オブジェクト」という観点で、説明します。

### 特殊オブジェクトの例

例えば、特殊オブジェクト `String` に対して以下のように関数定義してみましょう。

```javascript
String.greeting = function(name) {
    System.println("Hello, I am %{name}.");
};
```

すると、以下のように書くことができるようになります。

```javascript
"John".greeting();
```

実行してみると、以下のように出力されます。

```console
Hello, I am John.
```

対象となる `"John"` が `String.greeting` 関数の `name` に引き渡されたのが分かるでしょう。
つまり、対象オブジェクトが特殊メソッドの第一引数として渡されるといった動作をします。
この仕組みを使って、文字列に対する操作関数を自由に定義することができます。

特殊オブジェクトに定義されたメソッドを特殊メソッドと呼び、
「\\nameref{特殊メソッド}」に良く使う特殊メソッドをまとめましたので、
ご参照ください。