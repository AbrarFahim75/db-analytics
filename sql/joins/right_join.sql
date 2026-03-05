SELECT c.name, o.order_id
FROM customers c
RIGHT JOIN orders o
ON c.id = o.customer_id;
