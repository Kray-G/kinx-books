
# Expession and Operators

## Expessions

It is called as ''Expression'' for what is evaluated and has a specific value.
It is usually used in the ''Statement'',
and it will control a flow based on the evaluated value,
or the evaluated value will be stored into a variable once and it will be used in another context.

''Expression'' is evaluated through operators, and it will finally become a specific value.
For example, if you write the expression of `1+2+3`, `1+2` is evaluated first, and it will be `3`.
After that, `3+3` is evaluated and a whole expression will be finally evaluated as '6'.

This section describes operators and `case-when` which is a special expression syntax.

## Operators

Operators described here are as follows.

* \\textref{Assignment Operators}
* \\textref{Comparison Operators}
* \\textref{Arithmetic Operators}
* \\textref{Bitwise Operators}
* \\textref{Logical Operators}
* \\textref{Index and Property Access}
* \\textref{Increment/Decrement}
* \\textref{Ternary Operators}
* \\textref{Spread/Rest Operators}
* \\textref{Pipeline Operators}
* \\textref{Function Composition Operators}

See the table in the section of ''\\nameref{Operators and Priority}'' for all specific operators and its priority.

<pagebreak />

### Assignment Operators

An assignment operators assigns a value based on the right operand to the left operand.
Basically an equal symbom (''`=`'') is used.
For example, it assigns the value of `y` to `x` when it is `x = y`.

In the assignment operator, the value of an expression will be finally a value to be assigned,
the same value can be assigned to multiple variables by connecting assignment operators.
Thereby, the assignment operator is right associativity.

```kinx
a = b = c = 10;
System.println([a, b, c]);
```

```console
[10, 10, 10]
```

Furthermore, there are compound assignment operators that are shorthand for the operations.

<context label="Table:KinxCompoundAssignmentOperators"/>
<context caption="Compound Assignment Operators"/>

|              Name               | Shorthand operator |    Meaning     |
| ------------------------------- | ------------------ | -------------- |
| Assignment                      | `x = y`            | `x = y`        |
| Addition assignment             | `x += y`           | `x = x + y`    |
| Subtraction assignment          | `x -= y`           | `x = x - y`    |
| Multiplication assignment       | `x *= y`           | `x = x * y`    |
| Division assignment             | `x /= y`           | `x = x / y`    |
| Remainder assignment            | `x %= y`           | `x = x % y`    |
| Exponentiation assignment       | `x **= y`          | `x = x ** y`   |
| Left shift assignment           | `x <<= y`          | `x = x << y`   |
| Right shift assignment          | `x >>= y`          | `x = x >> y`   |
| Bitwise AND assignment          | `x &= y`           | `x = x & y`    |
| Bitwise XOR assignment          | `x ^= y`           | `x = x ^ y`    |
| Bitwise OR assignment           | `x |= y`           | `x = x | y`    |
| Logical AND assignment          | `x &&= y`          | `x && (x = y)` |
| Logical OR assignment           | `x ||= y`          | `x || (x = y)` |
| Logical Nullish assignment      | `x ??= y`          | `x ?? (x = y)` |

#### Destructuring Assignment

Destructuring assignment is prepared for more complex assignments.
Destructuring assignment makes it possible to extract data from arrays or objects using a syntax like the construction of array and object literals.

See ''\\nameref{Destructuring Assignment and Pattern Matching}'' for details.

### Comparison Operators

A comparison operator compares a left and a right operand, and it returns 1 as `true` or 0 as `false`.
The operands can be numerical, string, or object values, etc.
In most cases, it will be converted to an appropriate type for the comparison if not a same type.
However, if converting impossible or it is uncomparable types, the `SystemException` would be raised.

A comparison operator is mainly used in the condition like below.

```kinx
if (a < b) {
    /* then clause */
} else {
    /* else clause */
}
```

<context label="Table:KinxComparisonOperators"/>
<context caption="Comparison Operators"/>
<context limit-column="0"/>

| l. Operator |          \<.          |          Examples for `true`           |
| :---------: | --------------------- | -------------------------------------- |
|    `==`     | Equal                 | `3 == var1`, `"3" == var1`, `3 == '3'` |
|    `!=`     | Not equal             | `var1 != 4`, `var2 != "3"`             |
|     `>`     | Greater than          | `var2 > var1`, `"12" > 2`              |
|    `>=`     | Greater than or equal | `var2 >= var1`, `var1 >= 3`            |
|     `<`     | Less than             | `var1 < var2`, `"2" < 12`              |
|    `<=`     | Less than or equal    | `var1 <= var2`, `var2 <= 5`            |

### Arithmetic Operators

An arithmetic operator means the standard operators such as addition (''`+`''), subtraction (''`-`''), multiplication (''`*`''),
division (''`/`''), reminder (''`%`''), or something like that.

```kinx
var a = 1, b = 2;
var r = a / b;
System.println([r, r.isDouble]);
```

```console
[0.5, 1]
```

These operators work as they do in most other programming languages, but the types attempts to convert them automatically to appropriate type for the operation.
For example, when it is done by integers like `1/2` and then the result is a real number like `0.5`, the result type would be a `double`.
Note that division by zero will raise `DivideByZero` exception.

Kinx also supports an exponentiation operator as ''`**`''.
This operation will be evaluated right-to-left.
For example, `2**3**4` means `2**(3**4)`, and the result must be `2417851639229258349412352`.

<context label="Table:KinxArithmeticOperators"/>
<context caption="Arithmetic Operators"/>

| l. Operator |      \<.       |                              Examples                              |              Remark              |
| :---------: | -------------- | ------------------------------------------------------------------ | -------------------------------- |
|     `+`     | Addition       | `12 + 5` \\arrow{right} `17`.                                      |                                  |
|     `-`     | Subtraction    | `12 - 5` \\arrow{right} `7`.                                       |                                  |
|     `*`     | Multiplication | `12 * 5` \\arrow{right} `60`.                                      |                                  |
|     `/`     | Division       | `12 / 5` \\arrow{right} `2`.                                       |                                  |
|     `%`     | Remainder      | `12 % 5` \\arrow{right} `2`.                                       |                                  |
|     `-`     | Unary minux    | `x == 3` \\arrow{right-x} `-x` \\arrow{right} `-3`.                |                                  |
|     `+`     | Unary plus     | ''`3`'' \\arrow{right} ''`3`''.<br />+true \\arrow{right} `1`.     | Just ignored.                    |
|    `**`     | Exponentiation | `2 ** 3 `\\arrow{right} `8`.<br />`10 ** -1` \\arrow{right} `0.1`. | $2^3 = 8$<br />$10^{-1} = 0.1$ |

### Bitwise Operators

A bitwise operator treats their operands as a bit set of zeros and ones rather than as decimal, hexadecimal, or octal numbers.
For example, the decimal number `9` has a binary representation of `1001`.
The bit size depends on the value.
For example, it will be 64 bit for a simple integer, but its size will be extended for a big integer.
Bitwise operators perform their operations on such binary representations, but they return standard numerical values.

<context label="Table:KinxBitwiseOperators"/>
<context caption="Bitwise Operators"/>

| l. Operator |     \<.     |  Usage   |             Remark              |
| :---------: | ----------- | -------- | ------------------------------- |
|     `&`     | Bitwise AND | `a & b`  |                                 |
|     `|`     | Bitwise OR  | `a | b`  |                                 |
|     `^`     | Bitwise XOR | `a ^ b`  |                                 |
|     `~`     | Bitwise NOT | `~a`     |                                 |
|    `<<`     | Left shift  | `a << b` | Shifts in zeros from the right. |
|    `>>`     | Right shift | `a >> b` | Discards bits shifted off.      |

### Logical Operators

Logical operators are typically used with Boolean values and returns a Boolean value.
However, the ''`&&`'', ''`||`'', and ''`??`'' operators actually return the value of one of operands,
so if these operators are used with non-Boolean values, they will return a non-Boolean value.

<context label="Table:KinxLogicalOperators"/>
<context caption="Logical Operators"/>

| l. Operator |       \<.       |      Usage       |                        Description                         |
| :---------: | --------------- | ---------------- | ---------------------------------------------------------- |
|     `!`     | Logical NOT     | `!expr`          | false if `expr` is true or valid, otherwise true.          |
|    `&&`     | Logical AND     | `expr1 && expr2` | `expr1` if `expr1` is false or invalid, otherwise `expr2`. |
|    `||`     | Logical OR      | `expr1 || expr2` | `expr1` if `expr1` is true or valid, otherwise `expr2`.    |
|    `??`     | Logical Nullish | `expr1 ?? expr2` | `expr1` if `expr1` is not null, therwise `expr2`.          |

#### Short-Circuit Evaluation

logical expressions are evaluated left-to-right, but it will be "short-circuit" evaluation using the following rules.
Thereby the anything part of the following is not evaluated.


* `false && anything` is short-circuit evaluated to false.
* `true || anything` is short-circuit evaluated to true.
* `nonNull ?? anything` is short-circuit evaluated to `nonNull` when `nonNull` is not null.

These operators can be also combined with an assignment operator.
For example of `a ??= b`, the value in `b` would be assigned into `a` only when `a` were null.
You can also see it in the table of ''\\nameref{Table:KinxCompoundAssignmentOperators}''.

### Index and Property Access

For Array, Binary, and the Object which has a `[]` operator, you can access via an index on appearance.
For Array and Binary, the index can be an integer or a double, which is converted to an integer.
For Object, the string is used as an index.
This is the same as a property access with `.property` style.

```kinx
var a = [1, 2, 3], b = <1, 2, 3>;
var r1 = a[0];
var r2 = b[1];
var c = { key: [a[2.1], b[2.2]] };  // => Same as [a[2], b[2]]
var r3 = c["key"];
var r4 = c.key;     // => Same as c["key"]
System.println([r1, r2, r3, r4]);
```

```console
[1, 2, [3, 3], [3, 3]]
```

### Increment/Decrement

There are two types of styles for the increment and decrement.
On is the prefix style in which the operation is done before evaluation, but another is the postfix style in which the operation is done after evaluation as well as C and C++.

```kinx
var a = 10;
var b = ++a;
var c = a--;
System.println([a, b, c]);
```

```console
[10, 11, 11]
```

### Ternary Operators

Ternary operator is one of shortcut operators, and it is used as a style of `a ? b : c`.
If `a` were true, it would return `b`, otherwise `c`.
Also a ternary operator is eveluated right-to-left[^ternary].

[^ternary]: This is a behavior which fits your intuition, so you do not have to be aware of it.

```kinx
function ternary(a, b, c) {
    return a ? b : c;
}
System.println([ternary(true, 1, 10), ternary(false, 2, 20)]);
```

```console
[1, 20]
```

### Spread/Rest Operators

A spread/rest operator is used to destruct or to combine an array or an object.

#### Rest Operator

For example, it is used in assignment or declaration as a rest operator, and it can receive a rest items of an array or binary.

```kinx
var [a, ...b] = [1, 2, 3, 4, 5];
System.println([a, b]);
```

```console
[1, [2, 3, 4, 5]]
```

#### Spread Operator

On the other hand, it can be a spread operator in an array and a binary.
In that case, it works as a shallow copy.

```kinx
var a = [1, 2, 3, 4, 5];
var b = [0, ...a, 10];
System.println(b);
```

```console
[0, 1, 2, 3, 4, 5, 10]
```

When it is a binary, see below.
You can see it is same as the case of an array.

```kinx
var a = <1, 2, 3, 4, 5>;
var b = <0, ...a, 10>;
System.println(b);
```

```console
<0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x0a>
```

The spread operator can be used to an object.
It works as a shallow copy even for an object.

```kinx
var a = { a: 10, b: 20, c: [1, 2, 3], d: { x: 100 } };
var b = { z: 2000,  ...a };
a.d.x = 150;
System.println(b);
```

```console
{"a":10,"b":20,"c":[1,2,3],"d":{"x":150},"z":2000}
```

You can see the `b.d.x` is also changed by changing the `a.d.x` because it is shallow copy.

#### Spread/Rest Operator in Function Call

The rest operator is also used for function arguments.

```kinx
function test(a, ...b) {
    System.println([a, b]);
}
test(1, 2, 3, 4, 5);
```

```console
[1, [2, 3, 4, 5]]
```

On the other hand, the spread operator can be used in the argument of function call.
In this case, the items in an array is extracted to each argument, and the function is called with the arguments.

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

By this, you can define the function to transfer arguments to another function even when you do not know the number of arguments.
In the following example, the function of `transfer` can receive all arguments as an array,
and it transfer to the `toActualFunction` function with individual arguments extracted from an array.

```kinx
function transfer(...args) {
    return toActualFunction(...args);
}
```

### Pipeline Operators

The pipeline operator is a syntactic sugar of a function call with a single argument.
For example, `64 |> Math.sqrt` is absolutely same as `Math.sqrt(64)`.
This provides a greater readability when chaining multiple functions together.

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

The operator `<|` is also available.
This is connected in opposite direction and it works as passing a value from the right to the left.

```kinx
var result = exclaim <| capitalize <| doubleSay <| "hello";
System.println(result); // => "Hello, hello!"
```

```console
Hello, hello!
```

If you want to use a function with multiple arguments in pipeline, use a lambda.

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

### Function Composition Operators

The function composition operator generates a new function composed functions.
For example, `Math.abs +> Math.sqrt` means `&(a) => Math.sqrt(Math.abs(a))`.
This provides a new reusable function for a greater readability when chaining multiple functions together.

```kinx
function doubleSay(str)  { return "%{str}, %{str}";  }
function capitalize(str) { return str.toUpper(0, 1); }
function exclaim(str)    { return str + '!';         }

var result = exclaim(capitalize(doubleSay("hello")));
System.println(result);

// Generates a new composed function.
var doubleSayThenCapitalizeThenExclaim = doubleSay +> capitalize +> exclaim;

var result = "hello" |> doubleSayThenCapitalizeThenExclaim;
System.println(result);
```

```console
Hello, hello!
Hello, hello!
```

The operator `<+` is also available.
This is connected in opposite direction and applying functions from the right to the left.

```kinx
var doubleSayThenCapitalizeThenExclaim
    = exclaim <+ capitalize <+ doubleSay;

var result = "hello" |> doubleSayThenCapitalizeThenExclaim;
System.println(result);
```

```console
Hello, hello!
```

If you need a function with multiple arguments in function composition, use a lambda.

```kinx
function double(x) { return x + x; }
function add(x, y) { return x + y; }
function boundScore(min, max, score) {
    return Math.max(min, Math.min(max, score));
}

var person = { score: 25 };

// Generates a new composed function.
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

A pipeline operator and a function composition operator is vary similar functionality.
However, there is a difference as a pipeline operator will pass the value on the fly,
but a function composition operator will just create a new function which can be reusable.
You can use both operators depended on the situation.

## Case-When

`case-when` is supported as an expression.
It has a similar syntax to `switch-case` or `switch-when`, but there are some following differences.

*   `switch-case` and `switch-when` is a statement, but `case-when` is an expression.
    `case-when` can be used inside an expression, and the result value can be assigned to a variable or be used with calculation.
*   `switch-case` is a fallthrough by default, but `case-when` will do automatically `break` similarly as `switch-when`.
    Always the only one of `when` clauses is used.
*   `switch-case` and `switch-when` will only check if the value is same, but `case-when` will check if the shape of an array or object is the same.
    This is like Ruby\\apos{}s pattern matching syntax of `case-in`.
*   In `switch-case` and `switch-when`, the order of checking value is normally not guaranteed and it will generate a jump by table in some cases for performance.
    But when it is in `case-when`, the order of checking is always the written order on the source code and starting it with the top.
*   When no condition is matched in `switch-case` and `switch-when`, nothing will be done. On the other hand, when it is `case-when`,
    the exception of `NoMatchingPatternException` will be raised.
*   Putting a block to a `when` clause means an on the fly function call.
    Therefore `return` in a block of `when` clause never returns to a caller function, and just returns a value as a result of `when` clause.
*   `case-when` is an expression, so you need a block when you want to write a statement.
    As said above, a block is an automatically called function object, so you can write multiple statements in a block and do it.
*   `case-when` is an expression, so the end of statement requires a semicolon of ''`;`''.

### Basic Usage

#### Normal Case

`case-when` example is below.
This is just checking the value.

```kinx
function example(y) {
    var x = case y
        when 1: 1
        when 2: 20
        when 3: 300
        when 4: 4000
        when 5: {
            return 50000; // this is an automatically called internal function,
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

#### Without Colon

You can omit the colon `:` when the `when` body is a block, there is a modifier, or it is `otherwise` clause.
This example uses an `if-modifier` and a pattern matching by `v`,
but a modifier and a pattern matching will be described later.

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

#### Inside Expression

If you want to use `case-when` inside an expression,
use `(` and `)` to avoid a syntax ambiguity or syntax error.
For example, sometimes the result could be different from your expectation as below.

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

If you need the result 4, you have to write it as below.

```kinx
var y = 1;
var x = (case y when 1: 1 when 2: 2) + 3;
// x means 4, or 1 ?
System.println(x);  // => 4
```

```console
4
```

### No Fallthrough

No fallthrough mechanism in `case-when`.
Just one condition is always selected and do it.
If it were not matching to any cases, it would select `otherwise` clause.
Moreover, if there were not even `otherwise` clause,
the exception of `NoMatchingPatternException` would be raised.

By the way, the reason why the exception is `NoMatchingPatternException` is because `case-when` assumes that it works with ''Pattern Matching'' which will be explained next section.
A constant condition like the following example is treated as the simplest kind of pattern matching, just checking if the values are equal.

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

### Pattern Matching

A pattern matching is available in a `when` clause as well as it is an assignment.
Therefore, you can use it below.

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

For more information on pattern matching, please also refer to ''\\nameref{Destructuring Assignment and Pattern Matching}''.

### Pin Operator

Since `case-when` uses a pattern matching, you need to use `^` of a pin operator for the value check instead of assignment.

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

The following is an example of `^` used as a pin operator to check if `y` equals `v`.

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

### If Modifier

Instead of a pin operator, you can also use `if-modifier` for the value check.
The following is an example of `if-modifier` to check if `y` equals `v`.

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

### Alternative Pattern

You can put multiple conditions in `when` clause.
This is called as an alternative pattern.
Each pattern is separated by `|`.
This separator of `|` is a kind of a shortcut operator, and the next condition will be never evaluated after something matched.

```kinx
case n
when 1 | 2 | 3: System.println(n)
;
```

Of course you can also use it for an array or object.

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

### Function Object in When Condition

You can directly put a simple style of a function object into the condition of `when` as it is.
In this case, the function will be called with an argument of the `case` value,
and if it returns true, then the body of `when` clause will be executed.

```kinx
function test(n) {
    case n
    when { => _1.isInteger }: System.println("%d is Integer" % n)
    when { => _1.isDouble  }: System.println("%f is Double" % n)
    when { => _1.isString  }: System.println("%s is String" % n)
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

Note that you should wrap it by `(` and\\hs{}`)` if it is not a simple style of an anonymous function,
or it will cause a compile error.

```kinx
function test(n) {
    case n
    when (&() => _1.isInteger): System.println("%d is Integer" % n)
    when (&() => _1.isDouble ): System.println("%f is Double" % n)
    when (&() => _1.isString ): System.println("%s is String" % n)
    ;
}
test(10);
test(10.0);
test("10.0");
```

## Destructuring Assignment and Pattern Matching

As a little description about Destructuring Assignment and Pattern Matching is needed, this section is prepared.

### Scope

### Destructuring Assignment for Array

### Destructuring Assignment for Object

### Pattern Matching for Array

### Pattern Matching for Object

### Complex Examples
