SELECT
  product,
  revenue,
  RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM sales;
