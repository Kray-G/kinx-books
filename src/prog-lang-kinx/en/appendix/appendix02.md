
# Kinx Specification Details

## Operators and Priority

The following table shows the operators of Kinx.
And it shows also the priority of operators.

<context label="Table:ExpressionPriority"/>
<context caption="Operators Priority"/>


|   #   |           Item           |                  Examples                                         |
| :---: | ------------------------ | ----------------------------------------------------------------- |
|   1   | Factor                   | Variable, Number, String, ...                                     |
|   2   | Postfix Operator         | `++`, `--`, `[]`, `.property`, `()`                               |
|   3   | Prefix Perator           | `!`, `+`, `-`, `++`, `--`                                         |
|   4   | Pattern Matching         | `=~`, `!~`                                                        |
|   5   | Exponentiation           | `**`                                                              |
|   6   | Multiplication, Division | `*`,\\hs{}`/`,\\hs{}`%`                                           |
|   7   | Addition, Subtraction    | `+`, `-`                                                          |
|   8   | Bit Shift                | `<<`, `>>`                                                        |
|   9   | Comparison by Big/Small  | `<`, `>`, `>=`, `<=`                                              |
|  10   | Comparison by Equality   | `==`, `!=`                                                        |
|  11   | Bit AND                  | `&`                                                               |
|  12   | Bit XOR                  | `^`                                                               |
|  13   | Bit OR                   | `|`                                                               |
|  14   | Logical AND              | `&&`                                                              |
|  15   | Logical OR               | `||`                                                              |
|  16   | Ternary Expression       | ` ? : `, `function(){}`                                           |
|  17   | Assignment               | `=`, `+=`, `-=`, `*=`. `/=`. `%=`, `&=`, `|=`, `^=`, `&&=`, `||=` |

## Special Method

### Integer Special Method

<context label="Table:KinxIntegerMethods"/>
<context caption="Special Method (Integer)"/>
<context limit-column="0"/>

|            Method             |                                             Outline                                              |
| ----------------------------- | ------------------------------------------------------------------------------------------------ |
| `Integer.times(val, f)`       | Returns an array of `i` if no `f`, otherwise returns `f(i)` with the range of `i` (`0 ... val`). |
| `Integer.upto(val, max, f)`   | Calls `f(i)` with the argument as the range of `i` (`val .. max`).                               |
| `Integer.downto(val, min, f)` | Calls `f(i)` with the argument as the range of `i` (`min .. val`).                               |
| `Integer.toString(val, rdx)`  | Converts `val` to String. `rdx` is a radix.                                                      |
| `Integer.toDouble(val)`       | Converts `val` to Double.                                                                        |

As Integer includes both 64 bit integer and a big integer, those methods will also apply to Big Integer.
However, note that it could be almost like infinite loop when Big Integer passed to the method with loop.

### Double Special Method

<context label="Table:KinxDoubleMethods"/>
<context caption="Special Method (Double)"/>
<context limit-column="0"/>

|           Method            |                                                             Outline                                                             |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| `Double.toString(val, fmt)` | Converts `val` to String. `fmt` is one of `%a`, `%A`, `%e`, `%E`, `%f`, `%F`, `%g`, or `%G`. `%g` by default. |
| `Double.toInt(val)`         | Converts `val` to Integer.                                                                                                      |

As for Special Method to a real number, there is basically nothing but type conversion.

### String Special Method

<context label="Table:KinxStringMethods"/>
<context caption="Special Method (String)"/>
<context limit-column="0"/>

|             Method              |                                                           Outline                                                           |
| ------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `String.startsWith(str, s)`     | Returns true if String is started with `s`.                                                                                 |
| `String.endsWith(str, s)`       | Returns true if String is ended with `s`.                                                                                   |
| `String.toUpper(str, [s, e])`   | Makes it uppercases of `str` in the range of `[s, e)`. Makes all uppercases when omitted `s` and `e`.                       |
| `String.toLower(str, [s, e])`   | Makes it lowercases of `str` in the range of `[s, e)`. Makes all lowercases when omitted `s` and `e`.                       |
| `String.trim(str, [c])`         | Trims the head and tail of `str` by the character specified as `c`. White spaces will be removed when omitted the argument. |
| `String.trimLeft(str, [c])`     | Trims the head of `str` by the character specified as `c`. White spaces will be removed when omitted the argument.          |
| `String.trimRight(str, [c])`    | Trims the tail of `str` by the character specified as `c`. White spaces will be removed when omitted the argument.          |
| `String.find(str, s)`           | Returns the index with 0 origin where `s` was found in the `str`. Otherwise returns -1.                                     |
| `String.subString(str, s[, l])` | Returns a sub string started from the index of `s` with the length of `l`.                                                  |
| `String.replace(str, c, r)`     | Replaces all the part where matched with `c` in `str` by `r`. `c` can be a string or a regular expression.                  |
| `String.toInt(str)`             | Converts `str` to Integer.                                                                                                  |
| `String.toDouble(str)`          | Converts `str` to Double.                                                                                                   |
| `String.parentPath(str)`        | Returns a parent path part as if `str` is a path. ex) `"ab/cd/ef.x".parentPath()` will be `"ab/cd"`                         |
| `String.filename(str)`          | Returns a file name part without a parent path as if `str` is a path. ex) `"ab/cd/ef.x".filename()` will be `"ef.x"`        |
| `String.stem(str)`              | Returns a stem part of a file name as if `str` is a path. ex) `"ab/cd/ef.x".stem()` will be `"ef"`                          |
| `String.extnsion(str)`          | Returns an extension part of a file name as if `str` is a path. ex) `"ab/cd/ef.x".extnsion()` will be `".x"`                |
| `String.split(str, sep)`        | Returns an array of splitted `str` by `sep`. `sep` is a string or a regular expression.                                     |
| `String.each(str, f)`           | Calls `f` with an argument of a character which splitted `str` one by one. The second argument is an index with 0 origin.   |

### Array Special Method

<context label="Table:KinxArrayMethods"/>
<context caption="Special Method (Array)"/>
<context limit-column="0"/>

|             Method             |                                                                     Outline                                                                      |
| ------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| `Array.length(ary)`            | Returns the item count of `ary`.                                                                                                                 |
| `Array.keySet(obj)`            | Returns an array of a key list in `obj`.                                                                                                         |
| `Array.push(ary, e)`           | Adds `e` to `ary` as the last item.                                                                                                              |
| `Array.pop(ary)`               | Returns the last item from `ary` and removes it.                                                                                                 |
| `Array.unshift(ary, e)`        | Adds `e` to `ary` as the first item.                                                                                                             |
| `Array.shift(ary)`             | Returns the first item from `ary` and removes it.                                                                                                |
| `Array.join(ary, sep)`         | Returns a string in which all items are concatenated. The `sep` is a connection string as a glue.                                                |
| `Array.reverse(ary)`           | Returns a reversed array of `ary`.                                                                                                               |
| `Array.flatten(ary)`           | Returns an array being flatten `ary`.                                                                                                            |
| `Array.toString(ary)`          | Returns the same as `Array.join(ary, ", ")`.                                                                                                     |
| `Array.toJsonString(ary, idt)` | Returns a JSON string of `ary`. It will returns an indended string when `idt` is true.                                                           |
| `Array.apply(ary, f)`          | Executes `f(ary)`.                                                                                                                               |
| `Array.each(ary, f)`           | Executes `f(e, index)` for each item of `ary`.                                                                                                   |
| `Array.map(ary, f)`            | Returns a new set of results of `f(e, index)` for each item of `ary`.                                                                            |
| `Array.flatMap(ary, f)`        | Returns a flatten array after `map`.                                                                                                             |
| `Array.filter(ary, f)`         | Returns a new set of which the result of `f(e, index)` is true for each item of `ary`.                                                           |
| `Array.reject(ary, f)`         | Returns a new set of which the result of `f(e, index)` is false for each item of `ary`.                                                          |
| `Array.reduce(ary, f, i)`      | Returns a result of which `f(r, e)` is applied for each item 'e' of `ary`. `r` is a previous result and initially `i` or null if `i` is missing. |
| `Array.sort(ary, comp)`        | Sorts items with using `comp` as a comparison function and returns it as a new array.                                                            |
| `Array.clone(obj)`             | Returns a deep copy of `obj`.                                                                                                                    |
| `Array.extend(obj, obj2)`      | Extends `obj` with `obj2`. The value of the same key will be overwritten.                                                                        |
| `Array.println(ary)`           | Applies `System.println` for each item of `ary`.                                                                                                 |

`push`, `pop`, `unshift`, or `shift` will work as a destructive operation.
Note that Special Methods of Array will also apply to Object.
If you want to use it for both, you have to write the code to distinguish those after called.
See ''\\nameref{Array and Object}'' for details.

### Binary Special Method

<context label="Table:KinxBinaryMethods"/>
<context caption="Special Method (Binary)"/>
<context limit-column="0"/>

|           メソッド           |                                                                       意味                                                                       |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| `Binary.length(bin)`         | Returns the item count of `bin`.                                                                                                                 |
| `Binary.push(bin, e)`        | Adds `e` to `bin` as the last item.                                                                                                              |
| `Binary.pop(bin)`            | Returns the last item from `bin` and removes it.                                                                                                 |
| `Binary.unshift(bin, e)`     | Adds `e` to `bin` as the first item.                                                                                                             |
| `Binary.shift(bin)`          | Returns the first item from `bin` and removes it.                                                                                                |
| `Binary.join(bin, sep, fmt)` | Returns a string in which all items are concatenated. The `sep` is a connection string as a glue. `"0x02x"` will be used if omitted `fmt`.       |
| `Binary.reverse(bin)`        | Returns a reversed binary of `bin`.                                                                                                              |
| `Binary.toString(bin, fmt)`  | Returns the same as `Binary.join(ary, ", ", fmt)`.                                                                                               |
| `Binary.apply(bin, f)`       | Executes `f(bin)`.                                                                                                                               |
| `Binary.each(bin, f)`        | Executes `f(e, index)` for each item of `bin`.                                                                                                   |
| `Binary.map(bin, f)`         | Returns a new set of results of `f(e, index)` for each item of `bin`.                                                                            |
| `Binary.filter(bin, f)`      | Returns a new set of which the result of `f(e, index)` is true for each item of `bin`.                                                           |
| `Binary.reject(bin, f)`      | Returns a new set of which the result of `f(e, index)` is false for each item of `bin`.                                                          |
| `Binary.reduce(bin, f, i)`   | Returns a result of which `f(r, e)` is applied for each item 'e' of `bin`. `r` is a previous result and initially `i` or null if `i` is missing. |
| `Binary.sort(bin, c)`        | Sorts items with using `comp` as a comparison function and returns it as a new array.                                                            |
| `Binary.clone(bin)`          | Returns a deep copy of `obj`.                                                                                                                    |
| `Binary.println(bin)`        | Applies `System.println` for each item of `arbiny`.                                                                                              |

Basically, it will be applied to a binary, you can do notning but a simple operation.
`push`, `pop`, `unshift`, or `shift` is a destructive operation as well as Array.

Moreover, methods for Binary is sometimes implemented as a native code and it is different from Array.
For example, both `Array.sort(ary, compfunc)` and `Binary.sort(bin, compfunc)` is implemented as a quick sort, the one for Binary when no `compfunc` is optimized as `qsort` of `stdlib.h`.
And `Binary.reverse()` is also implemented in C.
Therefore, as for the reverse sort to Binary, `bin.sort().reverse()` is faster than `bin.sort(&(a, b) => b <=> a)`.

```kinx
function test(name, f) {
    var tmr = new SystemTimer();
    var sorted = f();
    var disp = [sorted[0], sorted[1], "...", sorted[-1]];
    System.println("%{name}%{disp} => ", tmr.elapsed());
}

var a = 10000.times(&() => Integer.parseInt(Math.random() * 100));
var bin = <...a>;
test("sort1", &() => bin.sort(&(a, b) => b <=> a));
test("sort2", &() => bin.sort().reverse());
```

The following is the result measured by an above program.

```console
sort1[99, 99, "...", 0] => 0.045096
sort2[99, 99, "...", 0] => 0.000582
```

It is 100 times faster.
But this is a rare case of such a big difference, so usually you do not have to be aware of it.

