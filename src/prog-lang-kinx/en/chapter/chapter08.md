
# Type Annotation

A part of this feature is implemented experimental in nature.
If you met a case where it does not work correctly, please use the issue form below to let us know the phenomenon, condition, and the minimum code to reproduce it.

* https://github.com/Kray-G/kinx/issues

## Objectives and Types

### Objectives of Type Annotation

Type annotation is used for the following purposes.

* Type annotation in `native` functions.
* Type checking before execution.
* Type checking at runtime.

In `native` functions, type annotation are **mandatory**,
i.e., they are treated as necessary information for pre-compilation.
Kinx does not support JIT compilation of general script code,
but it does support JIT compilation of `native` functions.
In that case, type information is treated as mandatory information.
However, auto-conversion in `native` function will be performed as long as possible.

Any other type annotation will be used for type checking before execution, or at runtime.
The assignment to the different type will be error, although it is different from `native` function.
Instead, an actual conversion will not be done even if passing the type check
Since this is a dynamically typed language, type checking is performed in a so-called **best-effort** fashion.

### Types in Kinx

Here are types which Kinx uses.

<context label="Table:KinxTypesInTypeAnnotation"/>
<context caption="Types used in Type Annotation"/>

| Type  |                          Outline                           |
| :---: | ---------------------------------------------------------- |
| `int` | Means a 64 bit Integer.                                    |
| `big` | Means a Big Integer.                                       |
| `dbl` | Means a real number as double.                             |
| `str` | Means a string.                                            |
| `bin` | Means a byte array.                                        |
| `[]`  | Using the shape of `int[]`, it means an array of the type. |

## How To Specify the Type

The type annotation is basically a **postfix expression**.
It is shown by the shape of `:` plus type following the target.
For example, it is `:int`.
Let's look at a concrete case.

### Type for Variable

For variables, it is specified at declaration for each.
For example, it shows an error before execution at assignment to `c` if doing below.

```kinx
var a:int, b:int, c:dbl;
[a, b, c] = [10, 20, 30];
System.println([a, b, c]);
```

```console
Error: Type mismatch for (c) in assignment (dbl, int) near the <test.kx>:2
```

If a value matches a type, it works correctly.

```kinx
var a:int, b:int, c:dbl;
[a, b, c] = [10, 20, 30.0];
System.println([a, b, c]);
```

```console
[10, 20, 30]
```

An assignment can be also used directly with declaration.

```kinx
var a:int = 10, b:int = 20, c:dbl = 30.0;
System.println([a, b, c]);
```

```console
[10, 20, 30]
```

### Type for Argument and Return Value

Types can also be specified for function arguments and return values.
However, type checking before execution is not implemented for normal functions at this time. Please be aware of this. The following behavior is only supported.

* When specified in a `native` function, runtime type checking is performed.
* The type of the return value is checked before execution when it is assigned to a variable, etc.

In the case of a function argument, also specify it in the form of `:` plus type after the target argument.
The return value is also placed after the declaration list and before the block of the function body.
Let's look at the following example.

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

In the current implementation, the type annotation of arguments in a normal function defined by `function` is ignored.
However, since the type of the return value is `dbl`, the type of the variable `d` is automatically recognized as `dbl`.
If you try to specify `d` as `int`, an error will occur before execution.

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

On the other hand, the `native` function checks the type of arguments at runtime.
Since it is a runtime check, types that can be converted will be automatically converted.
For example, in the following example, `int` is automatically converted to `dbl`.

```kinx
native func(a:int, b:int, c:dbl) :dbl {
    return a + b + c;
}
System.println(func(10, 20, 30));
```

```console
60
```

The opposite side conversion from `dbl` to `int` will result in an error, as shown in the example below.
In this case, the type conversion at runtime will fail and a runtime exception will be thrown.

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

### Explicit Type Conversion

You can use the keyword of `as` for explicit type conversion.
However, the basic conversion like `int` and `dbl` will be automatically done.
For example, it works well even with nothing special as below.

```kinx
native func(a:dbl):int {
    return a + 1;
}
System.println(func(10.1));
```

```console
11
```

In other cases, for example, you want to use `str` for `dbl`, you need to specify explicitly it as below.
The variable `a` will be `str`, and the calculation of `"10.1" + 1` will be done.
In this case, `1` as `int` is automatically converted to `str`, and the result is `"10.11"` by connecting between strings.
By the way, the variable `b` is automatically recognized as `str` by the type of right operand.

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
