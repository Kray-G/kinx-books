
# 関数・クロージャ・ファイバー
## 関数

### 関数とは

コードを共有するために、昔から関数が使われてきました。
関数は、いくつかの引数を受け取り、何らかの処理を行い、結果を返す、という動作をします。
このように、複数の文を纏めることによって処理の再利用を可能にするものが関数です。

```kinx
function add(a, b) {
    return a + b;
}
System.println(add(1, 2));
System.println(add(3, 4));  // 再利用
System.println(add(5, 6));  // 再利用
System.println(add(7, 8));  // 再利用
```

```console
3
7
11
15
```

### レスト演算子

関数は JavaScript のように最後の引数にだけレスト演算子を使うことができます。
これは可変引数の場合に便利です。

```kinx
function toArrayAdd3(...a) {
    var b = [...a]; // copy
    return b + [3];
}
toArrayAdd3(1, 2).each { => System.println(_1) };
```

```console
1
2
3
```

### 再帰呼出

再帰呼出も可能ですが、末尾再帰の最適化は未サポートです。

```kinx
function fib(n) {
    if (n < 3) return n;
    return fib(n-2) + fib(n-1);
}

System.println("fib(34) = ", fib(34));
```

```console
fib(34) = 9227465
```

### 引数

引数に、宣言文や代入文と同じ分割代入のスタイルを利用できます。
次の 3 つのスタイルが利用可能です。

* 配列スタイル
  * 配列内の各要素が順に変数に代入されます。
* オブジェクト・スタイル
  * 各値は、各キーにバインドされた変数に代入されます。
  * 省略記法で書いた場合、キー名と同名の変数に代入されます。

```kinx
function func([a, b, , ...c], { x, y }, { x: d, y: { a: e, b: f } }) {
    System.println("a = ", a);
    System.println("b = ", b);
    System.println("c = ", c);
    System.println("d = ", d);
    System.println("e = ", e);
    System.println("f = ", f);
    System.println("x = ", x);
    System.println("y = ", y);
}
func([1, 2, 3, 4, 5, 6], { x: 10, y: 100 }, { x: 20, y: { a: 30, b: 300 } });
```

```console
a = 1
b = 2
c = [4, 5, 6]
d = 20
e = 30
f = 300
x = 10
y = 100
```

### パターンマッチ

代入や宣言と同様に、引数でもパターンマッチが可能です。
変数の一部がリテラルの場合、引数とそのリテラルが同じかどうかがチェックされます。
結果、パターンマッチに失敗すると、`NoMatchingPatternException` 例外が送出されます。

```kinx
function func([a, b, , ...c], { x, y }, { x: d, y: { a: e, b: 300 } }) {
    System.println("a = ", a);
    System.println("b = ", b);
    System.println("c = ", c);
    System.println("d = ", d);
    System.println("e = ", e);
    System.println("x = ", x);
    System.println("y = ", y);
}
func([1, 2, 3, 4, 5, 6], { x: 10, y: 100 }, { x: 20, y: { a: 30, b: 300 } });
func([1, 2, 3, 4, 5, 6], { x: 10, y: 100 }, { x: 20, y: { a: 30, b: 3 } });
```

```console
a = 1
b = 2
c = [4, 5, 6]
d = 20
e = 30
x = 10
y = 100
Uncaught exception: No one catch the exception.
NoMatchingPatternException: Pattern not matched
Stack Trace Information:
        at function func(test.kx:1)
        at <main-block>(test.kx:11)
```

### 無名関数

無形関数は式内に直接記述することができ、関数の引数にすることもできます。

```kinx
var calc = function(func, a, b) {
    return func(a, b);
};
System.println(calc(function(a, b) { return a + b; }, 2, 3));
```

```console
5
```

関数が `return` 文だけの簡単なものであった場合、以下のように書くこともできます。
これらは全て同じです。

```kinx
System.println(calc(function(a, b) { return a + b; }, 2, 3));
System.println(calc(&(a, b) => a + b, 2, 3));
System.println(calc({ &(a, b) => a + b }, 2, 3));
System.println(calc({ => _1 + _2 }, 2, 3));
```

### `native` 関数

キーワード `native` は、ネイティブのマシンコードにコンパイルしたいときに使われる関数定義のスタイルです。
そのためには `function` キーワードの代わりに `native` キーワードを書けばいいのです。

```kinx
native fib(n) {
    if (n < 3) return n;
    return fib(n-2) + fib(n-1);
}
```

#### サポート機能と制限事項

非常に高速ですが、いくつかの制限があります。

* 型について
    * すべての変数は型として定義されます。利用可能な型は `int`, `big`, `dbl`, `str`, `bin`, `obj`, `int[]`, `dbl[]`, `native` です。
    * 型情報が省略された場合、型は次のようになります。
        * 引数を取ると自動的に `int` になります。
        * 宣言時にイニシャライザがない場合、自動的に `int` となります。
        * 宣言時にイニシャライザがある場合、右辺の結果で決定されます。
            * 判断できない場合は、コンパイルエラーになります。
    * `int`
        * 整数値は自動的に大きな整数に昇格することは **ありません** 。
        * `Math.pow(2, 10)` や `2.pow(10)` などの数学関数がサポートされています。
    * `big`
        * `BigInteger` 型としてサポートされていますが、多少の注意点があります。使用する際には注意してください。
            * この型は、たとえそれが 1 のような小さな整数であっても、すべての値を Big Integer として使用します。
                そのため、場合によっては VM 実行に比べてパフォーマンスが大幅に低下する可能性があります。
            * ネイティブ・コードは、大きな整数を計算する際に、非常に多くの Big Integer オブジェクトを生成します。
            現在の設計では、これらのオブジェクトはネイティブ実行中に GC によって収集されません。
            大きな整数のすべてのオブジェクトは、VM 実行に戻った後に収集されます。
            これは、非常に多くのメモリを使用することを意味し、パフォーマンスは非常に遅くなる可能性があります。
            * 例えば、再帰的なフィボナッチ計算のようなネイティブ関数では、Big Integer を **使うべきではありません**。
    * `dbl`
        * `Math.pow(2.0, 10.0)` や `2.0.pow(10.0)` などの数学関数がサポートされています。
    * `str`
        * `str` は、2つの文字列の加算と、文字列と整数の乗算のみサポートしています。
    * `bin`
        * バイトの配列としてサポートされています。
    * `int[]` と `dbl[]`
        * 現在は、整数または倍数の配列のみサポートしています。
    * `native`
        * `native` 関数の戻り値の型は `native funcname(arg):int` のように表示されます。
        * この場合でも、戻り値の型として `:int` を省略し、自動的に `int` とすることができます。
* 関数呼び出しについて
    * スクリプト関数を呼び出すことはできません。ネイティブ関数のみ呼び出し可能です。
* 文と式について
    * 例外と `try-catch-finally` はサポートされていますが、スタックトレースは利用できません。
    * `switch-case` と `switch-when` はサポートされていますが、ケースラベルは整数値か式でなければなりません。
    * レキシカル・スコープと変数は利用可能ですが、型を明確にする必要があります。
        * 型を省略した場合は、`int` を想定します。
        * 型が不一致の場合、実行時例外が発生します。
* 対応プラットフォーム
    * 64bit のみサポートしています。
    * ライブラリは x64、ARM、MIPS に対応していますが、x64 の Windows および Linux 以外ではテストしていません。

## クロージャ

### クロージャとは

クロージャとはレキシカル・スコープを持つ関数オブジェクトです。
レキシカル・スコープの変数は外側からは隠されています。
その変数はクロージャに束縛されており、それぞれのクロージャで独立して存在しています。
例えば、以下はクロージャの有名な例の一つです。

```kinx
function newCounter() {
    var i = 0;          // a lexical variable.

    return function() { // an anonymous function.
        ++i;            // a reference to a lexical variable.
        return i;
    };
}

var c1 = newCounter();
System.println(c1());
System.println(c1());
System.println(c1());
System.println(c1());
System.println(c1());
```

```console
1
2
3
4
5
```

### 変数の束縛

ここで、上記の関数オブジェクトを 2 つ用意して、「束縛」を見てみましょう。
なお、ここでの `newCounter` は上記と同様です。

```kinx
var c1 = newCounter();
var c2 = newCounter();
System.println(c1());
System.println(c1());
System.println(c1());
System.println(c1());
System.println(c2());   // 別のクロージャ
System.println(c2());   // 別のクロージャ
System.println(c1());
```

```console
1
2
3
4
1
2
5
```

ご覧の通り、`c1` は `c2` と異なる関数オブジェクトであるため、`c1` と `c2` で復帰値が 異なっています。
つまり、別の関数オブジェクトに束縛された変数 `i` 自体も異なっているということです。
そのため、`i` の各値がそれぞれ独立してインクリメントされているのです。
これが、まさにクロージャの特徴です。

## ファイバー
### ファイバーとは

ファイバーは軽量スレッドと呼ばれ、スレッドと似ていますが、スレッドがプリエンプティブ・マルチタスクであるのに対し、ファイバーは協調型マルチタスクを採用しています。
つまり、ファイバーは、実行中に他のファイバーを実行するために自分をゆずるのです。
ファイバーを利用すると、`yield` 文で処理を中断し、`resume` メソッドで再び処理を再開することができます。
なお、`yield` は文ですが、`resume` は `Fiber` クラスのメソッドです。

ファイバーは一般的に、同期操作としてスピンロックやアトミック操作が不要なので、スレッドよりも使いやすいと言われています．
一方で、ファイバーは基本的にシングルスレッドでの協調動作モデルであるため、マルチプロセッサをうまく活用できません．

### `Fiber` クラス

`Fiber` クラスがファイバーを扱う中心となります。
`Fiber` クラスのコンストラクタに関数を渡すことで、ファイバーを作成することができます。
次のコードは、ファイバーがどのように動作するかを示す例です。

```kinx
var fiber = new Fiber {
    System.println("fiber 1");
    yield;
    System.println("fiber 2");
};

System.println("main 1");
fiber.resume();
System.println("main 2");
fiber.resume();
System.println("main 3");
```

```console
main 1
fiber 1
main 2
fiber 2
main 3
```

`yield` は値を返すことも可能であり、`resume()` された時に値を受け取ることも可能です。
`yield` の詳細については「\\nameref{`yield`}」を参照してください。

### ファイバーの例

#### フィボナッチ数列

フィボナッチ数列は、無限ループで `yield` する例です。
`while` 内部で `yield` し、処理を呼び出し元に戻します。
その後、再度 `resume()` でファイバー側に処理が戻り、`yield` した次の文（ステートメント）から再開します。


```kinx
var fib = new Fiber {
    var a = 0, b = 1;
    while (true) {
        yield b;
        [a, b] = [b, a + b];
    }
};

var r = 10.times().map { &(i) => fib.resume() };
r.each { &(v, i) => System.println("fibonacci[%2d] = %4d" % i % v) };
```

```console
fibonacci[ 0] =    1
fibonacci[ 1] =    1
fibonacci[ 2] =    2
fibonacci[ 3] =    3
fibonacci[ 4] =    5
fibonacci[ 5] =    8
fibonacci[ 6] =   13
fibonacci[ 7] =   21
fibonacci[ 8] =   34
fibonacci[ 9] =   55
```

#### 関数呼び出しとファイバー

ファイバーはスタック状態を保持します。
したがって、ファイバーの中で関数呼び出しを行い、その中から `yield` することもできます。

```kinx
function enum2gen(enumArray) {
    return new Fiber {
        enumArray.each { &(i)
            yield i;
        };
    };
}

var g = enum2gen(100.times().map(&(i) => i+1));

System.println(g.resume());
System.println(g.resume());
System.println(g.resume());
```

```console
1
2
3
```
