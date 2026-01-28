# Operator Precedence

The following table summarizes the operator precedence in Python, from highest
precedence (most binding) to lowest precedence (least binding)
docs-python:operator-precedence. Operators in the same cell have the
same precedence (use left-to-right precedence).

  -----------------------------------------------------------------------------
  Operator                 Description
  ------------------------ ----------------------------------------------------
  `(expressions...)`,      Binding or parenthesized expression, list display,
  `[expressions...]`,      dictionary display, set display
  `{key: value...}`,       
  `{expressions...}`       

  `x[index]`,              Subscription, slicing, call, attribute reference
  `x[index:index]`,        
  `x(arguments...)`,       
  `x.attribute`            

  `await x`                Await expression

  `**`                     Exponentiation[^1]

  `+x`, `-x`, `~x`         Positive, negative, bitwise NOT

  `*`, `@`, `/`,           Multiplication, matrix multiplication, division,
  `//`, `%`                floor division, remainder[^2]

  `+`, `-`                 Addition and subtraction

  `<<`, `>>`               Shifts

  `&`                      Bitwise AND

  `^`                      Bitwise XOR

  `|`                      Bitwise OR

  `in`, `not in`,          Comparisons, including membership tests and
  `is`, `is not`,          identity tests
  `<`, `<=`, `>`,          
  `>=`, `==`, `!=`         

  `not x`                  Boolean NOT

  `and`                    Boolean AND

  `or`                     Boolean OR

  `if - else`              Conditional expression (ternary `if`)

  `lambda`                 Lambda expression

  `=`, `:=`                Assignment expression
  -----------------------------------------------------------------------------

[^1]: the power operator binds less tightly than an arithmetic or bitwise
    unary operator on its right (`2 ** -1` is `0.5`).

[^2]: the `%` operator is also used for string formatting;
    the same precedence applies.
