-- Schema DDL
CREATE TABLE products (product_id INTEGER PRIMARY KEY, stock_count INTEGER);

CREATE TABLE orders (order_id INTEGER PRIMARY KEY, product_id INTEGER, quantity INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO orders (order_id, product_id, quantity) VALUES (1, -1, 0), (-1, 1, NULL), (0, 0, -1), (2, -1, 1), (3, 0, 0), (4, 0, -1), (5, -1, NULL), (6, 1, 0), (7, 0, 0), (8, -1, 0), (9, NULL, 1), (10, -1, 1), (11, 1, 0), (12, 1, 0), (13, 0, 1), (14, -1, -1), (15, -1, 0);
INSERT INTO products (product_id, stock_count) VALUES (0, 1), (-1, 1), (1, -1), (2, -1), (3, 0), (4, 1), (5, NULL), (6, NULL), (7, NULL), (8, -1), (9, -1), (10, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT p.product_id FROM products AS p WHERE (p.product_id, p.stock_count) IN (SELECT o.product_id, COUNT(o.quantity) FROM orders AS o WHERE o.quantity > 0);

/*
Gold Result:
*/

-- Prediction Query
SELECT p.product_id FROM products AS p JOIN (SELECT o.product_id, COUNT(o.quantity) AS cnt FROM orders AS o WHERE o.quantity > 0 GROUP BY o.product_id) AS g ON p.product_id = g.product_id AND p.stock_count = g.cnt;

/*
Prediction Result:
(0,)
*/