
# 型アノテーション

本機能の一部は実験的な機能として実装されています。
したがって、正しく機能しないケースに遭遇した場合には、以下の Issue フォームから事象や条件、最小再現コードをご連絡いただければ幸いです。

* https://github.com/Kray-G/kinx/issues

## 目的と型の種類

### 型アノテーションの目的

型の指定は以下の目的で利用します。

* `native` 関数での型指定
* 実行前の型チェック
* 実行時の型チェック

`native` 関数では型指定は **必須** です。
これは事前コンパイルするために必要な情報として扱います。
Kinx の場合、一般的なスクリプト・コードの JIT コンパイルはサポートしていませんが、
`native` 関数の JIT コンパイルをサポートしています。
その際、型情報は必須情報として扱います。
ただし `native` 関数の場合、可能な限り自動的な型変換を試みます。

それ以外での型指定は、実行前の型チェック、または実行時の型チェックに使用されます。
`native` 関数とは異なり、基本的には異なる型への代入はエラーとして扱います。
代わりに、型チェックにパスしたとしても、実際の型変換は行われません。
動的型付け言語ですので、型チェックはいわゆる **ベストエフォート** の形で実施されます。

### Kinx での型

以下が Kinx で使用している型になります。

<context label="Table:KinxTypesInTypeAnnotation"/>
<context caption="型アノテーションで使用される型一覧"/>

|  型   |                        概要                        |
| :---: | -------------------------------------------------- |
| `int` | 64 bit 整数を示します。                            |
| `big` | BigInteger を示します。                            |
| `dbl` | 倍精度の実数を示します。                           |
| `str` | 文字列を示します。                                 |
| `bin` | バイト配列を示します。                             |
| `[]`  | `int[]` の形式で利用し、該当の型の配列を示します。 |

## 型指定の方法

型の指定は基本的に **後置表現** になります。
対象の後に、`:` + 型の形で示します。
例えば、`:int` のように指定します。
具体的なケースについて見ていきましょう。

### 変数の型

変数の場合、各変数ごとに宣言時に指定します。
例えば、以下のようにすると変数 `c` への代入で実行前エラーになります。

```kinx
var a:int, b:int, c:dbl;
[a, b, c] = [10, 20, 30];
System.println([a, b, c]);
```

```console
Error: Type mismatch for (c) in assignment (dbl, int) near the <test.kx>:2
```

値が型と合っていれば、正しく実行されます。

```kinx
var a:int, b:int, c:dbl;
[a, b, c] = [10, 20, 30.0];
System.println([a, b, c]);
```

```console
[10, 20, 30]
```

また、型の指定と同時に代入も可能です。

```kinx
var a:int = 10, b:int = 20, c:dbl = 30.0;
System.println([a, b, c]);
```

```console
[10, 20, 30]
```

### 関数引数と復帰値の型

関数引数と復帰値にも型指定が可能です。
ただし、現時点では通常の関数では実行前の型チェックは実装されていません。ご了承ください。以下の動作のみがサポートされています。

* `native` 関数で指定した際に実行時型チェックが行われます。
* 復帰値の型は変数への代入等の際に実行前型チェックが行われます。

関数の引数の場合も、対象の引数（変数）の後ろに `:` + 型の形で指定します。
また、復帰値は宣言リストの後、関数本体のブロックの前に置かれます。
次の例を見てみましょう。

```kinx
function func(a:int, b:int, c:dbl) :dbl {
    return a + b + c;
}
var d = func(10, 20, 30);
System.println(d);
```

```console
60
```

現在の実装では `function` で定義される通常関数での引数の型指定は無視されます。
ただし、復帰値の型が `dbl` であるため、変数 `d` の型が自動的に `dbl` と認識されます。
試しに `d` を `int` と指定すると実行前エラーとなります。

```kinx
function func(a:int, b:int, c:dbl) :dbl {
    return a + b + c;
}
var d:int = func(10, 20, 30);
System.println(d);
```

```console
Error: Type mismatch for (d) in assignment (int, dbl) near the <test.kx>:4
```

一方で、`native` 関数では引数の型を実行時にチェックします。
実行時チェックであるため、変換可能な型は自動変換されます。
例えば、以下の例では `int` から `dbl` への自動変換が行われます。

```kinx
native func(a:int, b:int, c:dbl) :dbl {
    return a + b + c;
}
System.println(func(10, 20, 30));
```

```console
60
```

以下の例のように、`dbl` から `int` への逆の変換はエラーとなります。
この場合、実行時型変換に失敗し、実行時例外が送出されます。

```kinx
native func(a:int, b:int, c:dbl) :dbl {
    return a + b + c;
}
System.println(func(10.0, 20.0, 30.0));
```

```console
Uncaught exception: No one catch the exception.
NativeFunctionException: Type mismatch
Stack Trace Information:
        at <main-block>(test.kx:4)
```

### 明示的な型変換

明示的な型変換のために `as` というキーワードが利用可能です。
ただし、基本的な `int` と `dbl` のような型変換は自動で行われます。
例えば、以下のようになにも指定しなくても正しく動作します。

```kinx
native func(a:dbl):int {
    return a + 1;
}
System.println(func(10.1));
```

```console
11
```

それ以外、例えば `dbl` を `str` として扱いたい場合、以下のように明示的に指定する必要があります。
変数 `a` は `str` となり、`"10.1" + 1` の計算が行われます。
この場合、`int` である `1` は自動的に `str` に型変換され、文字列同士の連結として `"10.11"` となります。
なお、変数 `b` は右辺の方により自動的に `str` と認識されます。

```kinx
native func(a:dbl):str {
    var b = a as str + 1;
    return a + "-" + b;
}
System.println(func(10.1));
```

```console
10.1-10.11
```




