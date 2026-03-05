SELECT name
FROM customers
WHERE id IN (
  SELECT customer_id
  FROM orders
);
