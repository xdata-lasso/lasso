INSERT INTO categories (category_id, category_name, department) 
VALUES (1, 'Smartphones', 'ELECTRONICS');
INSERT INTO products (product_id, category_id, product_name, price, stock_quantity)
WITH digits AS (
    SELECT 0 AS d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
),
hundreds AS (
    SELECT 0 AS h UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
    UNION ALL SELECT 10
)
SELECT 
    (h.h * 100 + d1.d * 10 + d2.d) + 1,
    1,
    'Phone Model ' || ((h.h * 100 + d1.d * 10 + d2.d) + 1),
    199.99,
    50
FROM hundreds h
CROSS JOIN digits d1
CROSS JOIN digits d2;
