orphan

:   

# Comparison

## Comparison predicates

::: data
datatype BETWEEN datatype AND datatype

Test if a value is within the range endpoints (inclusive)

``` postgresql
2 BETWEEN 1 AND 3 -- true
2 BETWEEN 3 AND 1 -- false
```

::: data
datatype NOT BETWEEN datatype AND datatype

Not between (the negation of BETWEEN).

``` postgresql
2 NOT BETWEEN 1 AND 3 -- false
```

::: data
datatype BETWEEN SYMMETRIC datatype AND datatype

Between, after sorting the two endpoint values.

``` postgresql
2 BETWEEN SYMMETRIC 3 AND 1 -- true
```

::: data
datatype NOT BETWEEN SYMMETRIC datatype AND datatype

Not between, after sorting the two endpoint values.

``` postgresql
2 NOT BETWEEN SYMMETRIC 3 AND 1 -- false
```

::: data
datatype IS DISTINCT FROM datatype

Not equal, treating null as a comparable value.

``` postgresql
1 IS DISTINCT FROM NULL -- true (rather than NULL)
NULL IS DISTINCT FROM NULL -- false (rather than NULL)
```

::: data
datatype IS NOT DISTINCT FROM datatype

Equal, treating null as a comparable value.

``` postgresql
1 IS NOT DISTINCT FROM NULL -- false (rather than NULL)
NULL IS NOT DISTINCT FROM NULL -- true (rather than NULL)
```

::: data
datatype IS NULL

Test whether value is null.

``` postgresql
1.5 IS NULL -- false
```

::: data
datatype IS NOT NULL

Test whether value is not null.

``` postgresql
'null' IS NOT NULL -- true
```

::: data
datatype ISNULL

Test whether value is null (nonstandard syntax).

::: data
datatype NOTNULL

Test whether value is not null (nonstandard syntax).

::: data
boolean IS TRUE

Test whether boolean expression yields true.

``` postgresql
true IS TRUE -- true
NULL::boolean IS TRUE -- false (rather than NULL)
```

::: data
boolean IS NOT TRUE

Test whether boolean expression yields false or unknown.

``` postgresql
true IS NOT TRUE -- false
NULL::boolean IS NOT TRUE -- true (rather than NULL)
```

::: data
boolean IS FALSE

Test whether boolean expression yields false.

``` postgresql
true IS FALSE -- false
NULL::boolean IS FALSE -- false (rather than NULL)
```

::: data
boolean IS NOT FALSE

Test whether boolean expression yields true or unknown.

``` postgresql
true IS NOT FALSE -- true
NULL::boolean IS NOT FALSE -- true (rather than NULL)
```

::: data
boolean IS UNKNOWN

Test whether boolean expression yields unknown.

``` postgresql
true IS UNKNOWN -- false
NULL::boolean IS UNKNOWN -- true (rather than NULL)
```

::: data
boolean IS NOT UNKNOWN

Test whether boolean expression yields true or false.

``` postgresql
true IS NOT UNKNOWN -- true
NULL::boolean IS NOT UNKNOWN -- false (rather than NULL)
```

## Comparison functions

::: function
num_nonnulls(VARIADIC \"any\")

Returns the number of non-null arguments

``` postgresql
SELECT num_nonnulls(1, NULL, 2) -- return 2
```

::: function
num_nulls(VARIADIC \"any\")

Returns the number of null arguments

``` postgresql
SELECT num_nulls(1, NULL, 2) -- return 1
```

# Mathematical functions and operators

::: data
numeric_type + numeric_type

Addition

``` sql
SELECT 2 + 3 -- returns 5
```

::: data
-   numeric_type

Unary plus (no operation)

``` sql
SELECT + 3.5 -- returns 3.5
```

::: data
numeric_type - numeric_type

Subtraction

``` sql
SELECT 2 - 3 -- returns -1
```

::: data
-   numeric_type

Negation

``` sql
SELECT - (-4) -- returns 4
```

::: data
numeric_type \* numeric_type

Multiplication

``` sql
SELECT 2 * 3 -- returns 6
```

::: data
numeric_type / numeric_type

Division (for integral types, division truncates the result towards zero)

``` sql
SELECT 5.0 / 2 -- returns 2.5000000000000000

SELECT 5 / 2 -- returns 2

SELECT (-5) / 2 -- returns -2
```

::: data
numeric_type % numeric_type

Modulo (remainder); available for smallint, integer, bigint, and numeric

``` sql
SELECT 5 % 4 -- returns 1
```

::: data
numeric \^ numeric

::: data
double precision \^ double precision

Exponentiation

``` sql
SELECT 2 ^ 3 -- returns 8
```

Unlike typical mathematical practice, multiple uses of `^` will associate
left to right by default:

``` sql
SELECT 2 ^ 3 ^ 3 -- returns 512
SELECT 2 ^ (3 ^ 3) -- returns 134217728
```

::: data
\|/ double precision

Square root

``` sql
SELECT |/ 25.0 -- returns 5
```

::: data
\|\|/ double precision

Cube root

``` sql
SELECT ||/ 64.0 -- returns 4
```

::: data
@ numeric_type

Absolute value

``` sql
SELECT @ -5.0 -- returns 5.0
```

::: data
integral_type & integral_type

Bitwise AND

``` sql
SELECT 91 & 15 -- returns 11
```

::: data
integral_type \| integral_type

Bitwise OR

``` sql
SELECT 32 | 3 -- returns 35
```

::: data
integral_type \# integral_type

Bitwise exclusive OR

``` sql
SELECT 17 # 5 -- returns 20
```

::: data
\~ integral_type

Bitwise NOT

``` sql
SELECT ~1 -- returns -2
```

::: data
integral_type \<\< integer

Bitwise shift left

``` sql
SELECT 1 << 4 -- returns 16
```

::: data
integral_type \>\> integer

Bitwise shift right

``` sql
SELECT 8 >> 2 -- returns 2
```
