SELECT
  name,
  city,
  ROW_NUMBER() OVER (ORDER BY name) AS row_num
FROM customers;
