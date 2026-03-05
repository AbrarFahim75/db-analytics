# Window Functions

This folder contains SQL examples using window functions for advanced data analysis.

Window functions perform calculations across a set of table rows related to the current row.

## Topics Covered

- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- COUNT() OVER()
- PARTITION BY

## Example

```sql
SELECT
  name,
  city,
  COUNT(*) OVER (PARTITION BY city)
FROM customers;
