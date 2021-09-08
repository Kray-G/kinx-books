
# Namespace, Class, and Module
## Namespace

### Namespace Object

Using the keyword of `namespace`, you can use a namespace.

The namespace is an **object**, and the clases or modules declared in a namespace will be added to the namespace object.
However, the constant value is not added to the namespace automatically, you have to define and add it yourself.

```javascript
namespace N {
    class A {
        ...
    }

    const X = 10;
    N.X = 100;

    var a = new A(); // OK
    ...
}

// var a = new A(); // error
var a = new N.A(); // OK

// System.println(X); // error
System.println(N.X); // OK
```

Namespaces can be nested.

```javascript
namespace A {
namespace B {

    class X { ... }

} // namespace B

    var x = new B.X(); // OK

} // namespace A

var x = new A.B.X(); // OK
```

## Class
### What is Class?
### Class Definition
### Sub Class and Inheritance

## Module
### What is Module?
### Module Definition
### Min-in

## Operator Override

### What is Operator Override?

It is to overwite the behavior of operators for Object.
The image of the Override means, when you think the operator belongs to the class, it should be called as **Override**, but otherwise, it should be called as **Overload**.
In the Kinx, the operators are belonging to the class, as well as Ruby, and it is an message to the class, so it means the class methods are overwritten and we called it **Override**[^overload].

[^overload]: The overload in C++ means a multiple definition of operators.
It is not a class method, and is a mechanism to choose which function should be called depended on the differences between arguments.

### Basic Style

The operators which can be overrided is as follows.

* `==`、`!=`、`>`、`>=`、`<`、`<=`、`<=>`、`<<`、`>>`、`+`、`-`、`*`、`/`、`%`、`[]`、`()`.

For example, let\\apos{}s override the `+` operator.
You just write `+` of an  operator name as a function name.
It should be the same for another operator.

```javascript
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

As for the argument of `rhs`, it have to be implemented suited by assumpted context.
If you implemented above, you could use it as the following.

```javascript
var s1 = new Sample(10);
var s2 = s1 + 100;
s1 += 1100;
System.println(s1.value);  // => 1110
System.println(s2.value);  // => 110
```

It works well because `a += b` is the same as `a = a + b` internally.
By the way, it can be written below because it is exactly a function call to Object.

```javascript
var s1 = new Sample(10);
var s2 = s1.+(100);
System.println(s2.value);  // => 110
```

Basically, almost all operators except `[]` and `()` operator should work as well.

### `[]` Operator

`[]` means an index access.
But the index value will be only Integer, Array, or Object.
If it is Double as a real number, the argument will be passed as converted to Integer.
String is not available because it is absolutely same as a property access and it could be infinate loop.

In fact, for example, it is implemented in `Range` and you can access as follows.

```javascript
System.println((2..10)[1]);
System.println(('b'..'z')[1]);
```

```console
3
c
```

When writing `[]` operator as a function call, use it below.

```javascript
System.println((2..10).[](1));     // => 3
System.println(('b'..'z').[](1));  // => 'c'
```

### `()` Operator

`()` operator directly has an influence to Object.
This behaves like a functor, which is the class including `operator()`, in C++.
For example, you can directly use the `()` to the class instance like a function call.

```javascript
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

It is the same as below if you write it as a function call.

```javascript
var f = new Functor();
f.()(1, 2, 3, 4, 5, 6, 7);
```

```console
[1, 2, 3, 4, 5, 6, 7]
```

