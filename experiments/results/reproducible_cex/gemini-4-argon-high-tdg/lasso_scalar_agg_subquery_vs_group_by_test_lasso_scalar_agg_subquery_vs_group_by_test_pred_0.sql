-- Schema DDL
CREATE TABLE products (product_id INTEGER PRIMARY KEY, stock_count INTEGER);

CREATE TABLE orders (order_id INTEGER PRIMARY KEY, product_id INTEGER, quantity INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO products (product_id, stock_count) VALUES (10, 2);
INSERT INTO products (product_id, stock_count) VALUES (20, 2);
INSERT INTO orders (order_id, product_id, quantity) VALUES (1, 10, 5);
INSERT INTO orders (order_id, product_id, quantity) VALUES (2, 20, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT p.product_id FROM products AS p WHERE (p.product_id, p.stock_count) IN (SELECT o.product_id, COUNT(o.quantity) FROM orders AS o WHERE o.quantity > 0);

/*
Gold Result:
(10,)
*/

-- Prediction Query
SELECT p.product_id FROM products AS p JOIN (SELECT o.product_id, COUNT(o.quantity) AS cnt FROM orders AS o WHERE o.quantity > 0 GROUP BY o.product_id) AS g ON p.product_id = g.product_id AND p.stock_count = g.cnt;

/*
Prediction Result:
*/