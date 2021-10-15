
# Class, Module, and Namespace

## Class

### What is Class

A class is a set of data and procedure.
Kinx is a prototype based language but `class` keyword is prepared to define an object shape.

### Basic Style

As a class definition, basically there are cases of having arguments or no arguments.

```kinx
class A { /* ... */ }
class A() { /* ... */ }
class A(a, b) { /* ... */ }
```

In the above case, `class A` is the same as `class A()`.

### Inheritance

The ''`:`'' is used for inheritance of class.
As for arguments for inheritance, it is also same as a simple class definition, and the arguments are able to be omitted when there is no arguments.
The examples of inheritance are below.

```kinx
class A : B { /* ... */ }
class A() : B { /* ... */ }
class A : B(true) { /* ... */ }
class A(a, b) : B(b) { /* ... */ }
```

### Instantiate

The class object is instantiated by `new` operator.
When instantiating the object, a function call style is needed like `new ClassName()`.
It means, it makes no sense with `new ClassName` only.

```kinx
class A { /* ... */ }
var a = new A();
```

### Keyword `this` and `@`

The keyword of `this` means the instance itself.

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

You can use ''`@`'' instead of ''`this.`'', which is `this` plus dot.
By this, you can also write the following instead of the above code.

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

### Data

##### Private data and public data

The variable declared in class scope is a local private variable.
On the other hand, a property of `this` is a public variable.

```kinx
class A {
    var flag_ = false;  // a local private variable.
    public flagOn() {
        @flagOnActual();
    }
    public flagOnActual() {
        @flag = true;   // a public variable.
    }
}

var a = new A();
a.flagOn();
System.println(a.flag ? "true" : "false");
```

```console
true
```

### Methods

Methods are defined with `public` and `private` keyword.
The method defined with `private` is used only in a local scope, which is inside a class scope.
On the other hand, the method defined with `public` can be accessed by the instance\\apos{}s property.

```kinx
class A {
    private method1() {
        /* ... */
    }
    public method2() {
        method1();  // Okay, the `method1` is accessible inside the class scope.
        /* ... */
    }
    private method3() {
        method2();  // The `method2` is also accessible inside the class scope.
        @method2(); // The `method2` is also accessible through `this`.
    }
}

var a = new A();
// a.method1();     // Error, the `method1` is accessible through the instance.
a.method2();        // Okay, the `method2` is accessible through the instance.
```

### Special Methods

The `class` keyword will define some special methods.

##### `initialize`

If the `initialize` method is defined, it will be called automatically right after it is instantiated.
The `initialize` method can be defined as either `public` or `private`.

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

A class instance has the `instanceOf` method automatically.
This method accepts a class name as a variable, and it will return true if a target object is an instance of a specified class or a base class.

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

## Module

### What is Module

A module is used to extend a class functionality.
This is usually used for the common functionalities cross over a different kind of classes.

### Basic Style

The way how to define a module is basically below.

```kinx
module M { 
    /* ... Defines a public method
        to extend a host class which this is mixined into. */
}
```

### Mixin

The module is mixed into a class by `mixin` keyword.

```kinx
class A {
    mixin M;
    /* ... */
}
```

`mixin` can specify multiple modules like the following.

```kinx
class A {
    mixin M1, M2, M3;
    /* ... */
}
```

### Extend a Class

By the module mixed into a class, the methods defined in the module are added to the class.
For example, when the module `M` having the `method1` method is mixed into a class of `A`, `A` could also have and use the `method1` method.
Note that the `method1` method must be a public method then.

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

## Namespace

### What is Namespace

A namespace defined by the `namespace` keyword is a scope and an object which holds a class, a module, and so on.
For example, a class name will be a property of a namespace object.

### Namespace Definition

A namespace can be defined and used with the keyword `namespace` as follows.

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

A namespace can be nested.
You can put a namespace into another namespace.

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

As for the argument of `rhs`, it have to be implemented suited by assumpted context.
If you implemented above, you could use it as the following.

```kinx
var s1 = new Sample(10);
var s2 = s1 + 100;
s1 += 1100;
System.println(s1.value);  // => 1110
System.println(s2.value);  // => 110
```

It works well because `a += b` is the same as `a = a + b` internally.
By the way, it can be written below because it is exactly a function call to Object.

```kinx
var s1 = new Sample(10);
var s2 = s1.+(100);
System.println(s2.value);  // => 110
```

Basically, almost all operators except `[]` and `()` operator should work as well.

### `[]` Operator

`[]` means an index access.
But the index value will be only an integer, an array, or an object.
If it is a double as a real number, that value will be passed to an argument after converted to an integer.
A string is not available because it is absolutely same as a property access and it could be an infinate loop.

In fact, for example, it is implemented in `Range` and you can access as follows.

```kinx
System.println((2..10)[1]);
System.println(('b'..'z')[1]);
```

```console
3
c
```

You can write directly `[]` operator like a function call below and get the same result.

```kinx
System.println((2..10).[](1));
System.println(('b'..'z').[](1));
```

```console
3
c
```

### `()` Operator

`()` operator directly has an influence to Object.
This behaves like a functor, which is the class including `operator()`, in C++.
For example, you can directly use the `()` to the class instance like a function call.

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

It is the same as below if you write it as a function call.

```kinx
var f = new Functor();
f.()(1, 2, 3, 4, 5, 6, 7);
```

```console
[1, 2, 3, 4, 5, 6, 7]
```

