# SQL Joins

This folder contains examples of SQL JOIN operations used to combine data from multiple tables.

## Topics Covered

- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- FULL JOIN

## Example

```sql
SELECT c.name, o.order_id
FROM customers c
INNER JOIN orders o
ON c.id = o.customer_id;
