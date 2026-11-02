-- Schema DDL
CREATE TABLE orders (order_id INTEGER PRIMARY KEY, status TEXT);

CREATE TABLE lineitem (order_id INTEGER, supp_id INTEGER, PRIMARY KEY (order_id, supp_id), FOREIGN KEY (order_id) REFERENCES orders (order_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO orders (order_id, status) VALUES (9, 'O');
INSERT INTO lineitem (order_id, supp_id) VALUES (9, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT order_id FROM orders WHERE status = 'O' AND EXISTS(SELECT * FROM lineitem WHERE lineitem.order_id = orders.order_id AND lineitem.supp_id <> 10);

/*
Gold Result:
(9,)
*/

-- Prediction Query
SELECT order_id FROM orders WHERE status = 'O' AND NOT EXISTS(SELECT * FROM lineitem WHERE lineitem.order_id = orders.order_id AND lineitem.supp_id <> 10);

/*
Prediction Result:
*/