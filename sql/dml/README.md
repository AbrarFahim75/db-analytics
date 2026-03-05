# DML (Data Manipulation Language)

This folder contains SQL scripts related to **data manipulation** operations.

DML statements are used to modify the data stored in database tables.

## Topics Covered

- INSERT – add new records to a table
- UPDATE – modify existing records
- DELETE – remove records from a table

## Example

```sql
INSERT INTO customers (id, name, city)
VALUES (1, 'Alice', 'Hamburg');

UPDATE customers
SET city = 'Berlin'
WHERE id = 1;

DELETE FROM customers
WHERE id = 1;
