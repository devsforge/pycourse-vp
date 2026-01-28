# Data Definition Language

DDL (Data Definition Language) is a subset of SQL used for defining and
modifying the database structure. Understanding DDL is fundamental to working
with RDBMS. It allows you to define the structure of your data and make
necessary changes as your requirements evolve.

-   `CREATE` used to create new objects within a RDBMS
-   `ALTER` used to modify existing objects
-   `DROP` used to delete database objects
-   `TRUNCATE` used to remove all records from a table

::: {.contents local="" depth="2"}

## Create objects

### Creating database roles

!!! note


    SQLite is a small database in a single file and it doesn\'t implement
    role based access to data. Any user who have access to DB file will
    have access to data within the database as well.


In RDBMS, roles are used to manage database permissions. They are an essential
part of database security and user management.

In PostgreSQL a **role** is an entity that can own database objects and have
database privileges; a role can be considered a *user*, a *group*, or both
depending on how it is used.

`CREATE ROLE` statement defines a new database role.

``` postgresql
CREATE ROLE name;
```

This statement also can have options:

``` postgresql
CREATE ROLE name WITH LOGIN SUPERUSER PASSWORD 'password';
```

Options clarify if a role can login to the database server, connect to specific
databases, create other roles etc. The full list of options is available in the
official postgres documentation.

### Creating databases

`CREATE DATABASE` statement creates a new PostgreSQL database. To create
a database, you must be a superuser or have `CREATEDB` privilege.

``` postgresql
CREATE DATABASE name;
```

Databases within a PostgreSQL server have owners. By default a user who creates
a database is assigned as its owner. To specify another user as a database
owner options may be used:

``` postgresql
CREATE DATABASE name OWNER role_name;
```

There are lots of options for this statement available in the official postgres
documentation.

### Creating tables

To create a table, you use the aptly names `CREATE TABLE` command.
In this command you specify at least a name for the new table, the names of
the columns and the data type of each column.

``` postgresql
CREATE TABLE table_name
(
    first_column  INTEGER,
    second_column NUMERIC,
    third_column  VARCHAR(32),
    fourth_column TEXT
);
```

**Default value**

Constraints also can be applied for columns while creating a table.
In this section, only most notable constraints will be described.

A column can be assigned a default value. When a new row is created and
no values are specified for some of the columns, those columns will be
filled with their respective default values. If no default value is declared
explicitly, the default value is the `NULL` value. This usually makes sense
because a null value can be considered to represent unknown data.

In a table definition the default values are listed after the data type.

``` postgresql
CREATE TABLE product
(
    product_no INTEGER,
    name       TEXT
    price      NUMERIC DEFAULT 9.99
);
```

The default value can be an expression, which will be evaluated whenever
the default value is inserted (**not when the table is created**).
A common example are timestamps columns representing the time a record was
created and a \"serial number\" generator.

``` postgresql
CREATE TABLE product
(
    product_no INTEGER   DEFAULT nextval('product_no_seq'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

There is a shorthand to generate serial numbers:

``` postgresql
product_no SERIAL
```

**Generated Columns**

In case you need to calculate some column value based on other columns, you may
use generated columns. A generated column is a special column that is always
computed from other columns. Thus, it is for columns what a view is for tables.
There are two kinds of generated columns: stored and virtual.

A stored generated column is computed when it is written (inserted or updated)
and occupies storage as if it were a normal column. A virtual generated column
occupies no storage and is computed when it is read.

``` postgresql
CREATE TABLE person
(
    height_cm NUMERIC,
    height_in NUMERIC GENERATED ALWAYS AS (height_cm / 2.54) STORED
);
```

!!! note


    There are several restrictions applied to the definitions of generated
    columns and tables involving generated columns (not all listed):

    -   The generation expression can only use immutable functions and cannot
        use sub-queries or reference anything other than the current row.
    -   The generation expression cannot reference another generated column.
    -   A generated column cannot have column default.


**Constraints**

A check constraint is the most generic constraint type. It allows you to
specify that the value in a certain column must satisfy a Boolean (truth-value)
expression.

``` postgresql
CREATE TABLE product
(
    product_no       INTEGER,
    name             TEXT,
    price            NUMERIC CONSTRAINT price_positive CHECK (price > 0),
    discounted_price NUMERIC CHECK (discounted_price > 0),
    CHECK (price > discounted_price)
);
```

A not-null constraint simply specifies that a column must not assume the null
value.

``` postgresql
CREATE TABLE product
(
    product_no SERIAL NOT NULL,
    name       TEXT   NOT NULL CHECK(length(name) > 0)
);
```

Unique constraints ensure that the data contained in a column, or a group of
columns, is unique among all the rows in the table.

``` postgresql
CREATE TABLE example
(
    a INTEGER,
    b INTEGER UNIQUE,
    c INTEGER,
    UNIQUE (a, c)
);
```

**System columns**

Every table has several system columns that are implicitly defined by
the system. Therefore, these names cannot be used as names of user-defined
columns. These columns cannot be used in the generated columns (except
`tableoid`). Columns are:

-   `tableoid`
-   `xmin`
-   `cmin`
-   `xmax`
-   `cmax`
-   `ctid`

## Modify objects

When you create a table and you realize that you made a mistake, or the
requirements of the application change, you can drop the table and create
it again. But this is not a convenient option if the table is already filled
with data, or if the table is referenced by other database objects.

PostgreSQL provides a family of commands to make modifications to existing
tables. You can:

-   add columns
-   remove columns
-   add constraints
-   remove constraints
-   change default values
-   change column data types
-   rename columns
-   rename tables

All these actions are performed using the `ALTER TABLE` command.

### Adding a column

To add a column, use a command like:

``` postgresql
ALTER TABLE tbl_name ADD COLUMN cln_name cln_type
```

::: {.literalinclude language="postgresql" lines="57-69,102-104"}
/../libms-db/libms.sql

!!! note


    Constraints can be also defined on the column at the same time, using
    general syntax.

    In fact all the options that can be applied to a column description in
    `CREATE TABLE` can be used here. Keep in mind however that the default
    value must satisfy the given constraints, or the `ADD` will fail.


### Adding a constraint

To add a constraint, the table constraint syntax is used.

::: {.literalinclude language="postgresql" start-after="-- label: ddl-borrow_request" end-before="-- label:"}
/../libms-db/libms.sql

Other examples:

``` postgresql
ALTER TABLE tbl_name
    ADD CONSTRAINT cst_name UNIQUE (cln_name);

ALTER TABLE tbl_name
    ADD FOREIGN KEY (cln_name) REFERENCES tbl_another;
```

To add a non-null constraint, which cannot be written as a table constraint,
use this syntax:

``` postgresql
ALTER TABLE tbl_name
    ALTER COLUMN cln_name SET NOT NULL;
```

### Changing a column\'s default value

To set a new default for a column, use command like this:

``` postgresql
ALTER TABLE tbl_name
    ALTER COLUMN cln_name SET DEFAULT 0.0;
```

To remove any default value, use:

``` postgresql
ALTER TABLE tbl_name
    ALTER COLUMN cln_name DROP DEFAULT;
```

This is effectively the same as settings the default to `NULL`.

### Changing a column\'s data type

To convert a column to a different data type, use a command like this:

``` postgresql
ALTER TABLE tbl_name
    ALTER COLUMN cln_name TYPE NUMERIC(10, 2);
```

This will succeed only if each existing entry in the column can be converted
to the new type by an implicit cast. If a more complex conversion is needed,
you can add a `USING` clause that specifies how to compute the new values
from old ones.

PostgreSQL will attempt to convert the column\'s default value (if any) to the
new type, as well as any constraint that involve the column. But these
conversions might fail, or might produce surprising results. It\'s often best
to drop any constraints on the column before altering its type, and then add
back suitably modified constraints afterwards.

### Renaming objects

To rename objects use `RENAME` command, like this:

``` postgresql
ALTER TABLE tbl_name
    RENAME COLUMN cln_name TO new_cln_name;
ALTER TABLE tbl_name
    RENAME CONSTRAINT cst_name TO new_cst_name;
```

To rename a table:

``` postgresql
ALTER TABLE tbl_name
    RENAME TO new_tbl_name;
```

## Remove objects

### Removing tables

`DROP` command is used to remove objects.

``` postgresql
DROP TABLE tbl_name;
```

Remember, attempting to remove a table that does not exist is an error.
Nevertheless, it is common in SQL script files to unconditionally try to
drop each table before creating it, ignoring any error message, so that
the script works whether or not the table exists. `IF EXISTS` variant
can be used to avoid the error message, but this is not standard SQL.

::: {.literalinclude language="postgresql" lines="5-13"}
/../libms-db/libms.sql

In case there are other objects referencing the object to drop `CASCADE` may
be used to also remove any referencing objects.

### Removing a column

To remove a column, use `DROP` command like this:

``` postgresql
ALTER TABLE book
    DROP COLUMN genre;
```

Whatever data was in the column disappears. Table constraints involving
the column are dropped, too. However, if the column is referenced by a
foreign key constraint of another table, PostgreSQL will not silently drop
that constraint. You can authorize dropping everything that depends on
the column by adding `CASCADE`:

``` postgresql
ALTER TABLE tbl_name
    DROP COLUMN cln_name CASCADE;
```

### Removing a constraint

To remove a constraint you need to know its name. The **psql** command
`\d table_name` can be helpful to get the detailed information on
a specific table, including all constraints\' names assigned to it.

``` postgresql
ALTER TABLE tbl_name
    DROP CONSTRAINT cst_name;
```
