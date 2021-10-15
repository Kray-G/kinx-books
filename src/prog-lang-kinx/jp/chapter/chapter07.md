
# クラス・モジュール・名前空間

## クラス

### クラスとは

クラスとは、データと手続きのセットのことです。
Kinxはプロトタイプベースの言語ですが、オブジェクトの形状を定義するために、`class`キーワードが用意されています。

### 基本スタイル

クラスの定義は、基本的には「引数がある場合」と「引数がない場合」があります。

```kinx
class A { /* ... */ }
class A() { /* ... */ }
class A(a, b) { /* ... */ }
```

上記の場合、`class A` は `class A()` と同じ意味です。

### 継承

クラスの継承には ''`:`'' が使われます。
継承のための引数も単純なクラス定義と同じで、引数が無い場合には引数リストを省略することができます。
継承の例を以下に示します。

```kinx
class A : B { /* ... */ }
class A() : B { /* ... */ }
class A : B(true) { /* ... */ }
class A(a, b) : B(b) { /* ... */ }
```

### インスタンス化

クラスオブジェクトは `new` 演算子によってインスタンス化されます。
オブジェクトをインスタンス化する際には、`new ClassName()` のような関数呼び出しスタイルを使わなければなりません。
つまり、`new ClassName` だけでは意味をなしません。

```kinx
class A { /* ... */ }
var a = new A();
```

### `this` と `@` キーワード

キーワードの `this` は、インスタンスそのものを意味します。

```kinx
class A {
    public flagOnAlt() {
        this.flagOn();
    }
    public flagOn() {
        this.flag = true;
    }
}
```

また、''`this.`''（`this` + ドット）の代わりに ''`@`'' を使うこともできます。
これにより、上記のコードの代わりに以下のように書くこともできます。

```kinx
class A {
    public flagOnAlt() {
        @flagOn();
    }
    public flagOn() {
        @flag = true;
    }
}
```

### データ

##### プライベート・データとパブリック・データ

クラスのスコープで宣言された変数は、ローカルなプライベート変数です。
一方 `this` のプロパティはパブリック変数です。

```kinx
class A {
    var flag_ = false;  // ローカルなプライベート変数
    public flagOn() {
        @flagOnActual();
    }
    public flagOnActual() {
        @flag = true;   // パブリック変数
    }
}

var a = new A();
a.flagOn();
System.println(a.flag ? "true" : "false");
```

```console
true
```

### メソッド

メソッドは `public` および `private` キーワードと共に定義されます。
`private` で定義されたメソッドは、ローカルなクラス・スコープの中だけで使われます。
一方、`public` で定義されたメソッドは、インスタンスのプロパティとしてアクセス可能です。

```kinx
class A {
    private method1() {
        /* ... */
    }
    public method2() {
        method1();  // Okay. `method1` はクラス内で参照可能。
        /* ... */
    }
    private method3() {
        method2();  // `method2` もクラス内で参照可能。
        @method2(); // `method2` は `this` を通しての参照も可能。
    }
}

var a = new A();
// a.method1();     // Error. `method1` はインスタンスを通して参照不可能。
a.method2();        // Okay. `method2` はインスタンスを通して参照可能。
```

### 特別なメソッド

`class` キーワードはいくつかの特別なメソッドを定義します。

##### `initialize`

`initialize` メソッドが定義されている場合は、インスタンス化された直後に自動的に呼び出されます。
`initialize` メソッドは `public` および `private` どちらで定義しても構いません。

```kinx
class A {
    private initialize() {
        System.println("called");
    }
}

var a = new A();
```

```console
called
```

##### `instanceOf`

クラスのインスタンスは，自動的に `instanceOf` メソッドを持っています。
このメソッドはクラス名を変数として受け取り、対象となるオブジェクトが指定されたクラスや基底クラスのインスタンスであれば、trueを返します。

```kinx
class C {};
class B {};
class A : B {};

var a = new A();
System.println(a.instanceOf(A) ? "true" : "false");
System.println(a.instanceOf(B) ? "true" : "false");
System.println(a.instanceOf(C) ? "true" : "false");
```

```console
true
true
false
```

## モジュール

### モジュールとは

モジュールは、クラスの機能を拡張するために使用されます。
これは通常、異なる種類のクラスにまたがる共通の機能のために使用されます。

### 基本スタイル

モジュールを定義する方法は、基本的に以下の通りです。

```kinx
module M { 
    /* ... Defines a public method
        to extend a host class which this is mixined into. */
}
```

### ミックスイン

モジュールは `mixin` キーワードでクラスにミックスインされます。

```kinx
class A {
    mixin M;
    /* ... */
}
```

`mixin` は以下のように複数のモジュールを指定することができます。

```kinx
class A {
    mixin M1, M2, M3;
    /* ... */
}
```

### クラスの拡張

モジュールをクラスにミックスインすることで、そのモジュールで定義されたメソッドがクラスに追加されます。
例えば、`method1` メソッドを持つモジュール `M` を `A` のクラスに組み込んだ場合、`A` も `method1` メソッドを持ち、使用することができます。
このとき、`method1` メソッドは `public` メソッドでなければならないことに注意してください。

```kinx
module M {
    public method1() {
        System.println("This is a method1");
    }
}

class A {
    mixin M;
}

new A().method1();
```

```console
This is a method1
```

## 名前空間

### 名前空間とは

キーワード `namespace` で定義される名前空間は、クラスやモジュールなどを保持するスコープであり、オブジェクトです。
例えば、クラス名は名前空間オブジェクトのプロパティとなります。

### 名前空間の定義

名前空間はキーワード `namespace` を使って、以下のように定義して使用できます。

```kinx
namespace A {
    class X {
        private initialize() {
            System.println("X was instanciated.");
        }
    }
}
var x = new A.X();
```

```console
X was instanciated.
```

名前空間は入れ子にすることができます。
あるネームスペースを別のネームスペースに入れることができます。

```kinx
namespace A {
    namespace B {
        class X {
            private initialize() {
                System.println("X was instanciated.");
            }
        }
    }
    var x = new B.X();
}
var x = new A.B.X();
```

```console
X was instanciated.
X was instanciated.
```

## 演算子オーバーライド

### 演算子オーバーライドとは

オブジェクトに対する演算子の挙動を上書きすることを言います。
演算子がクラスに属しているメソッドと考えれば「オーバーライド」となり、クラスに属さないと考えると「オーバーロード」となるイメージですが、
ここでは Ruby のように演算子はクラス・オブジェクトへのメッセージであり、クラスに属しているイメージで考え、
そのクラス・メソッドを上書きする形を表現して「オーバーライド」で統一しておきます[^overload]。

[^overload]: C++ の演算子オーバーロードは演算子の多重定義を意味します。
クラス・メソッドではなく、同じ名前の関数（や演算子）でも、その引数の違いによって呼び出される関数が区別される機能のことです。

### 基本形

オーバーライド可能な演算子の種類は以下の通りです。

* `==`、`!=`、`>`、`>=`、`<`、`<=`、`<=>`、`<<`、`>>`、`+`、`-`、`*`、`/`、`%`、`[]`、`()`.

例として、`+` 演算子をオーバーライドしてみましょう。
関数名を演算子名の `+` とするだけです。
他の演算子でも同じです。

```kinx
class Sample(value_) {
    @isSample = true;
    @value = value_;
    public +(rhs) {
        if (rhs.isSample) {
            return new Sample(value_ + rhs.value);
        }
        return new Sample(value_ + rhs);
    }
}
```

`rhs` として渡されるものは、適宜想定するコンテキストに合わせて場合分けして実装する必要があります。
先の例のように実装すると、以下のように使えるようになります。

```kinx
var s1 = new Sample(10);
var s2 = s1 + 100;
s1 += 1100;
System.println(s1.value);  // => 1110
System.println(s2.value);  // => 110
```

`a += b` も内部的には `a = a + b` に展開されるので正しく動作します。
尚、オブジェクトに対するメソッド呼び出しなので、次のようにも書けます。

```kinx
var s1 = new Sample(10);
var s2 = s1.+(100);
System.println(s2.value);  // => 110
```

基本的に、`[]` 演算子と `()` 演算子以外の右辺値を取る演算子は、同様の動作をします。

### `[]` 演算子

`[]` はインデックス要素的なアクセスを許可します。
ただし、インデックスには整数（Integer）かオブジェクト、または配列しか使えません。
実数（Double）は動作しますが引数には整数（Integer）で渡されます。
文字列は、プロパティ・アクセスと同じであり、無限ループする可能性があるため使えません。

実際に、例えば `Range` には実装されており、以下のようなアクセスが可能です。

```kinx
System.println((2..10)[1]);
System.println(('b'..'z')[1]);
```

```console
3
c
```

以下のように、関数呼び出しのように直接 `[]` 演算子を書いても、同じ結果が得られます。

```kinx
System.println((2..10).[](1));
System.println(('b'..'z').[](1));
```

```console
3
c
```

### `()` 演算子

`()` 演算子はオブジェクトに直接作用します。
C++ のファンクタ（`operator()` を定義したクラス）のような振る舞いをします。
例えば以下のようにクラス・インスタンスを関数のように見立てて直接 `()` 演算子を適用できます。

```kinx
class Functor {
    public ()(...a) {
        return System.println(a);
    }
}

var f = new Functor();
f(1, 2, 3, 4, 5, 6, 7);
```

```console
[1, 2, 3, 4, 5, 6, 7]
```

メソッド呼び出し風に書くと以下と同じです。

```kinx
var f = new Functor();
f.()(1, 2, 3, 4, 5, 6, 7);
```

```console
[1, 2, 3, 4, 5, 6, 7]
```

