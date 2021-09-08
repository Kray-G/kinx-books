
# Let\\apos{}s Get Started
## Installation and Uninstallation
### Installation

#### Windows

You can use scoop for the installation on Windows.

```console
// scoop bucket add is needed only at the first time.
$ scoop bucket add kinx https://github.com/Kray-G/kinx
$ scoop install kinx
```

Registration of Bucket is needed once before installation.
After Kinx has been installed, let\\apos{}s show the version of Kinx to check if the path works.

```console
$ kinx.exe -v
kinx.exe version 1.1.0 built on 4b2bd84d86fc4e30a78fffbf84805158dc097193
```

After seeing the path works,
do the following command to get availbale the path of a package command in the package which may be installed in the future.

```console
$ kinx --install-path
```

That is all to finish the preparation.

#### Linux(Ubuntu)

Install Kinx by the Kinx installer on Linux(Ubuntu).
First of all, download a `.deb` file from the [Relases](https://github.com/Kray-G/kinx/releases) page[^releasefile]。
Next, move to the directory where you download it, and install it as below.

[^releasefile]: The file name includes a version number. Please download the file of the version you need.

```console
$ sudo apt install ./kinx_1.1.0-0_amd64.deb
```

After Kinx has been installed, let\\apos{}s show the version of Kinx to check if the path works correctly.

```console
$ kinx -v
kinx version 1.1.0 built on 4b2bd84d86fc4e30a78fffbf84805158dc097193
```

That is all to finish the preparation.

### Uninstallation

#### Windows

Do the following to uninstall Kinx from Windows.

```console
$ scoop uninstall kinx
```

Do it, and all components of Kinx including all packages are removed.
If you want to remove the Bucket, do the following.

```console
$ scoop bucket rm kinx
```

By this, the Bucket is also removed.
If you want to register the Bucket again, do `scoop bucket add` command to register it.

#### Linux

The way to uninstall Kinx from Linux, do the following.

```console
$ sudo apt remove kinx
```

By this, Kinx itself and all of Kinx packages are removed.

## Execute Kinx
### How to Execute

Do the following to execute Kinx.

```console
$ kinx [options] <kinx-file>.kx
```

The standard extension of Kinx is `.kx`, but the executable does not care about the extension.
You can execute the script file with any extension.

### Command Line Arguments

The following arguments for a command line are available.

<context label="Table:KinxCommandLineArguments"/>
<context caption="Command Line Arguments"/>
<context limit-column="0"/>

|     Option      |                              Meaning                               |
| --------------- | ------------------------------------------------------------------ |
| `-h`            | Display the help.                                                  |
| `-c`            | Syntax check only. No execute.                                     |
| `-d`            | Display IR code. No execute.                                       |
| `-D`            | Display AST. No execute.                                           |
| `-u`            | Without converting to/from UTF8 in a standard I/O. Windows only.   |
| `-q`            | No messages when compiling.                                        |
| `-i`            | Input a source code from stdin.                                    |
| `-v`            | Display the version as a short description.                        |
| `--version`     | Display the version with details.                                  |
| `--debug`       | Execute it in the debugger mode.                                   |
| `--dot`         | Output IR code as `.dot` style.                                    |
| `--with-native` | Using it with `-d`, display an assembly code of `native` function. |

Debugger will be run when you run it in the debugger mode.
See ''\\nameref{Debugger}'' about Debugger.
Besides, regarding `--with-native` option, see ''\\nameref{`native` Function}'' and you can find a part of explanation.

### hello, world.

Let\\apos{}s write the script of `hello, world.`, which everybody will write first.
Write the following content, and save it as the file name of `hello.kx`.

```kinx:hello.kx
System.println("hello, world.");
```

Let\\apos{}s get started to execute it.

```console
$ kinx hello.kx
hello, world.
```

As you can see, there is no need for any complicated or cumbersome setup code because Kinx is a scripting language.
You can focus on what you want to do, and you can run and try it right away.

## Kinx Tour

To get whole of Kinx, let\\apos{}s start with a brief introduction to Kinx\\apos{}s features.
In each section, you will find a link to the explanation page of each feature.
If you want to check the details of a feature, please check the respective links.

### Program Structure

The program can be written in the top level context.
As you see earlier, the program of `hello, world.` was written in the top level context.

```kinx:hello.kx
System.println("hello, world.");
```

### Comment

As a comment, you can use both a C and C++ style and `#` of a Perl like style.

```javascript
/* Comment */
// Comment
```
```coffee
# Comment
```

You can use it as you like.

### Variable Declaration

`var` or `const` is used to declare variables.
It can have an initializer to initialize a variable.
If there is no initializer, the initial value of a variable is null.

```javascript
var a = 10;
const b = 100;
var c;
System.println([a, b, c]);
```

```console
[10, 100, null]
```

When using `const`, you can not assign a new value to the variable after declaration with compiling error.

```javascript
const b = 100;
b = 10;
```

```console
Error: Can not assign a value to the 'const' variable near the <test.kx>:2
```

As an assignment, you can use the way of a **deconstructing assignment**, or a **pattern matching assignment**.
Of course, it can be used at not only an assignment but also a declaration statement or arguments of a function.

```javascript
[a, b, , ...c] = [1, 2, 3, 4, 5, 6];
{ x, y } = { x: 20, y: { a: 30, b: 300 } };
{ x: d, y: { a: e, b: 300 } } = { x: 20, y: { a: 30, b: 300 } };
System.println([a, b, c, d, e, { x, y }]);
{ x: d, y: { a: e, b: 300 } } = { x: 20, y: { a: 30, b: 3 } };  // Exception occurs.
```

```console
[1, 2, [4, 5, 6], 20, 30, {"x":20,"y":{"a":30,"b":300}}]
Uncaught exception: No one catch the exception.
NoMatchingPatternException: Pattern not matched
Stack Trace Information:
        at <main-block>(test.kx:5)
```

There is an explanation in ''\\nameref{Deconstructing and Pattern Matching Assignment}'' about those.

### Basic Data Types

Kinx is a dynamically typed language but has a type inside.
The type inside can be checked by the following properties.

<context label="Table:KinxBasicType"/>
<context caption="Basic Types"/>
<context limit-column="0"/>

|    Property    |     Example      |                                 Meaning                                 |
| -------------- | :--------------: | ----------------------------------------------------------------------- |
| `.isUndefined` |       null       | Not initialized.                                                        |
| `.isInteger`   |    100, 0x02     | Integer number including Big Integer number.                            |
| `.isDouble`    |       1.5        | Real number. It is double precision.                                    |
| `.isString`    | `"aaa"`, `'bbb'` | String.                                                                 |
| `.isBinary`    |    `<1,2,3>`     | Array of a byte value. Each item is rounded by 0x00 to 0xFF.            |
| `.isArray`     | `[1,a,["aaa"]]`  | Array which can hold any types. Array will be also true for `isObject`. |
| `.isObject`    | `{ a: 1, b: x }` | Key Value structure like JSON.                                          |
| `.isFunction`  |  `function(){}`  | Function.                                                               |

`null` and `undefined` is exactly same in Kinx.
When the value is `null` or `undefined`, `.isUndefined` is true.
On the other hand, when the value is not `null` nor `undefined`, `.isDefined` is true.

There is a detail explanation in ''\\nameref{Data Types}'' about data types.

#### Boolean Class

`true` and `false` as a boolean literal is an alias of 1 or 0 as an integer in Kinx.
However, there is not a Boolean type but a Boolean class, and the constant value of `True` and `False` has been defined as the instance of the Boolean class.
When it were used in an expression, `True` would be evaluated as true, and `False` would be also evaluated as false.
If you really want to use a boolean type not as an integer, use it instead.

```javascript
System.println(True ? "true" : "false");
System.println(False ? "true" : "false");
```

```console
true
false
```

Moreover, when an integer number are passed to the constructor of the Boolean class, you can create a Boolean instance.
If the value were 0, the instance same as `False` would be created.
If the value were not 0, the instance same as `True` would be created.
You can use this, for example, when you want to show the `"true"` or `"false"` string.


```javascript
System.println(new Boolean(100));
System.println(new Boolean(0));
System.println(new Boolean(0.isInteger));
```

```console
true
false
true
```

### Array and Object

Internally, arrays and objects are the same in Kinx, and it can hold both values at the same time.
See ''\\nameref{Array}'' for Array, and see ''\\nameref{Object}'' for Object.

```javascript
var a = { a: 100 };
a.b = 1_000;
a["c"] = 10_000;
a[1] = 10;
System.println(a[1]);
System.println(a.a);
System.println(a.b);
System.println(a.c);
```

```console
10
100
1000
10000
```

### Expression and Statement

#### Expression

An expression is, **the thing which is evaluated and has a specific value**.
An expression is used to perform arithmetic operations, function calls, object manipulation, etc.
When the expression has been finally evaluated, the whole expression shows a specific value.
The value can also be assigned to a variable.

```javascript
// expression
z = 5 + (a * 2) + some(x)
```

The details of expressions are described in ''\\nameref{Expession and Operators}''.

#### Statement

On the other hand, a statement is a **procedure** and has no value.
A program is a set of statements, and expressions are used in the statements.

Besides, there are also two types of statement as an expression statement and a block statement.
As an expression statement, there are a declaration, an assignment, `continue`, `break`, `return`, `throw`, and `yield`.
The end of an expression statement needs a semi-colon of ''`;`''.
By the way, `if` block is the same as C syntax, and it is a dangling `else`.

```javascript
// Example of if
if (expression1) {
    return a;   // expression statement
} else if (expression2) {
    return b;
} else {
    return c;
}
```

See ''\\nameref{Statement and Flow Control} for the detail of a statement.

#### Block and Scope

A block creates a scope.
If there is a variable with the same name outside the scope, the variable will not be able to be referenced.
This is called *shadowing*.

```javascript
var a = 10;
{
    var a = 100;
    System.println(a);
}
System.println(a);
```

```console
100
10
```

### Function, Closure, and Fiber

You can use a function.
There are a normal function, a `native` function, a closure, a lambda, a method of class or module as a function.

#### Function and Closure

A function has a lexical scope, and you can use a closure.

```javascript
function func(x) {          // a regular function
    return &(y) => x + y;   // a lambda, returns a closure binding 'x'
}

var f = func(10);           // receiving a closure
System.println(f(20));      // => 30
```

```console
30
```

See ''\\nameref{Function}'' for a normal function and a `native` function.
About a closure, see ''\\nameref{Closure}''.
Besides, see ''\\nameref{Class}'' for a class method and see ''\\nameref{Module}'' for a module method.

#### Fiber (Coroutine)

You can use a coroutine by passing a function to the constructor of the class Fiber.
Fiber uses the `yield` statement for continuation, but this `yield` statement cannot be used in a normal function.
You can only use `yield` in the function in Fiber.
If you use `yield` outside of Fiber, a runtime error as exception will be thrown.

```javascript
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

See ''\\nameref{Fiber}'' about Fiber.

### Namespace, Class, and Module

You can use a namespace.
Moreover, you can define a class because Kinx is object oriented language.
One more thing, Module is introduced as a mechanism to add common functions later to a class by `mixin`.

```javascript
namespace NS {
    module X {
        public sayHello() {
            System.println("hello");
        }
    }
    class A {
        mixin X;
        private trySayHello() {
            @sayHello();
        }
        public doSayHello() {
            trySayHello();
        }
    }
}
var x = new NS.A();
x.doSayHello();   // => hello
```

```console
hello
```

See ''\\nameref{Namespace}'' for a namespace.
Besides, see ''\\nameref{Class}'' for a class, see ''\\nameref{Module}'' for a module.

### Simple Type Annotation

There is a simple type annotation feature in Kinx.
This is used for the purpose as follows.

* It is mandatory for `native` function whenever types except `int` is used.
* Only in the limited case, but it finds mismatches between types in compilation.

The followings is the example of `native` function.
The argument is Double, calculating with Double, and returning Double.

```javascript
native fibd(n : dbl) : dbl {
    return n if (n < 3);
    return fibd(n-2) + fibd(n-1);
}
System.println(fibd(34));
```

```console
9.22747e+06
```

See ''\\nameref{Type Annotation}'' for details.

### Libraries

Kinx provides useful libraries as an all-in-one package.
This is based on the consideration that a script language would be useful if a functionality which a user use very well were provided from the beginning.
It is like a *Batteries Included* in Python.

The libraries provided as an all-in-one are below.

* **Zip** ... Zip/Unzip with not only zip password but also AES password.
* **Xml** ... Supported XML DOM.
* **libCurl** ... Only HTTP has been already implemented.
* **SSH** ... Execute a command by login with SSH.
* **Socket** ... Simple TCP/UDP socket.
* **Iconv** ... Conversion between text encodings.
* **Database** ... Useful Database class with SQLite3.
* **Parser Combinator** ... Parser combinator named as `Parsek` and it is like `Parsec`.
* **PDF** ... PDF core library based on HaruPDF.
* **JIT** ... JIT library by abstracted assembler library which supports multiple platforms.

The standard library is described in ''\\nameref{Standard Library}''.
It is a very huge section, but it will be useful.

### Kinx Package System

Kinx includes a package system.
A package system is a useful system to add/remove a library which is not included in the standard, and to install the library which you need only.

The detail explanation of a package system is described in ''\\nameref{Package Management}''.
