# Relational Database

RDBMS (Relational Database Management System) is a type of software
that helps users to create, update, manage, and access relational databases.
Relational databases organize data into tables, which consist of rows and
columns. Each column represents a specific attribute of the data, while each
row represents a specific instance of that data.

RDBMS allow users to interact with the database using
SQL (Structured Query Language), which is a standard language for
managing and manipulating relational databases. SQL allows users to perform
a variety of operations on the database, including adding, updating, and
deleting data, as well as retrieving data based on specific criteria.

RDBMS also provide a range of features to ensure data integrity, such as
enforcing data constraints, supporting transactions, and providing backup
and recovery capabilities. Additionally, RDBMS systems often provide tools
for managing the database, such as user interfaces for creating and modifying
tables and views, and monitoring tools for optimizing database performance.

Security is a paramount aspect of managing databases. Even at the introductory
level, it\'s crucial to be aware of the basic security measures:

-   **Authentication and Authorization**: Ensuring that only authorized users
    have access to the database.
-   **Role-Based Access Control**: Assigning permissions based on roles within
    the organization.
-   **Data Encryption**: Protecting sensitive data both at rest and in transit.

There are dozens of RDBMS, used in nowadays projects. But most widespread are:

-   [![PostgreSQL](/../assets/img/postgres.svg){width="32px"}](https://www.postgresql.org) **PostgreSQL**:
    A Powerful, open source object-relational database system.
-   [![MySQL](/../assets/img/sqlite.svg){width="32px"}](https://www.mysql.com) **SQLite**:
    A C-library that implements a small, full featured SQL database engine.
-   [![SQLite](/../assets/img/mysql.svg){width="32px"}](https://www.sqlite.org) **MySQL**:
    A fast, multithread, multi-user, and robust SQL database server.

::: {#rdbms .toctree}
structure
datatypes
ddl
dml
query
relations
functions
acid
normalization
