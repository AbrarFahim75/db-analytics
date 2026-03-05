# DDL (Data Definition Language)

This folder contains SQL scripts related to **database structure and schema definition**.

DDL statements are used to create, modify, and delete database objects such as tables and schemas.

## Topics Covered

- CREATE TABLE
- ALTER TABLE
- DROP TABLE
- TRUNCATE

## Example

```sql
CREATE TABLE customers (
  id INT PRIMARY KEY,
  name VARCHAR(100),
  city VARCHAR(100)
);
