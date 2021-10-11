
# 式と演算子

## 式

評価され、特定の値を持つものを「式」と呼びます。
主に「文」の中で使用され、
評価された後の特定の値に基づいて処理を分岐させたり、
評価された値を一旦変数に保持しておき、他の文脈で使用したりします。

「式」は演算子を通して評価され、最終的に「式」全体が特定の値に収斂します。
例えば「`1+2+3`」という式は、まず `1+2` が評価され `3` となります。
その次に `3+3` が評価され、最終的に式全体が `6` という値に評価されます。

本章では演算子、および特別な式の構文である `case-when` について説明します。

## 演算子

ここで説明される演算子は以下の通りです。

* \\textref{代入演算子}
* \\textref{比較演算子}
* \\textref{算術演算子}
* \\textref{ビット演算子}
* \\textref{論理演算子}
* \\textref{添え字／プロパティ・アクセス}
* \\textref{インクリメント・デクリメント}
* \\textref{三項演算子}
* \\textref{スプレッド・レスト演算子}
* \\textref{パイプライン演算子}
* \\textref{関数合成演算子}

具体的な演算子一覧とその優先順位に関しては、「\\nameref{演算子と優先順位}」に表としてまとめてありますので、ご参照ください。

<pagebreak />

### 代入演算子

代入演算子は右辺の値を元に、左辺へ値を代入するものです。
基本的にはイコール（''`=`''）を使います。
例えば、`x = y` では `y` の値を `x` へ代入します。

代入演算子では、最終的に代入された値が式の値となるため、
代入演算子を順次適用して複数の変数に同じ値を代入できます。
このため、代入演算子は**右結合**となっています。

```kinx
a = b = c = 10;
System.println([a, b, c]);
```

```console
[10, 10, 10]
```

また以下の表に示すように、演算の省略形である複合代入演算子もあります。

<context label="Table:KinxCompoundAssignmentOperators"/>
<context caption="複合代入演算子"/>

|             名称              |     略記演算子     |      意味      |
| ----------------------------- | ------------------ | -------------- |
| 代入                          | `x = y`            | `x = y`        |
| 加算代入                      | `x += y`           | `x = x + y`    |
| 減算代入                      | `x -= y`           | `x = x - y`    |
| 乗算代入                      | `x *= y`           | `x = x * y`    |
| 除算代入                      | `x /= y`           | `x = x / y`    |
| 剰余代入                      | `x %= y`           | `x = x % y`    |
| べき乗代入                    | `x **= y`          | `x = x ** y`   |
| 左シフト代入                  | `x <<= y`          | `x = x << y`   |
| 右シフト代入                  | `x >>= y`          | `x = x >> y`   |
| ビット論理積 (AND) 代入       | `x &= y`           | `x = x & y`    |
| ビット排他的論理和 (XOR) 代入 | `x ^= y`           | `x = x ^ y`    |
| ビット論理和 (OR) 代入        | `x |= y`           | `x = x | y`    |
| 論理積代入                    | `x &&= y`          | `x && (x = y)` |
| 論理和代入                    | `x ||= y`          | `x || (x = y)` |
| Null 合体代入                 | `x ??= y`          | `x ?? (x = y)` |

<pagebreak />

#### 分割代入

分割代入は、より複雑な代入を行うために用意されています。
分割代入は、配列やオブジェクト・リテラルを作る構文を使って、配列やオブジェクトから値を抽出できるようにします。

詳しくは、「\\nameref{分割代入とパターンマッチ}」を参照してください。

### 比較演算子

比較演算子は左辺と右辺を比較し、結果として真なら 1 (`true`) を、偽なら 0 (`false`) を返します。
比較対象は数値、文字列、オブジェクトなどです。
ほとんどの場合、両辺は同じ型でない場合でも Kinx は比較に適した型に自動的に変換しようとします。
しかし、変換ができない場合や、サポートされていない型同士の比較を行った場合、`SystemException` 例外が送出されます。

比較演算子は主に `if` のような条件で使用されます。
以下がサンプルです。

```kinx
if (a < b) {
    /* then clause */
} else {
    /* else clause */
}
```

<context label="Table:KinxComparisonOperators"/>
<context caption="比較演算子"/>

| l. 演算子 |    \<.     |             true を返す例              |
| :-------: | ---------- | -------------------------------------- |
|   `==`    | 等価       | `3 == var1`, `"3" == var1`, `3 == '3'` |
|   `!=`    | 不等価     | `var1 != 4`, `var2 != "3"`             |
|    `>`    | より大きい | `var2 > var1`, `"12" > 2`              |
|   `>=`    | 以上       | `var2 >= var1`, `var1 >= 3`            |
|    `<`    | より小さい | `var1 < var2`, `"2" < 12`              |
|   `<=`    | 以下       | `var1 <= var2`, `var2 <= 5`            |

### 算術演算子

算出演算子は標準的な加算（''`+`''）、減算（''`-`''）、乗算（''`*`''）、除算（''`/`''）、剰余（''`%`''）のような演算子のことを言います。

```kinx
var a = 1, b = 2;
var r = a / b;
System.println([r, r.isDouble]);
```

```console
[0.5, 1]
```

これらの演算子は、多くの他のプログラミング言語と同様に機能しますが、型は演算に適したものに変換しようとします。
例えば、`1/2` のような整数同士の演算で、結果が `0.5` のような実数となる場合、結果の型は `double` となります。
なお、ゼロ除算では `DivideByZero` 例外が送出されることにご注意ください。

Kinx はべき乗の演算子として ''`**`'' もサポートしています。
この演算子は、数学的な慣習にしたがって右から左に評価されます。
例えば、`2**3**4` は `2**(3**4)` を意味しており、結果は `2417851639229258349412352` となります。

<context label="Table:KinxArithmeticOperators"/>
<context caption="Arithmetic Operators"/>

| l. 演算子 |     \<.      |                                 例                                 |              備考              |
| :-------: | :----------- | ------------------------------------------------------------------ | ------------------------------ |
|    `+`    | 加算         | `12 + 5` \\arrow{right} `17`.                                      |                                |
|    `-`    | 減算         | `12 - 5` \\arrow{right} `7`.                                       |                                |
|    `*`    | 乗算         | `12 * 5` \\arrow{right} `60`.                                      |                                |
|    `/`    | 除算         | `12 / 5` \\arrow{right} `2`.                                       |                                |
|    `%`    | 剰余         | `12 % 5` \\arrow{right} `2`.                                       |                                |
|    `-`    | 単項マイナス | `x == 3` \\arrow{right-x} `-x` \\arrow{right} `-3`.                |                                |
|    `+`    | 単項プラス   | ''`3`'' \\arrow{right} ''`3`''.<br />+true \\arrow{right} `1`.     | 単に無視される。               |
|   `**`    | べき乗       | `2 ** 3 `\\arrow{right} `8`.<br />`10 ** -1` \\arrow{right} `0.1`. | $2^3 = 8$<br />$10^{-1} = 0.1$ |

### ビット演算子

ビット演算子は、オペランドを10進数、16進数、8進数ではなく、0と1のビット集合として扱います。
例えば，10進数の `9` は，2進数では `1001` となります。
ビットサイズは、値によって異なります。
例えば，単純な整数の場合は64ビットですが，多倍長整数の場合は値に応じてビットサイズが拡張されます。
ビット演算子はこのような2進表現に対して演算を行いますが、通常の数値を返します。

<context label="Table:KinxBitwiseOperators"/>
<context caption="Bitwise Operators"/>

| l. 演算子 |    \<.     |  使用法  |             備考             |
| :-------: | ---------- | -------- | ---------------------------- |
|    `&`    | ビット AND | `a & b`  |                              |
|    `|`    | ビット OR  | `a | b`  |                              |
|    `^`    | ビット XOR | `a ^ b`  |                              |
|    `~`    | ビット NOT | `~a`     |                              |
|   `<<`    | 左シフト   | `a << b` | 右から 0 を挿入します。      |
|   `>>`    | 右シフト   | `a >> b` | 溢れたビットは破棄されます。 |

### 論理演算子

論理演算子は通常真偽値と共に使用され、真偽値を返します。
しかし、''`&&`''、''`||`''、''`??`'' の 3 つの演算子は、実際には指定された値のうちの一つを返しますので、
真偽値を使っていない場合にはその値そのものを返します。

<context label="Table:KinxLogicalOperators"/>
<context caption="Logical Operators"/>

| l. 演算子 |       \<.       |      使用法      |                                  説明                                   |
| :-------: | --------------- | ---------------- | ----------------------------------------------------------------------- |
|    `!`    | 論理否定(NOT)   | `!expr`          | `expr` が true または有効値の場合は false、そうでなければ true。        |
|   `&&`    | 論理積 (AND)    | `expr1 && expr2` | `expr1` が false または無効値の場合は `expr1`、そうでなければ `expr2`。 |
|   `||`    | 論理和 (OR)     | `expr1 || expr2` | `expr1` が true または有効値の場合は `expr1`、 そうでなければ `expr2`。 |
|   `??`    | Null 合体演算子 | `expr1 ?? expr2` | `expr1` が null ではない場合は `expr1`、そうでなければ `expr2`。        |

#### 短絡評価

論理式は左から右へと評価されますが、以下のルールで「短絡的」に評価されます。そのため、下記式の `anything` の部分は評価されません。

* `false && anything` は、短絡的に false と評価されます。
* `true || anything` は短絡的に true と評価されます。
* `nonNull ?? anything` は、`nonNull` が非 null 値の場合、`nonNull` と短絡的に評価されます。

また、これらの演算子は代入演算子と組み合わせることもできます。
例えば、`a ??= b`とすると、`a` が NULL の場合に限り、`b` の値が `a` に代入されます。
これは、「\\nameref{Table:KinxCompoundAssignmentOperators}」の表にも記載されています。

### 添え字／プロパティ・アクセス

配列、バイナリ、`[]` メソッドを持つオブジェクトは（見た目上）添え字によるアクセスが可能です。
配列とバイナリに対しては、添え字に整数と実数（整数化される）が利用できます。
オブジェクトのプロパティに対しては、文字列を添え字に使います。
これは `.property` 形式によるプロパティ・アクセスと同等です。

```kinx
var a = [1, 2, 3], b = <1, 2, 3>;
var r1 = a[0];
var r2 = b[1];
var c = { key: [a[2.1], b[2.2]] };  // => [a[2], b[2]] と同様
var r3 = c["key"];
var r4 = c.key;     // => c["key"] と同様
System.println([r1, r2, r3, r4]);
```

```console
[1, 2, [3, 3], [3, 3]]
```

### インクリメント・デクリメント

インクリメントとデクリメント演算子には、前置形式と後置形式があります。
C/C++ 同様に、前置形式では評価の前に演算が行われるのに対し、
後置形式では評価された後に演算が行われます。

```kinx
var a = 10;
var b = ++a;
var c = a--;
System.println([a, b, c]);
```

```console
[10, 11, 11]
```

### 三項演算子

三項演算子も短絡演算子の一種で、`a ? b : c` の形式で使用します。
`a` が真の場合に `b` を、それ以外の場合 `c` が評価されます。
また、三項演算子は右結合です[^ternary]。

[^ternary]: これは直観的な動作と合致するので、特に意識する必要はありません。

```kinx
function ternary(a, b, c) {
    return a ? b : c;
}
System.println([ternary(true, 1, 10), ternary(false, 2, 20)]);
```

```console
[1, 20]
```

### スプレッド・レスト演算子

スプレッド・レスト演算子は、配列やオブジェクトの展開・結合のために利用できます。

#### レスト演算子

例えば、レスト演算子は代入や宣言で使用され、配列やバイナリの残りの要素を受け取ることができます。
ただし、オブジェクトに対してのレスト演算子は未サポートです。

```kinx
var [a, ...b] = [1, 2, 3, 4, 5];
System.println([a, b]);
```

```console
[1, [2, 3, 4, 5]]
```

#### スプレッド演算子

一方で、スプレッド演算子は配列やバイナリの中でスプレッド演算子として使用することもできます。
その場合、浅いコピー（Shallow Copy）として動作します。

```kinx
var a = [1, 2, 3, 4, 5];
var b = [0, ...a, 10];
System.println(b);
```

```console
[0, 1, 2, 3, 4, 5, 10]
```

バイナリの場合は以下のようになります。
配列の場合と同じであることが分かるでしょう。

```kinx
var a = <1, 2, 3, 4, 5>;
var b = <0, ...a, 10>;
System.println(b);
```

```console
<0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x0a>
```

スプレッド演算子はオブジェクトに対しても使用できます。
オブジェクトに対しても、浅いコピーとして動作します。

```kinx
var a = { a: 10, b: 20, c: [1, 2, 3], d: { x: 100 } };
var b = { z: 2000,  ...a };
a.d.x = 150;
System.println(b);
```

```console
{"a":10,"b":20,"c":[1,2,3],"d":{"x":150},"z":2000}
```

浅いコピーであるため、`a.d.x` を変更したことで `b.d.x` も変更されたことが分かります。

#### 関数呼び出しでのスプレッド・レスト演算子

レスト演算子は関数の引数で使用することもできます。

```kinx
function test(a, ...b) {
    System.println([a, b]);
}
test(1, 2, 3, 4, 5);
```

```console
[1, [2, 3, 4, 5]]
```

一方で、スプレッド演算子は関数呼び出しでの引数に使用することができます。
この場合、配列を関数の個別の引数に分解して関数呼び出しを実行します。

```kinx
function test(a, ...b) {
    System.println([a, b]);
}
var a = [1, 2, 3, 4, 5];
test(...a);
```

```console
[1, [2, 3, 4, 5]]
```

これによって、引数の数が分からない場合でも引数の転送関数を定義できます。
次の例では、`transfer` 関数は配列として全ての引数を受け取り、
それを再度個別の引数に分解して `toActualFunction` に引数を転送する例です。

```kinx
function transfer(...args) {
    return toActualFunction(...args);
}
```

### パイプライン演算子

パイプライン演算子は 1 つの引数による関数呼び出しのシンタックス・シュガーです。
例えば、`64 |> Math.sqrt` は `Math.sqrt(64)` と全く同じことを意味します。
この機能によって連続した関数呼び出しに対する可読性が向上します。

```kinx
function doubleSay(str)  { return "%{str}, %{str}";  }
function capitalize(str) { return str.toUpper(0, 1); }
function exclaim(str)    { return str + '!';         }

var result = exclaim(capitalize(doubleSay("hello")));
System.println(result); // general case

var result = "hello"
    |> doubleSay
    |> capitalize
    |> exclaim;

System.println(result); // pipeline case
```

```console
Hello, hello!
Hello, hello!
```

<pagebreak />

`<|` 演算子も利用可能です。
これは逆方向に関数が連結され、値は右から左へと順に渡されていく動作をします。

```kinx
var result = exclaim <| capitalize <| doubleSay <| "hello";
System.println(result); // => "Hello, hello!"
```

```console
Hello, hello!
```

もしパイプラインで複数引数の関数を扱いたいときは、ラムダを利用します。

```kinx
function double(x) { return x + x; }
function add(x, y) { return x + y; }
var boundScore = &(min, max, score) => Math.max(min, Math.min(max, score));

var person = { score: 25 };
var newScore = person.score
    |> double
    |> { => add(7, _) }
    |> { => boundScore(0, 100, _) };

System.println(newScore);
```

```console
57
```
### 関数合成演算子

関数合成演算子は関数を合成した新しい関数を作り出します。
例えば、`Math.abs +> Math.sqrt` は `&(a) => Math.sqrt(Math.abs(a))` を意味します。
この機能は、複数の関数を連結した際の可読性を向上し、さらに再利用可能な合成された関数を使えるようにします。

```kinx
function doubleSay(str)  { return "%{str}, %{str}";  }
function capitalize(str) { return str.toUpper(0, 1); }
function exclaim(str)    { return str + '!';         }

var result = exclaim(capitalize(doubleSay("hello")));
System.println(result);

// 新たな合成関数の作成
var doubleSayThenCapitalizeThenExclaim = doubleSay +> capitalize +> exclaim;

var result = "hello" |> doubleSayThenCapitalizeThenExclaim;
System.println(result);
```

```console
Hello, hello!
Hello, hello!
```

`<+` 演算子も有効です。
これは逆方向に連結し、右に指定された関数から順に適用されるように関数が合成されていきます。

```kinx
var doubleSayThenCapitalizeThenExclaim
    = exclaim <+ capitalize <+ doubleSay;

var result = "hello" |> doubleSayThenCapitalizeThenExclaim;
System.println(result);
```

```console
Hello, hello!
```

もし関数合成でも複数引数の関数を扱いたいときは、ラムダを利用します。

```kinx
function double(x) { return x + x; }
function add(x, y) { return x + y; }
function boundScore(min, max, score) {
    return Math.max(min, Math.min(max, score));
}

var person = { score: 25 };

// 新たな合成関数を作成
var newScoring
    = double
    +> { => add(7, _) }
    +> { => boundScore(0, 100, _) };

var newScore = person.score |> newScoring;
System.println(newScore);
```

```console
57
```

パイプライン演算子と関数合成演算子は似たような機能を持っています。
しかし、パイプライン演算子はその場で値を渡しますが、関数合成演算子は再利用可能な新しい関数を作成するだけであるという違いがあります。
状況に応じて両方の演算子を使い分けてください。

## 分割代入とパターンマッチ

分割代入とパターンマッチは非常に使いやすく便利な構文を提供します。
分割代入は JavaScript 由来ですが、その便利さのため Kinx にもすぐに導入されました。
また、パターンマッチは特に `case-when` 式の中で Ruby の `case-in` に似た非常に強力な表現力を提供します。`case-when` の詳細については「\\nameref{Case-When}」を参照してください。

### 分割代入とパターンマッチとは

Kinx では配列とオブジェクトは良く利用されます。
オブジェクトを使用すると、データ項目をキーごとに格納する単一のエンティティ（実体）として扱うことができます。
配列も順序付けされたリストとして各データを集約して利用することができます。
一方で、これらを関数に渡したり、他のシーンで利用したりしようとした場合、オブジェクト／配列全体を必要としないケース、つまり、個々の「部分」のみが必要なケースがあります。

分割代入（Destructuring assignment）は、配列またはオブジェクトの中身を、そのリテラルを構築するのと同じ形式を利用して複数の変数に「アンパック」できるようにする特別な構文であり、非常に便利な構文です。
また、パターンマッチではその値が期待する値となっているかを確認することが可能であり、期待しない値が含まれているケースを排除することができます。

分割代入・パターンマッチは、以下で利用可能です。

* 宣言文での代入
* 代入文での代入
* 関数の引数
* `case-when` での条件式

本章では必要に応じていずれかの形式で説明していますが、全ての形式で同様に利用可能です。
さらに、`case-when` ではパターンマッチとそれを組み合わせた条件式を使って様々なケースに対応することが可能です。

### 配列の分割代入

#### 通常の使い方

以下は、配列を変数に分割する方法の基本的な例です。

```kinx
var arr = ["John", "Smith"];
var [name, surname] = arr;
System.println(name);
System.println(surname);
```

```console
John
Smith
```

このように、ある変数の中身をそのまま取り出し、要素分解した形で `name`、`surname` という新しい変数にそれぞれ代入できます。

また、split やその他配列を返すメソッドと組み合わせると非常に便利です。
例えば次の例は split メソッドを使用した例です。

```kinx
var [name, surname] = "John Smith".split(' ');
System.println(name);
System.println(surname);
```

```console
John
Smith
```

別の例として、関数の引数として使用すると以下のようになります。

```kinx
var arr = ["John", "Smith"];
function destructuring([name, surname]) {
    System.println(name);
    System.println(surname);
}
destructuring(arr);
```

```console
John
Smith
```

なお、これはスプレッド演算子を使った以下の例と同じ結果となります。

```kinx
var arr = ["John", "Smith"];
function spreading(name, surname) {
    System.println(name);
    System.println(surname);
}
spreading(...arr);
```

```console
John
Smith
```

#### 値の交換

この分割代入のテクニックは、値の交換にも使えます。

```kinx
var a = 1, b = 2;
[a, b] = [b, a];
System.println([a, b]);
```

```console
[2, 1]
```

3つ以上の値のローテーションなども可能です。

```kinx
var a = 1, b = 2, c = 3;
[a, b, c] = [c, a, b];
System.println([a, b, c]);
```

```console
[3, 1, 2]
```

#### 残りの要素の取得

通常、代入されずに残った要素は破棄されます。

```kinx
var [a, b, c] = 10.times { => _1 * 10 + 1 };
System.println({ a, b, c });
```

```console
{"a":1,"b":11,"c":21}
```

この場合、レスト演算子を使用することで残りの要素を配列として受け取ることが可能です。
ただし、受け取る側の配列要素の最後に配置するようにしてください。

```kinx
var [a, b, c, ...d] = 10.times { => _1 * 10 + 1 };
System.println({ a, b, c, d });
```

```console
{"a":1,"b":11,"c":21,"d":[31,41,51,61,71,81,91]}
```

#### 要素の省略

末尾の要素は受け取る変数を指定しなければ良いのですが、
先頭や途中に受け取る必要のない要素があった場合は省略することも可能です。

```kinx
var [, b, , ...d] = 10.times { => _1 * 10 + 1 };
System.println({ b, d });
```

```console
{"b":11,"d":[31,41,51,61,71,81,91]}
```

#### デフォルト値

代入する変数の数よりも配列の要素数のほうが少ない場合でもエラーにはなりません。
不足している値は null となります。
デフォルト値の指定はできません。

```kinx
var [a, b, c, d, e, f, g, h] = [1, 2, 3];
System.println({ a, b, c, d, e, f, g, h });
```

```console
{"a":1,"b":2,"c":3,"d":null,"e":null,"f":null,"g":null,"h":null}
```

#### その他の代入

左辺値となるものであれば、全て代入先として指定することが可能です。
以下の例では、`user` オブジェクトの各プロパティに分割した値を直接代入しています。

```kinx
[user.name, user.surname] = "John Smith".split(' ');
System.println(user);
```

```console
{"name":"John","surname":"Smith"}
```

### オブジェクトの分割代入

#### 通常の使い方

オブジェクトの分割代入は、キーに対応する値の部分に変数などの左辺値を配置することで実施します。
その際、順序は考慮されません。

```kinx
var { height: h, width: w, title: t } = { title: "Menu", height: 200, width: 100 };
System.println([h, w, t]);
```

```console
[200, 100, "Menu"]
```

#### キー名の省略

オブジェクトには、省略表記というキー名と変数名が同じ場合にキー名を省略することができる、という機能があります。
この機能によって、さらに容易に分割代入式を書くことができます。

```kinx
var { height, width, title } = { title: "Menu", height: 200, width: 100 };
System.println([height, width, title]);
```

```console
[200, 100, "Menu"]
```

また、これによって、関数呼び出しにおける「名前付き引数」のような機能も実現可能です。

```kinx
function greeting({ name, age }) {
    System.println("My name is %{name}, and %{age} years old.");
}
greeting({ name: "John", age: 29 });
```

```console
My name is John, and 29 years old.
```

### 配列のパターンマッチ

左辺値に定数を記載すると該当の要素がその値であるかをチェックします。

```kinx
[100, b, c] = [100, 200, 300];
System.println([b, c]);
```

```console
[200, 300]
```

ただし、変数を記載した場合は通常その変数は代入先として認識されます。
そこで、変数の値を固定してチェック対象とする場合はピン演算子（''`^`''）というものを使用します。
これによって、代入先としての変数ではなく、変数の保持する値をパターンチェックのための固定値として扱うようになります。

次の例では、最初の要素が 1 であるため、`b` と `c` への代入が成功します。

```kinx
var a = 1;
[^a, b, c] = [1, 2, 3];
System.println([a, b, c]);
```

```console
[1, 2, 3]
```

次の例では、最初の要素が 1 ではないため、`NoMatchingPatternException` 例外が送出されることになります。

```kinx
var a = 1;
[^a, b, c] = [10, 20, 30];
System.println([a, b, c]);
```

```console
Uncaught exception: No one catch the exception.
NoMatchingPatternException: Pattern not matched
Stack Trace Information:
        at <main-block>(test.kx:2)
```

### オブジェクトのパターンマッチ

オブジェクト内の値として定数を記載すると、同じ場所に同じ値があるかを確認します。

```kinx
{ a: 100, b, c } = { a: 100, b: 200, c: 300 };
System.println([b, c]);
```

```console
[200, 300]
```

オブジェクトの場合も配列と同様に、変数の値を固定してチェック対象とする場合にはピン演算子（''`^`''）を使用します。

次の例では、`a` が 1 であるため、`b` と `c` への代入が成功します。

```kinx
var a = 1;
{ a: ^a, b, c } = { a: 1, b: 2, c: 3 };
System.println([a, b, c]);
```

```console
[1, 2, 3]
```

次の例では、`a` が 1 ではないため、`NoMatchingPatternException` 例外が送出されることになります。

```kinx
var a = 1;
{ a: ^a, b, c } = { a: 10, b: 20, c: 30 };
System.println([a, b, c]);
```

```console
Uncaught exception: No one catch the exception.
NoMatchingPatternException: Pattern not matched
Stack Trace Information:
        at <main-block>(test.kx:2)
```

### 複雑な例

オブジェクトと配列が複雑に絡み合った例でも問題無く動作します。
例えば、オブジェクトまたは配列に他のオブジェクトや配列が含まれている場合、より複雑な左辺のパターンを使用して、より深い部分を抽出することもできます。

次の例では定数およびピン演算子で指定された値が全てマッチするため、問題無く各変数への代入が行われます。

```kinx
var pred = 4;
{ a, b, c: [1, 2, { c: x }, ^pred]} = { a: 1, b: 2, c: [1, 2, { c: 100 }, 4]};
System.println({ a, b, x });
```

```console
{"a":1,"b":2,"x":100}
```

一方で、次の代入の例ではオブジェクトの `.c[3]` に位置する `^pred` の値がマッチしていないために `NoMatchingPatternException` 例外が送出されることになります。

```kinx
var pred = 400;
{ a, b, c: [1, 2, { c: x }, ^pred]} = { a: 1, b: 2, c: [1, 2, { c: 100 }, 4]};
System.println({ a, b, x });
```

```console
Uncaught exception: No one catch the exception.
NoMatchingPatternException: Pattern not matched
Stack Trace Information:
        at <main-block>(test.kx:5)
```

次の例は、関数の引数として入れ子のオブジェクトや配列を使った複雑な例となります。

```kinx
var options = {
    title: "Title-1", width: 100, height: 10,
    elements: ["Elem-1", "Elem-2"]
};

function showOptions({
    title,
    width:  w,  // width is assigned to w
    height: h,  // height is assigned to h
    elements: [elem1, elem2],
}) {
    System.println('%{title} - width:%{w}, height:%{h}');
    System.println({ elem1, elem2 });
}

showOptions(options);
```

```console
Title-1 - width:100, height:10
{"elem1":"Elem-1","elem2":"Elem-2"}
```

パターンマッチでは、このように配列とオブジェクトが複雑に組み合わされたものに対しても問題無く動作します。
次の `case-when` の章では、それをさらに活用した形で式に組み込んで使用する方法をご紹介します。

## Case-When

Kinx では `case-when` は「式」となります。
したがって、評価された結果の値を持ち、他の式や演算子と組み合わせて使用することができます。

### `switch-case`、`switch-when` との違い

`case-when` 式は `switch-case` や `switch-when` のような構文として導入されていますが、以下のような違いがあります。

* `switch-case` と `switch-when` は「文」ですが、`case-when` は「式」です。`case-when` は式の中で使用することができ、結果の値を変数に代入したり、計算に使用することができます。
* `switch-case` はデフォルトではフォールスルーですが、`case-when` は `switch-when` と同様に自動的に `break` します。常にいずれかの `when` 句が使用されます。
* `switch-case` と `switch-when` は値が同じかどうかだけをチェックしますが、`case-when` は配列やオブジェクトの形状が同じかどうかをチェックします。これは Ruby のパターンマッチ構文である`case-in` に似ています。
* `switch-case` や `switch-when` では、値をチェックする順番は通常保証されておらず、パフォーマンスのために場合によってはテーブル・ジャンプを生成します。しかし、`case-when` ではチェックの順番は常にソースコードに書かれた順番で、上から順にチェックしていきます。
* `switch-case` や `switch-when` では条件にマッチしなかった場合、何もせずに先に進みます。一方で、`case-when` の場合 `NoMatchingPatternException` 例外が発生します。
* `when` にブロックを置くことは、その場で関数を呼び出すことを意味します。したがって、`when` 節のブロック内の `return` は呼び出し元の関数に戻ることはなく、`when` 節の結果を返すだけです。
* `case-when` は式なので、文を書きたいときはブロックが必要になります。前述の通り、ブロックは自動的に呼び出される関数オブジェクトなので、複数の文をブロックに書いて実行することができます。
* `case-when` は式なので、ステートメントの終わりにはセミコロン（''`;`''）が必要です。

### 基本的な使い方

#### 通常の場合

`case-when` の例を以下に示します。
これは、単純に値をチェックするものです。

```kinx
function example(y) {
    var x = case y
        when 1: 1
        when 2: 20
        when 3: 300
        when 4: 4000
        when 5: {
            return 50000;
                // this is an automatically called internal function,
                // so 50000 will be returned to the case expression itself
                // and it is just assigned to the variable `x`.
        }
        otherwise: -1
    ;
    return x + 1;
}
7.times { => System.println(example(_)) };
```

```console
0
2
21
301
4001
50001
0
```

<pagebreak />

#### コロンの省略

`when` 節がブロック、修飾子、または `otherwise` 節の場合、コロンを省略できます。
この例では `if` 修飾子と `v` によるパターンマッチ構文を使っていますが、
修飾子とパターンマッチ構文に関しては後述します。

```kinx
function example(y) {
    var x = case y
        when 1: 1
        when 2: 20
        when 3: 300
        when 4: 4000
        when 5 {
            return 50000;
        }
        when v if (v == 6) {
            return 600000;
        }
        when v if (v == 7)
            7000000
        otherwise -1
    ;
    return x + 1;
}
9.times { => System.println(example(_)) };
```

```console
0
2
21
301
4001
50001
600001
7000001
0
```

#### 式内での利用

式の内部で `case-when` を使いたい場合、構文上の曖昧さと構文エラーを回避するために `(` と `)` を使ってください。
例えば、以下のように期待と異なる結果となる場合があります。

```kinx
var y = 1;
var x = case y when 1: 1 when 2: 2 + 3;
// x means 4, or 1 ?
System.println(x);  // => 1, because it is `case y when 1: 1 when 2: (2 + 3)`.
```

```console
1
```

<pagebreak />

もし、上記で `4` の結果が必要な場合、以下のように書かなければなりません。

```kinx
var y = 1;
var x = (case y when 1: 1 when 2: 2) + 3;
// x means 4, or 1 ?
System.println(x);  // => 4
```

```console
4
```

### 非フォールスルー

`case-when` にはフォールスルーはありません。
常に 1 つの条件が選択され、実施されます。
どの条件にもマッチしない場合、`otherwise` 節が実行されます。
さらに、`otherwise` 節もなかった場合には、`NoMatchingPatternException` 例外が送出されます。

なお、例外が `NoMatchingPatternException` である理由は、
`case-when` では次で説明する「パターンマッチ」で動作する前提のためです。
下記例のような定数条件は、単に値が等しいか確認するという最も単純なパターンマッチの一種という扱いになります。

```kinx
function example(y) {
    return case y
        when 0: 0
        when 1: 1
        when 2: 20
        when 3: 300
        when 4: 4000
        when 5: {
            return 50000;
        }
        // no otherwise clause...
    ;
}
7.times { => System.println(example(_)) };
```

```console
0
1
20
300
4000
50000
Uncaught exception: No one catch the exception.
NoMatchingPatternException: Pattern not matched
Stack Trace Information:
        at function example(test.kx:12)
        at function __test_kx_14___anonymous_func228(test.kx:14)
        at <main-block>(test.kx:14)
```

<pagebreak />

### パターンマッチ構文

代入と同様に、`when` 節でもパターンマッチ構文を使用することができます。
したがって、以下のように書くことができます。

```kinx
var obj = { x: 10, y: 20, z: { a: 100, b: 200 } };
case obj
when { x: vx, y: vy, z: { a: 100, b: 2000 } }: {
    System.println("Pattern 1 - %d %d" % vx % vy);
} when { x: vx, y: vy, z: { a: 100, b: 200 } }: {
    System.println("Pattern 2 - %d %d" % vx % vy);
};
```

```console
Pattern 2 - 10 20
```

パターンマッチに関する詳細は「\\nameref{分割代入とパターンマッチ}」に記載されていますので、そちらも合わせてご参照ください。

### ピン演算子

`case-when` はパターンマッチ構文を使うため、代入の代わりに値をチェックするためにはピン演算子である `^` を使う必要があります。

```kinx
var y = 20;
case y
when 1..10: System.println(y)
when v: System.println(v*2)
    // the above `when` condition does NOT mean `y equals v`.
    // it means `y is assigned to the variable v`.
    // as a result, this condition will match to any y value.
;
```

以下は `y` と `v` が等しいかどうかを確認するために、ピン演算子 `^` を使用した例です。

```kinx
var v = 15;
var y = 20;
case y
when 1..10: System.println(y)
when ^v:    System.println(v*2)     // v is not an lvalue, just check it.
when v:     System.println(v*10)    // v is matched to any value.
;
```

```console
200
```

<pagebreak />

### `if` 修飾子

ピン演算子の代わりに `if` 修飾子を使って値のチェックもできます。
以下の例は、`y` と `v` が等しいかどうかを確認するために `if` 修飾子を使った例です。

```kinx
var v = 15;
var y = 20;
case y
when 1..10:         System.println(y)
when m if (m == v): System.println(m*2)     // m is always matched,
                                            // but failed because of m != v.
when m:             System.println(m*10)    // m is matched to any value.
;
```

```console
200
```

### 選択パターン（Alternative Pattern）

`when` 節には複数の条件を書くことができ、これを選択パターン（Alternative Pattern）と呼びます。
各パターンは `|` で区切られます。
この `|` 区切りは一種の短絡演算子で、ある条件にマッチした後、後続の条件へのマッチ処理は行われません。

```kinx
case n
when 1 | 2 | 3: System.println(n)
;
```

もちろん、配列やオブジェクトでも利用可能です。

```kinx
function test(n) {
    case [n]
    when [1] | [2] | [3]: System.println(n * 100)
    when [v]: System.println(v)
    ;
}
test(1);
test(2);
test(3);
test(10);
```

```console
100
200
300
10
```

### When 条件での関数呼出

`when` 条件に簡易表記形式の関数オブジェクトを直接そのまま配置することもできます。
この時、条件となる値を引数として各関数を呼出し、関数が true を返した場合、その `when` 節の本体を実行します。

```kinx
function test(n) {
    case n
    when { => _1.isInteger }: System.println("%d is Integer" % n)
    when { => _1.isDouble }:  System.println("%f is Double" % n)
    when { => _1.isString }:  System.println("%s is String" % n)
    ;
}
test(10);
test(10.0);
test("10.0");
```

```console
10 is Integer
10.000000 is Double
10.0 is String
```

なお、簡易表記形式ではない関数オブジェクトの場合、`(` と `)` で括る必要があります。
そうしなかった場合、コンパイルエラーとなりますのでご注意ください。

```kinx
function test(n) {
    case n
    when (&() => _1.isInteger): System.println("%d is Integer" % n)
    when (&() => _1.isDouble):  System.println("%f is Double" % n)
    when (&() => _1.isString):  System.println("%s is String" % n)
    ;
}
test(10);
test(10.0);
test("10.0");
```
