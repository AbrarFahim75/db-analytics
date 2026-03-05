SELECT name
FROM customers
WHERE id = (
  SELECT customer_id
  FROM orders
  ORDER BY amount DESC
  LIMIT 1
);
