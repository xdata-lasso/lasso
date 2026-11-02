-- Schema DDL
CREATE TABLE orders (order_id INTEGER PRIMARY KEY, status TEXT);

CREATE TABLE lineitem (order_id INTEGER, supp_id INTEGER, PRIMARY KEY (order_id, supp_id), FOREIGN KEY (order_id) REFERENCES orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO orders (order_id, status) VALUES (1, 'O');
INSERT INTO orders (order_id, status) VALUES (2, 'O');
INSERT INTO orders (order_id, status) VALUES (3, 'O');
INSERT INTO orders (order_id, status) VALUES (4, 'O');
INSERT INTO orders (order_id, status) VALUES (5, 'F');
INSERT INTO orders (order_id, status) VALUES (6, NULL);
INSERT INTO lineitem (order_id, supp_id) VALUES (2, 10);
INSERT INTO lineitem (order_id, supp_id) VALUES (3, 9);
INSERT INTO lineitem (order_id, supp_id) VALUES (4, 11);
INSERT INTO lineitem (order_id, supp_id) VALUES (5, 11);
INSERT INTO lineitem (order_id, supp_id) VALUES (6, 11);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT order_id FROM orders WHERE status = 'O' AND EXISTS(SELECT * FROM lineitem WHERE lineitem.order_id = orders.order_id AND lineitem.supp_id <> 10);

/*
Gold Result:
(3,)
(4,)
*/

-- Prediction Query
SELECT order_id FROM orders WHERE status = 'O' AND NOT EXISTS(SELECT * FROM lineitem WHERE lineitem.order_id = orders.order_id AND lineitem.supp_id <> 10);

/*
Prediction Result:
(1,)
(2,)
*/