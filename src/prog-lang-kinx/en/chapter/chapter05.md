
# Statement and Flow Control
## Statement

''Statement'' is a unit of control, and it generally means a procedure.
A statement makes a shape of a program, and there are roughly 5 types below.

* Definition Statement
* Declaration Statement
* Expression Statement
* Block Statement
* Control Statement

### Definition Statement

This is a statement to *define* some element used in a program.
It defines a function, a namespace, a module, or a class.
For example, below is an example of a class definition.

```kinx
class ClassName(arg0, arg2) {
    public method() {
        /* ... */
    }
}
```

See ''\\nameref{Function}'' for a function,
''\\nameref{Class}'' for a class,
''\\nameref{Module}'' for a module,
and ''\\nameref{Namespace}'' for a namespae.
Details are described in each section.

### Declaration Statement

#### `var` and `const`

It is a statement to declare variables.
It basically starts with `var` or `const`.
An assignment to the variable declared by `const` can be done only once.
It would be compile error if it were assigned twice or more.

```kinx
var a = 10 + x;         // Declaration statement
const x, y, z = 100;    // Declaration statement
```
#### `enum`

`enum` is used for naming an integer value.
It is usually thought that using a direct integer value should be avoided because it doesn't show a meaning.
That is why `enum` provides a meaning to an integer number to avoid a problem.

```kinx
enum {
    A,      // Starting from 0 if not specified the number.
    B,
    C = 10, // Changing the value to be 10.
    D       // Next value should be 11.
}
```

The actual number is started from 0, but you can change the number with an initializer.
An initializer can be put to any `enum` names.

Moreover, the value defined in `enum` is alive only in the scope.
The value is overwritten when the name is redefined in a nested scope, and when scoped out, the original value will be back.

```kinx
enum {
    C_VAL_UNKNOWN, C_VAL_INTEGER, C_VAL_STRING,
}

namespace X {
    enum {
        C_VAL_UNKNOWN = 100, C_VAL_INTEGER, C_VAL_STRING,
    }
    System.println("C_VAL_UNKNOWN = ", C_VAL_UNKNOWN);
}
System.println("C_VAL_UNKNOWN = ", C_VAL_UNKNOWN);
```

```console
C_VAL_UNKNOWN = 100
C_VAL_UNKNOWN = 0
```

### Expression Statement

It is a statement mainly to calculate and call a function.
An assignment is an expression statement because ''`=`'' is one of operators.
For example, below is an expression statement.

```kinx
a = 1 + x + func(); // Expression statement
xfunc();            // Expression statement
```

### Block Statement

A block is a mechanism to treat multiple statements, and wrapped by ''`{`'' and ''`}`''
A block makes a scope, and the variables declared inside a block has no effect to outside the block.
When the variable having a same name declared, a shadowing would occur.

### Control Statement

A control statement is a statement to control a condition check or a loop, and it is usually used with a block.
See ''\\nameref{Flow Control}`` for details.

## Flow Control
### `if`
### `for`
### `for-in`
### `while`
### `do-while`
### `switch-case/when`
### `try-catch-finally`
### `return`
### `throw`
### `yield`
### `break/continue`

## Special Flow Control
### `methodMissing`
### Exception

## Type Annotation
