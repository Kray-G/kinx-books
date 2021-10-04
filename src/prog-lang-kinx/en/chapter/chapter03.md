
# Data Types

## Numeric
### Integer Number

Kinx is dealing with an integer in 2 types of a style.
One is a 64 bit integer and one is a big integer.
They are basically distinguished internally, but a user, which means a programmer, do not have to be aware of it because they are automatically converted each other.

#### 64 bit Integer

When writing integer literals, they can be written in octal, decimal, or hexadecimal.
The representation format is the same as in the C language and follows the rules of ''\\nameref{Table:KinxInteger}''.

<context label="Table:KinxInteger"/>
<context caption="Rule of Integer Representation"/>

|    Radix    |       Rule of Representation        |
| :---------: | ----------------------------------- |
|    Octal    | The number started with `0`.        |
|   Decimal   | The number started with `1` to `9`. |
| Hexadecimal | The number started with `0x`.       |

If it is an integer, `.isInteger` property will be true.

```kinx
var a = 0x10;
System.println([10, a, 010]);
System.println(a.isInteger ? "true" : "false");
```

```console
[10, 16, 8]
true
```

#### Big Integer

If the value comes over the range of 64 bit integers, it is automatically converted to and dealt with a big integer.
A big integer can handle any integers and can also handle a very huge value.
However, big inetger literals are represented only by decimal.

```kinx
var n = 9223372036854775808;    // big integer
System.println("%d.isBigInteger = %s" % n % (n.isBigInteger ? "true" : "false"));
System.println("%d x 2 = %d" % n % (n * 2));
```

```console
9223372036854775808.isBigInteger = true
9223372036854775808 x 2 = 18446744073709551616
```

When it is a big integer, `.isBigInteger` property is true.
In this case, `.isInteger` is also true, so both `.isInteger` and `.isBigInteger` are true in a big integer.

#### Convert Each Other Between 64 bit and Big Integer

When a 64 bit integer comes over the range of 64 bit, it is automatically extended to the big integer.
When it comes back in the range of 64 bit, it is automatically back to the 64 bit integer.
This is automatically done, so programmers do not have to be aware of it.

Let\\apos{}s confirm the boundary between 64 bit integers and big integers.
At first, the range of 64 bit is from -9223372036854775808 to 9223372036854775807.
Thus, we starts from about 9223372036854775806 and increasing it.
After that, let\\apos{}s undo in order.

```kinx
function disp(n) {
    System.println("%d = %10s %13s"
        % n
        % (n.isInteger ? ".isInteger" : "")
        % (n.isBigInteger ? ".isBigInteger" : "")
    );
}
var n = 9223372036854775806;
for (var i = 0; i < 4; ++i, ++n) {
    disp(n);
}
for (var i = 0; i < 4; ++i, --n) {
    disp(n);
}
```

```console
9223372036854775806 = .isInteger
9223372036854775807 = .isInteger
9223372036854775808 = .isInteger .isBigInteger
9223372036854775809 = .isInteger .isBigInteger
9223372036854775810 = .isInteger .isBigInteger
9223372036854775809 = .isInteger .isBigInteger
9223372036854775808 = .isInteger .isBigInteger
9223372036854775807 = .isInteger
```

You can see the conversion each other between those is automatically done.


#### Example of Big Integer

Finally, let\\apos{}s calculate factorials for example of a big integer.

```kinx
function fact(n) {
    if (n < 1) return 1;
    return n * fact(n-1);
}
System.println(fact(500));
```

```console
12201368259911100687012387854230469262535743428031928421924135883858453731538819
97605496447502203281863013616477148203584163378722078177200480785205159329285477
90757193933060377296085908627042917454788242491272634430567017327076946106280231
04526442188787894657547771498634943677810376442740338273653974713864778784954384
89595537537990423241061271326984327745715546309977202781014561081188373709531016
35632443298702956389662891165897476957208792692887128178007026517450776841071962
43903943225364226052349458501299185715012487069615681416253590566934238130088562
49246891564126775654481886506593847951775360894005745238940335798476363944905313
06232374906644504882466507594673586207463792518420045936969298102226397195259719
09452178233317569345815085523328207628200234026269078983424517120062077146409794
56116127629145951237229913340169552363850942885592018727433795173014586357570828
35578015873543276888868012039988238470215146760544540766353598417443048012893831
38968816394874696588175045069263653381750554781286400000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000
```

Even for big integer operations, this level of operation can be completed in an instant[^bigintspeed].

[^bigintspeed]: It was fast even for 5000!, but it is 500! because the result was too long to show.

### Real Number

The real number is a double-precision value in C.
As for a real number literal, only a normal real number representation is supported and the exponent style is not supported so far[^dblexp]。

If the value is a real number, `.isDouble` will be true.
Moreover, when the result is a real number even with calculating between integers, it will be converted to a real number.

[^dblexp]: I wonder that I should do it...

```kinx
var d = 0.5;    // a real number literal
function eval(f) {
    r = f(3, 2);
    System.println("r = %3s, r.isDouble = %s" % r % (r.isDouble ? "true" : "false"));
}
eval({ => _1 + _2 });
eval({ => _1 - _2 });
eval({ => _1 * _2 });
eval({ => _1 / _2 });
```

```console
r =   5, r.isDouble = false
r =   1, r.isDouble = false
r =   6, r.isDouble = false
r = 1.5, r.isDouble = true
```

## String

One of reasons why a script language is used is that it is easy to use String.
There are many memory leaks and buffer overruns in C, so String is not easy to use in spite of a lot of use cases.
That is a big reason why the script language is popular because it is easy to use String since a Perl generation.

You can easily use String also in Kinx as well.

### String Literal

It is arounded by a single or a double quotation for a String literal.
It has a same meaning, but a double quotation should be escaped in a double quoted string, and a single quotation should be escaped in a single quoted string.

```kinx
var a = "\"aaa\", 'bbb'";
var b = '"aaa", \'bbb\'';
System.println(a == b ? "same" : "different");
```

```console
same
```

### Calculation with String

The arithmetic operations on strings behave as String.
Addition is a simple concatenation, multiplication is a concatenation by repetition.

```kinx
var a = "123456789,";
System.println(a + a + a);
System.println(a * 4);
```

```console
123456789,123456789,123456789,
123456789,123456789,123456789,123456789,
```

When division is applied to String, the string is concatenated as a path separated by ''`/`''.
In this case, duplicated ''`/`'' will be combined into one.

```kinx
var a = "path/to";
System.println(a / "file.txt");
System.println(a / "/file.txt");
```

```console
path/to/file.txt
path/to/file.txt
```

It also returns a formatter object if the remainder operation is applied.

```kinx
System.println("0x%02x" % 10);
```

```console
0x0a
```

A formatter object is an object for formatting, similar to `printf` in the C language.
See ''\\nameref{Formatting}'' for details.

### Index Access

When accessing String by index, it returns an integer as a character code at that place.
Therefore, if you want to check if the fifth character is `'a'`, you have to write the following.

```kinx
if (str[5] == 'a'[0]) {
    /* ... */
}
```

Note that you should access it by an index also in the RHS.
It needs an index of `[0]` in order to access a first character because `'a'` is not a character but a **String literal**.

You can also access it from a tail character by a negative value in index such as `str[-1]`.
The `str[-1]` in this case returns a character code of the last character.

### `=~` Operator

When applyng `=~` for String, it checks if matching to the regular expression[^regex] in RHS.
If it is not a regular expression in RHS, an exception will be thrown.
The return value is a set of a matched group, but otherwise, it will be a `False` object if not matched.

[^regex]: See ''\\nameref{Regular Expression}'' for a regular expression.

```kinx
if (g = ("abc" =~ /(.)(bc)/)) {
    g.each { => System.println(_1) };
}
```

```console
{"begin":0,"end":3,"string":"abc"}
{"begin":0,"end":1,"string":"a"}
{"begin":1,"end":3,"string":"bc"}
```

By the way, it is a same behavior even with exchanging LHS and RHS.

### `!~` Operator

When applyng `!~` for String, it checks if **not** matching to the regular expression in RHS.
If it is not a regular expression in RHS, an exception will be thrown.
The return value is true or false.
If not matching, it should be true.

```kinx
if ("axc" !~ /(.)(bc)/) {
    System.println("not matched");
}
```

```console
not matched
```

Even in this case, it is a same behavior even with exchanging LHS and RHS as well.

### Unary `*` Operator

When applying a unary `*` operator to String, it converts String to Array.
If you apply it to Array oppositely, it will return back to the String.

```kinx
var a = *"abc";
var b = *a;
System.println(a);
System.println(b);
```

```console
[97, 98, 99]
abc
```

As you see, you can convert each other between some types.
See ''\\nameref{Conversion Between Types}'' for details.

### Internal Expressions

You can write an expression internally inside String with `%{...}` style.

```kinx
for (var i = 0; i < 5; ++i) {
    System.println("i = %{i}, i * 2 = %{i * 2}");
}
```

```console
i = 0, i * 2 = 0
i = 1, i * 2 = 2
i = 2, i * 2 = 4
i = 3, i * 2 = 6
i = 4, i * 2 = 8
```

### Raw String

Not an internal expression, to write `%{...}` as a syntax creates a raw string.
[^rawstr]。
If using `%-{...}` instead, new lines at the head and tail of String will be trimmed.
You can also use `%<...>`, `%(...)`, or `%[...]`.
See example below.

[^rawstr]: This can be used like Here Document, so Kinx does not support Here Documment.

```kinx
var a = 100, b = 10;
var str1 = %{
This is a string without escaping control characters.
New line is available in this area.
{ and } can be nested here.
};
var str2 = %-{
This is a string without escaping control characters.
New line is available in this area.
But newlines at the beginning and the end are removed when starting with '%-'.
Variable a is %{a} and b is %{b}.
};
System.println("---");
System.println(str1);
System.println(str2);
System.println("---");
```

```console
---

This is a string without escaping control characters.
New line is available in this area.
{ and } can be nested here.

This is a string without escaping control characters.
New line is available in this area.
But newlines at the beginning and the end are removed when starting with '%-'.
Variable a is 100 and b is 10.
---
```

By this representation way, you can directly deal with multiple lines of String.
However, you should escape for non-nested ''`{`'' and ''`}`'' by ''`\`''.
And also for ''`%{expr}`'' which is not used as an internal expression, you have to use ''`%\{expr\}`'' for escaping.

The closing bracket should be used according to the opening bracket, but you can also use the following characters.
In that case, the start character and the end character should be the same, for example, such as `%|...|`.

* ''`|`''、''`!`''、''`^`''、''`~`''、''`_`''、''`.`''、''`,`''、''`+`''、''`*`''、''`@`''、''`&`''、''`$`''、''`:`''、''`;`''、''`?`''、''`'`''、'`"`'

### Formatting

The ''`%`'' operator on strings will create a formatter object.

```kinx
var fmt = "This is %1%, I can do %2%.";
System.println(fmt % "Tom" % "cooking");
```

```console
This is Tom, I can do cooking.
```

The `1` of `%1%` menas the number of a place holder, and it will be formatted in order of applying values by `%` operator.
If the order of applying is the same order of format characters, you can use a format character such as ''`%s`'' as well as a printf in C.

```kinx
var fmt = "This is %s, and %d years old, I like %s.";
System.println(fmt % "Tom" % 22 % "cooking");
```

```console
This is Tom, and 22 years old, I like cooking.
```

Moreover, you can combine the format character and a place holder into one with ''`$`'' like `%2$d`.

For example, you can write it as follows.

```kinx
var fmt = "This is %2%, I am 0x%1$02x years old in hex.";
System.println(fmt % 27 % "John");
```

```console
This is John, I am 0x1b years old in hex.
```

You can also use `%=` to add values after created a formatter object.

```kinx
var fmt = "This is %1%, I can do %2%.";
fmt %= "Tom";
fmt %= "cooking";
System.println(fmt);
```

```console
This is Tom, I can do cooking.
```

Actual formatting action will be performed at the following timing.

* When displaying it with like `System.println`.
* When adding it to String.

If you expressly want to create a formatted string from a formatter object, use a `format()` method.

```kinx
var fmt = "This is %1%, I can do %2%.";
fmt %= "Tom";
fmt %= "cooking";
setString(fmt.format());
```

### Colors and Decorations

Escape sequence is available for colors and decorations when it is outputted on a console.

Kinx supports direct methods to String object to realize it[^specialstr].
You can specify foreground colors, background colors, and some decorations.

[^specialstr]: This is also realized by ''Special Object''. See ''\\nameref{Special Object}'' for details of a special object.

#### Foreground and Background Colors

To specify a foreground and background color, do it like the foloowing.

```kinx
System.println("The text".red(.white));
```

![](ximg/redwhite.png)

A background color should be specified in the arugument of a foreground setting method.
Note that it is started with `.` such as `.white`.
See ''\\nameref{Table:KinxStringColors}'' about a list of colors you can specify.

<context label="Table:KinxStringColors"/>
<context caption="String Colors"/>

|  Color  |  Foreground  | Background |
| :-----: | ------------ | ---------- |
|  Black  | `.black()`   | `.black`   |
|   Red   | `.red()`     | `.red`     |
|  Green  | `.green()`   | `.green`   |
| Yellow  | `.yellow()`  | `.yellow`  |
|  Blue   | `.blue()`    | `.blue`    |
| Magenta | `.magenta()` | `.magenta` |
|  Cyan   | `.cyan()`    | `.cyan`    |
|  White  | `.white()`   | `.white`   |

#### Decorations

You can specify decorations as well as colors.

```kinx
System.println("The text".red(.white).bold().underline());
```

![](ximg/redboldwhite.png)

As you see, colors and decorations can be specified at the same time.

You can specify 5 kinds of decorations shown at ''\\nameref{Table:KinxStringAttrs}''.
However, note that some decorations does not work depended on the console and fonts[^strcolor].

[^strcolor]: `italic` and `blink` seems not to work on Windows.

<context label="Table:KinxStringAttrs"/>
<context caption="String Decorations"/>

| Decoration |     Method     |             Meaning             |
| :--------: | -------------- | ------------------------------- |
|    Bold    | `.bold()`      | Make it **bold**.               |
| Underline  | `.underline()` | Make it \\underline{underline}. |
|   Itaric   | `.italic()`    | Make it *itaric*.               |
|  Reverse   | `.reverse()`   | Reverse the color.              |
|   Blink    | `.blink()`     | Make it blink.                  |

## Array

Array is a container and a list to store some multiple data.
To use Array, you can deal with multiple data in pack.
Array can hold another Array inside.
By this, you can use multi-dimensional arrays.

### Array Literal

Array Literal is represented by `[...]`, and it can hold any data types into one Array.
And also you can put a comma as `,` after the last item.
This is the purpose as well as C, which it is easy to write items in a vertical way.
When the comma can be put after the last item, it is easy to sort of items or to add an item later in a source code.

```kinx
var a = [1, 2, 3, 4, 5];
var b = [
    "item1",
    "item2",
    "item3",
    "item4",
];
```

### Index Access

Array can be accessed by index.

```kinx
var a = [1, 2, 3];
System.println([a[1], a[-1]]);
```

```console
[2, 3]
```

As this example, when Array has Array as an item, the first index accesses the Array item and the next index accesses the item of the Array inside Array.
In short, connecting indexes can access easily to Array inside Array.

Moreover, the negative index will access the item scaned from the tail of Array.
It means `a[-1]` will access the last item of Array.

### Assignment of Array

Array can be copied by a spread operator.
But this operator is doing ''shallow copy''.
This example shows that rewriting the value of `val[2][1]` causes also to change `ary[0][1]`.

```kinx
var ary = [[1, 2], 1, 2, 3, 4];
var val = [10, 20, ...ary, 30, 40];
val[2][1] = 200;
System.println(ary);
System.println(val);
```

```console
[[1, 200], 1, 2, 3, 4]
[10, 20, [1, 200], 1, 2, 3, 4, 30, 40]
```

The structure of Array can be used in LHS and it can retrive the values correcponding to the same index.
You can swap values in this way.

```kinx
[a, b] = [b, a];    // Swap
```

Destructuring assignment is also availbale with a rest operator.

```kinx
var [a, ...b] = [1, 2, 3, 4, 5];
System.println("a = ", a);
System.println("b = ", b);
```

```console
a = 1
b = [2, 3, 4, 5]
```

See ''\\nameref{Destructuring and Pattern Matching Assignment}'' for details.

## Binary

Binary means an array of bytes.
All items are adjusted in the range from 0x00 to 0xFF, and it can be accessed like Array.

### Binary Literal

Binary litral is described in `<...>` style.

```kinx
var bin = <0x01, 0x02, 0x03, 0x04>;
System.println(bin);
```

```console
<0x01, 0x02, 0x03, 0x04>
```

### Assignment of Binary

Binary can be copied by a spread operator.

```kinx
var bin = <0x01, 0x02, 0x03, 0x04>;
var val = <0x10, 0x20, ...bin, 0x30, 0x40>;
System.println(val);
```

```console
<0x10, 0x20, 0x01, 0x02, 0x03, 0x04, 0x30, 0x40>
```

Moreover, Binary and Array can be divided and combined each other by a spread operator.

```kinx
var bin = <0x01, 0x02, 0x03, 0x04>;
var ary = [...bin];
System.println(ary);

var ary = [10, 11, 12, 257];
var bin = <...ary>;
System.println(bin);
```

```console
[1, 2, 3, 4]
<0x0a, 0x0b, 0x0c, 0x01>
```

However, note that a value will be truncated to the range from 0x00 to 0xFF at the moment when it is converted to Binary.

### Index Access

Binary can be accessed by index as well.
The negative value also means that it is accessed from the tail of Binary.

```kinx
var a = <1, 2, 3>;
System.println([a[1], a[-1]]);
```

```console
[2, 3]
```

## Object

Object is an associative array like a map stored by the style of key-value.

### Object Literal

You can write it a JSON style as it is simply said.

```json
{
    "key1": "value1",
    "key2": "value2"
}
```

See below for some differences from a pure JSON.

* A quotation is unnecessary for a key.
* A value can include an expression.
* Putting a comma after the last item is available.
* When a key name and a variable name of a value is same, a short cut style can be used.

You can write Object as below when those above are used in combination.

```kinx
var x = 10, y = 100;
var obj = {
    a: x + 1,
    b: y + 2,
    x,          // x: x
    y           // y: y
};
System.println(obj);
```

```console
{"a":11,"b":102,"x":10,"y":100}
```

### Access to Item

Object is an associative array, so you can access an item by a string index.
Moreover, `obj["a"]` can be written also as `obj.a`.

```kinx
var obj = { a: 100, b: 200, c: [1, 2] };
System.println(obj["a"]);
System.println(obj.a);
```

```console
100
100
```

### Assignment of Object

Object can be copied by a spread operator.
But this operator is doing ''shallow copy''.
This example shows that rewriting the value of `val.c[0]` causes also to change `obj.c[0]`.

```kinx
var obj = { a: 100, b: 200, c: [1, 2] };
var val = { ...obj, e: 400, f: 500};
val.c[0] = 10;
System.println(obj);
System.println(val);
```

```console
{"a":100,"b":200,"c":[10,2]}
{"a":100,"b":200,"c":[10,2],"e":400,"f":500}
```

The structure of Object can be used in LHS and it can retrive the values correcponding to the same key.
This is a destructuring assignment for Object.


```kinx
{ a, b, x: c } = { a: 100, b: 200, x: 300 };
System.println({ a, b, c });
```

```console
{"a":100,"b":200,"c":300}
```

This way of assignment can be also used in a declaration or a function argument.
By the way, null will be assiged when the key is missing.

```kinx
var obj = { a: 100, b: 200, x: 300 };
var { a, b, x: c } = obj;
System.println({ a, b, c });

function check({ a, b, x: c, y: d }) {
    System.println({ a, b, c, d });
}
check(obj);
```

```console
{"a":100,"b":200,"c":300}
{"a":100,"b":200,"c":300,"d":null}
```

See ''\\nameref{Destructuring and Pattern Matching Assignment}'' for details.

## Regular Expression
### Regular Expression Literal

Regular expression literal is represented with `/.../` style.
In this literal, no escape is necessary except for `/`.
The escape of ''`\`'' is needed only for ''`/`'' in the literal.

```kinx
/ab+[\t\n]/
```

Moreover, this is a same meaning as below.
When it is a string literal, escaping is needed such as a new line.
When it is a raw string, no escape is needed.

```kinx
new Regex("ab+[\\t\\n]");  // same as /ab+[\t\n]/
new Regex(%|ab+[\t\n]|);   // same as /ab+[\t\n]/
```

Using `%m` prefix, you can change the ''`/`'' symbol of a regular expression literal.
In this case, no escape is needed except for your used symbol.
Besides, as it is different from a raw string, you can use all characters which is not in a regular exression string.
Therefore, you can also write it like the following[^regexpat].

[^regexpat]: If we are asked that it can be, we do not know.

```kinx
%m1ab+[\t\n]1  // same as /ab+[\t\n]/
```

If you use a bracket, the closing bracket have to be used corresponding to the opening bracket.

```kinx
%m<ab+[\t\n]>  // same as /ab+[\t\n]/
%m(ab+[\t\n])  // same as /ab+[\t\n]/
```

### Use in String Method

A regular expression object can be used in the argument of following String methods.

#### replace

`String.replace()` can use a regular expression as a condition to be replaced.

```kinx
var s = "xabbbbbcabbc".replace(/ab+/, ",");
System.println(s);
```

```console
x,c,c
```

#### find

`String.find()` can use a regular expression as a condition to search.

```kinx
System.println("abcdefg".find("cd"));
System.println("abcdefg".find(/cd/));
```

```console
2
[{"begin":2,"end":4,"string":"cd"}]
```

It returns an index number when the condition is just a string.
When using a regular expression for a condition, it returns an array of a found group.

#### split

`String.split()` can use a regular expression as a condition of a separator.

```kinx
var s = "xabbbbbcabbc".split(/ab+/);
s.each(&(e) => System.println(e));
```

```console
x
c
c
```

### Basic Usage

This section shows a basic usage of a regular expression.

```kinx
var a = "111/aaa/bbb/ccc/ddd";
while (group = (a =~ /\w+\//)) {
    for (var i = 0, len = group.length(); i < len; ++i) {
        System.println("found[%2d,%2d) = %s"
            % group[i].begin
            % group[i].end
            % group[i].string);
    }
}
```

```console
found[ 0, 4) = 111/
found[ 4, 8) = aaa/
found[ 8,12) = bbb/
found[12,16) = ccc/
```

When there are a lot of ''`/`'' in the regular expression, you can use `%m` to avoid a lot of escaping.
For example, it is like `%m(...)`.
By this way, you can rewrite the above example as below.

```kinx
var a = "111/aaa/bbb/ccc/ddd";
while (group = (a =~ %m(\w+/))) {
    for (var i = 0, len = group.length(); i < len; ++i) {
        System.println("found[%2d,%2d) = %s"
            % group[i].begin
            % group[i].end
            % group[i].string);
    }
}
```

### Note for Regular Expression Literal

There is a note when you use a regular expression in a condition like `while`.

For example, if you write it below, the loop will be performed with a group holding captures until matching has been ended.
In that case, if you break the loop with like `break` before finished, there is a case that a target string of a regular expression can not be reset correctly.

```kinx
while (group = (str =~ /ab+/)) {
    /* block */
    if (expr) {
        break;
    }
}
```

When the program returns back to the same loop again after breaking that loop, the start point of searching may have been continued against your expectation.
It is no problem when the loop has been correctly finished until the end, or it would be also no problem when a string of `str` were different.

To sum up, there are 2 patterns of timing to reset a regular expression literal, and it is no problem with the condition below.

*   The first time, or the next time after not matching.
*   The case that `str` has been changed.

This is a current specification.
Note it when using a regular expression literal.

## Range Representation

Range is a Range object which is an instance of a Range class, which shows the meaning of ''from some value to some value.''

### Class `Range`

Range object can be created as below.
The created instance holds a range from some value to some value according to your specified.

```kinx
new Range(Start, End, ExclusiveFlag)
```

### Range Literal with Dot
#### Number

You can also write a Range with a dot style.
With 2 dots, it includes the end.
With 3 dots, it is the range which does not include the end.

```kinx
var a = 2..10;  // new Range(2, 10)
var b = 2...10; // new Range(2, 10, true)
```

`Start` and `End` can be also represented by a variable or an expression.

```kinx
function makeRange(begin, len) {
    return begin..(begin+len);
}
System.println(makeRange(100, 2).end());
```

```console
102
```

#### String

You can also define the range of strings.

```kinx
var a = "a".."z";     // new Range("a", "z")
var b = "ab"..."ax";  // new Range("ab", "ax", true)
```

There is no differences between a double-quoted and a single-quoted.

```kinx
var l = 'a'..'g';  // 'a', 'b', 'c', ..., 'g'
l.each { => System.println(_1) };
```

```console
a
b
c
d
e
f
g
```

#### Date

Range can deal with also the range of dates.

```kinx
using DateTime;
var l = DateTime("2000/1/1")..DateTime("2000/1/6");
l.each { => System.println(_1.format("%MMMM% %DD%, %YYYY%")) };
```

```console
January 01, 2000
January 02, 2000
January 03, 2000
January 04, 2000
January 05, 2000
January 06, 2000
```

#### Start and End

The end value can be omitted.
This means the range without the end.
For example, `1..` will show a natural number.
But the start value cannot be omitted.
If you really want to omit it, use null instead.

```kinx
1..;        // => Okay
1...;       // => Okay
..10;       // => error
...10;      // => error
null..10;   // => Okay
```

### Class `Enumerable`

Range is defined as min-in of Enumerable module, so you can use interfaces of Enumerable.

As a current status, the following interfaces are implemented.
As for the stuff marked in **''L''**, it is the method which will perform a lazy evaluation after returning an Enumerator object by `lazy()`.

<context label="Table:KinxEnumerable"/>
<context caption="Enumerable Methods"/>
<context limit-column="2"/>

|      Method      |                                                    Outline                                                     |   L   |
| ---------------- | -------------------------------------------------------------------------------------------------------------- | :---: |
| `filter(f)`      | Filters by items of which the result of `f` is true.                                                           |   O   |
| `map(f)`         | Returns items for each to map by `f`.                                                                          |   O   |
| `flatMap(f)`     | Returns items to be flatten after mapping by `f`.                                                              |   O   |
| `take(n)`        | Returns the fiest `n` items.                                                                                   |   O   |
| `takeWhile(f)`   | Returns items of while `f` is true.                                                                            |   O   |
| `drop(n)`        | Drops the fiest `n` items and returns the rest.                                                                |   O   |
| `dropWhile(f)`   | Drops items of while `f` is true and returns the rest.                                                         |   O   |
| `each(f)`        | All items passes to `f`.                                                                                       |   O   |
| `reduce(f, itr)` | Reduces results of applying `f`, started with `itr` or null.                                                   |       |
| `sort(f)`        | Sorts items using `f` as a comparison function.                                                                |       |
| `all(f)`         | Returns true when all results are true by applying `f` for each.                                               |       |
| `any(f)`         | Returns true when at least one of results are true by applying `f` for each.                                   |       |
| `toArray()`      | Returns items as Array.                                                                                        |       |
| `println()`      | Prints all items.                                                                                              |       |
| `lazy()`         | Returns the object itself after setting functions to be a lazy function for the functions above marked in `L`. |       |

By the way, note that it could be an infinite loop if you used the range such as an infinite sequence for the function which is not a lazy evaluation.

### Range for Switch-Case

You can use Range at `case` or `when` in `switch-case/when`.
It checks if the value is inside the range you specified.
Here is the sample that the number is specified.

```kinx
for (var i = 0; i <= 10; ++i) {
    switch (i) {
    when 1..4:
        System.println("okay 1 (%{i})");
    when 7...9:
        System.println("okay 2 (%{i})");
    else:
        System.println("out of range (%{i})");
    }
}
```

```console
out of range (0)
okay 1 (1)
okay 1 (2)
okay 1 (3)
okay 1 (4)
out of range (5)
out of range (6)
okay 2 (7)
okay 2 (8)
out of range (9)
out of range (10)
```

The next one is the sample of specifying it as a string.

```kinx
for (var i in 's'..'af') {
    switch (i) {
    when 'ac'..'ae':
        System.println("okay 1 (%{i})");
    when 't'...'w':
        System.println("okay 2 (%{i})");
    else:
        System.println("out of range (%{i})");
    }
}
```

```console
out of range (s)
okay 2 (t)
okay 2 (u)
okay 2 (v)
out of range (w)
out of range (x)
out of range (y)
out of range (z)
out of range (aa)
out of range (ab)
okay 1 (ac)
okay 1 (ad)
okay 1 (ae)
out of range (af)
```

## Conversion Between Types

Normally the data type will be automatically converted if possible,
but you can convert it explicitly for the purpose.

### Conversion by Unary `*` Operator

The unary `*` operator is the operator to convert the data type.
It will affect each data type as follows.

| Before  | After  |                         Examples                          |
| :-----: | :----: | :-------------------------------------------------------: |
| Integer | String |                 `97` \\arrow{right} `"a"`                 |
| Double  | String |              `97.1` \\arrow{right} `"97.1"`               |
| String  | Array  |     `"abcde"` \\arrow{right} `[97, 98, 99, 100, 101]`     |
| Binary  | String | `<0x61, 0x62, 0x63, 0x64, 0x65>` \\arrow{right} `"abcde"` |
|  Array  | String |     `[97, 98, 99, 100, 101]` \\arrow{right} `"abcde"`     |
| Object  |  null  |                `{}` \\arrow{right} `null`                 |

### Conversion by Spread Operator

To tell the truth, what the spread operator will do is not a conversion but the copy of data instead.
For example, you can convert from an array to an binary by the following.
By the way, the value will be wraparoundded under 0xFF when converting to a binary data.

```kinx
var ary = [1, 2, 3, 4, 5];
var bin = <...ary>;
```

```console
<0x01, 0x02, 0x03, 0x04, 0x05>
```

The value can be also inserted inside other data because the spread operator will do the copy.

```kinx
var ary = [1, 2, 3, 4, 5];
var bin = <0, ...ary, 6, 7, 8>;
```

```console
<0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08>
```

Also, you can do the following if you want to convert from a binary to an array.

```kinx
var bin = <1, 2, 3, 4, 5>;
var ary = [...ary];
```

```console
[1, 2, 3, 4, 5]
```

See ''\\nameref{Spread Operator}'' for the spread operator itself.

### Conversion by Function

Kinx prepares the functions to convert data types.
For example, `Integer.parseInt()` is for making it the integer number, and `Double.parseDouble()` for the real number.

```kinx
var s = "256";
var n = Integer.parseInt(s);
System.println([n, n.isInteger]);
```

```console
[256, 1]
```

`Integer.parseInt()` can handle also the big integer.

```kinx
var s = "10000000000000000000000000000000000000000000000000000000000000000000000";
var n = Integer.parseInt(s);
System.println(n);
System.println([n.isInteger, n.isBigInteger]);
```

```console
10000000000000000000000000000000000000000000000000000000000000000000000
[1, 1]
```

Moreover, adding `""` is usually used like `"" + a` for making it to the string, but you can use a `toString()` method.
The behabior of a `toString()` method depends on the target data, but for example, the radix can be also specified for the `toString` method for the integer.

```kinx
var n = 256;
var s1 = n.toString();
var s2 = n.toString(16);
System.println([s1, s1.isString, s2, s2.isString]);
```

```console
["256", 1, "100", 1]
```

Basically, an array, a binary, or an object will support the `toString()` method.
Therefore, to support `toString()` method is recommended when you design your own class.
You will use it well as a Duck Typing in the most situation.

## Special Object

Special Object is the object which holds methods to call directly a method for the specific target type, and there are String, Integer, Double, Binary, and Array.
And also the method itself defined to Special Object and used to call directly a method for the specific target object is called as Special Method.

But adding Special Method to Special Object is never recommended because of following points.

* Because **it could be used in the library such as adding an embedded special method**.
* Because **the behavior of Standard Library could be changed and not work correctly**.

It is useful if using this in a library development, but note the conflict between libraries.
Therefore, this section describes Special Object by the perspective of a mechanism.

### Example of Special Object

For example, let\\apos{}' define the function below to the Special Object of `String`.

```kinx
String.greeting = function(name) {
    System.println("Hello, I am %{name}.");
};
```

After that, you can write it as below.

```kinx
"John".greeting();
```

You will see below if you execute it.

```console
Hello, I am John.
```

You can see that the `"John"` is passed to the first argument of `String.greeting` function.
In short, it works as if the target object is passed to the first argument of the Special Method.
This mechanism leads you to define functions to control the target object freely.

The method defined in Special Object is called as Special Method, and as sum up methods used very often into ''\\nameref{Special Method}'', so see there.
