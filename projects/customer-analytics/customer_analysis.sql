-- Customer Analytics Queries

-- Customers per city
SELECT city, COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;

-- Total spending per customer
SELECT customer_id, SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC;

-- Average order value
SELECT AVG(amount) AS avg_order_value
FROM orders;
