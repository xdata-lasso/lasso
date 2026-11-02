INSERT INTO categories (category_id, category_name, department) 
VALUES (1, 'Components', 'ELECTRONICS');
INSERT INTO products (product_id, category_id, product_name, price, stock_quantity)
WITH RECURSIVE cnt(x) AS (
  SELECT 1
  UNION ALL
  SELECT x + 1 FROM cnt WHERE x < 40
)
SELECT 
  (a.x - 1) * 40 + b.x,
  1,
  'Prod_' || ((a.x - 1) * 40 + b.x),
  1.0,
  10
FROM cnt AS a CROSS JOIN cnt AS b;
