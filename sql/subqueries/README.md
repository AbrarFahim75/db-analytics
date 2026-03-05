# SQL Subqueries

This folder contains examples of SQL subqueries used to perform nested queries inside other SQL statements.

## Topics Covered

- Subqueries in SELECT
- Subqueries in WHERE
- Subqueries in FROM

## Example

```sql
SELECT name
FROM customers
WHERE id IN (
    SELECT customer_id
    FROM orders
);
