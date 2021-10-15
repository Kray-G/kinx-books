
# Function, Closure, and Fiber
## Function

### What is Function

A function has long been used to share the code.
A function receives some arguments, does something, and returns a result.
As you see, what makes it reusable by put multiple statements into the one is a function.

```kinx
function add(a, b) {
    return a + b;
}
System.println(add(1, 2));
System.println(add(3, 4));  // Reuse
System.println(add(5, 6));  // Reuse
System.println(add(7, 8));  // Reuse
```

```console
3
7
11
15
```

### Rest Operator

A function can accept a rest operator only at the last argument like JavaScript.
It is useful for variable arguments.

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

### Recursive call

Recursive calling is also available, but not supported a tail-recursion optimization.

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

### Arguments

You can use a destructuring assignment in arguments as well as a declaration or assignment.
The following three styles are available.

* Array Style
  * Each item in the array will be assigned to a variable in the order.
* Object Style
  * Each value will be assigned to the variable bound to each key.
  * When you omitted the key, the key would be treated by the same name as the variable.

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

### Pattern Matching

The pattern matching is available also in arguments as well as assignment and declaration.
If a part of variables is a literal, it will check if the argument is same as a literal.
As a result, if matching a pattern is failed, `NoMatchingPatternException` exception will be raised.

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

### Anonymous Function

An anonymous function can be written directly into an expression or arguments.

```kinx
var calc = function(func, a, b) {
    return func(a, b);
};
System.println(calc(function(a, b) { return a + b; }, 2, 3));
```

```console
5
```

If it is a simple function only with a `return` statement, it can be also written as follows.
Those are exactly same.

```kinx
System.println(calc(function(a, b) { return a + b; }, 2, 3));
System.println(calc(&(a, b) => a + b, 2, 3));
System.println(calc({ &(a, b) => a + b }, 2, 3));
System.println(calc({ => _1 + _2 }, 2, 3));
```

### `native` Function

Keyword `native` is a style of function definition used when you want to compile it to the native machine code.
You can just write a `native` instead of `function` keyword for that.

```kinx
native fib(n) {
    if (n < 3) return n;
    return fib(n-2) + fib(n-1);
}
```

#### Supported Features and Limitations

It is very fast but there are some limitations.

*   About types
    *   All variables are defined as a type. Available type is `int`, `big`, `dbl`, `str`, `bin`, `obj`, `int[]`, `dbl[]`, or `native`.
    *   If type information were omitted, the type would be followings.
        *   On argument, it become automatically `int`.
        *   Without initializer on declaration, it become automatically `int`.
        *   With initializer on declaration, it is decided by the result of right hand side.
            *   When it can not be decided, a compile error will occur.
    *   `int`
        *   Integer value is **NOT** automatically promoted to a big integer, it will just overflow instead.
        *   Math functions like `Math.pow(2, 10)` or `2.pow(10)` are supported.
    *   `big`
        *   It is supported as a big integer, but there is a little note. Please be careful when you use it.
            *   This type will use all values as a big integer value even if it is a small integer like 1.
                Therefore the performance may be quit slower than doing it with a VM execution in some cases.
            *   The native code will generate so many Big Integer objects in calculating with a big integer.
                In a current design, those objects are not collected by GC during a native execution.
                All objects of a big integer will be collected after returning to the VM execution.
                This means so many memory may be used and a performance may be quit slow.
            *   For example, you should **NOT** use a big integer in a native function like a recursive fibonacci calculation.
    *   `dbl`
        *   Math functions like `Math.pow(2.0, 10.0)` or `2.0.pow(10.0)` are supported.
    *   `str`
        *   `str` is only supported for adding 2 strings and multiplying string by integer.
    *   `bin`
        *   It is supported as an array of byte.
    *   `int[]` and `dbl[]`
        *   It is currently just supported as an array of integer or double.
    *   `native`.
        *   `native` function's return type is shown like `native funcname(arg):int`.
        *   Even in this case, you can omit `:int` as the type of a return value and automatically make it `int`.
*   About a function call
    *   Can not call a script function. Only can call a native function.
*   About statements and expressions
    *   Exceptions with `try-catch-finally` is supported, but a stack trace is not available.
    *   Both `switch-case` and `switch-when` are supported, but the case label should be an integer value or expression.
    *   The lexical scope and variables are available, but the type must be clarified.
        *   If you omit the type, it will assume the integer.
        *   If the type is mismatched, runtime exception will occur.
*   Supported platforms
    *   Supporting 64bit only.
    *   Libraries are supporting x64, ARM, MIPS, but it is not tested except x64 Windows or Linux.

## Closure

### What is Closure

A closure is a function object which has a lexical scope.
The variable in a lexical scope is hidden from outside.
That variable is bound to the closure, and the bound variable is independent in each closure.
For example, below is one of famous examples of a closure.

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

### Binding Variables

Now, let us prepare 2 instances of an above function object to look at a *binding*.
By the way, `newCounter` is same as above in this case.

```kinx
var c1 = newCounter();
var c2 = newCounter();
System.println(c1());
System.println(c1());
System.println(c1());
System.println(c1());
System.println(c2());   // another closure.
System.println(c2());   // another closure.
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

As you see, the returned value is different between `c1` and `c2` because `c1` has different function object from `c2`.
This means that the variable `i` itself bound to a different function object is also different.
That is why each value in `i` has been incremented independently.
This is exactly a feature of a closure.

## Fiber
### What is Fiber

A fiber is called as a lightweight thread and it is like a thread, but a fiber uses a cooperative multitasking while a thread uses a preemptive multitasking.
It means that a fiber yields itself to run another fiber while executing.
When using a fiber, it is possible to interrupt the process by the `yield` statement, and resume it again by the `resume` method.
Note that the `yield` is a statement, but `resume` is a method of a `Fiber` class.

A fiber is generally said that it is easier to use than a thread because spinlocks or atomic operations are unnecessary as synchronized operations.
On the other hand, a fiber cannot utilize multiprocessors well because it is basically cooperative model on a single thread.

### Class `Fiber`

The class `Fiber` is a main part of what treats a fiber.
You can create a fiber by passing a function to the constructor of the class `Fiber`.
Look at the following code, and you can see how the fiber works.

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

The `yield` can return the value, and it can also receive the value from `resume()`.
See ''\\nameref{`yield`}'' for details of `yield`.

### Fiber Examples

#### Fibonacci Sequence

Fibonacci sequence is the example of doing `yield` in an infinite loop.
It returns a process to a caller by doing `yield` inside `while`.
After that, it returns back to the fiber process by `resume()`, and it resumes from the next statement after did `yield`.


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

#### Function Call and Fiber

A fiber saves a stack condition.
Therefore, even when a function is called in a fiber, you can also do `yield` inside them.

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
