-- Schema DDL
CREATE TABLE customer (c_id INTEGER PRIMARY KEY, c_name TEXT);

CREATE TABLE orders (o_id INTEGER PRIMARY KEY, o_c_id INTEGER, o_comment TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic LEFT JOIN behavior: customer with no orders, customer with only excluded orders, customer with mixed orders, and customer with multiple valid orders.
-- Catches INNER JOIN vs LEFT JOIN, WHERE vs ON clause placement, COUNT(*) vs COUNT(o_id), and NOT LIKE vs LIKE.
INSERT INTO customer (c_id, c_name) VALUES (1, 'Alice');
INSERT INTO customer (c_id, c_name) VALUES (2, 'Bob');
INSERT INTO customer (c_id, c_name) VALUES (3, 'Charlie');
INSERT INTO customer (c_id, c_name) VALUES (4, 'David');
INSERT INTO orders (o_id, o_c_id, o_comment) VALUES (101, 2, 'your pending accounts are here');
INSERT INTO orders (o_id, o_c_id, o_comment) VALUES (102, 3, 'pending something accounts');
INSERT INTO orders (o_id, o_c_id, o_comment) VALUES (103, 3, 'valid order comment');
INSERT INTO orders (o_id, o_c_id, o_comment) VALUES (104, 4, 'first valid order');
INSERT INTO orders (o_id, o_c_id, o_comment) VALUES (105, 4, 'second valid order');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c_id, COUNT(o_id) AS cnt FROM customer LEFT JOIN orders ON c_id = o_c_id AND o_comment NOT LIKE '%pending%accounts%' GROUP BY c_id;

/*
Gold Result:
(1, 0)
(2, 0)
(3, 1)
(4, 2)
*/

-- Prediction Query
SELECT c_id, COUNT(o_id) AS cnt FROM customer LEFT JOIN orders ON c_id = o_c_id AND o_comment NOT LIKE '%pending_accounts%' GROUP BY c_id;

/*
Prediction Result:
(1, 0)
(2, 0)
(3, 2)
(4, 2)
*/