-- Schema DDL
CREATE TABLE customers (cid INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE orders (oid INTEGER, cid INTEGER, amount REAL, PRIMARY KEY (oid, cid), FOREIGN KEY (cid) REFERENCES customers (cid));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (cid, name) VALUES (1, NULL), (101, 'default2'), (100, 'default1'), (99, NULL), (0, 'default1');
INSERT INTO orders (oid, cid, amount) VALUES (100, 100, 101.0), (99, 99, 100.0), (99, 1, 101.0), (100, 101, 101.0), (100, 1, 101.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(c.cid) FROM customers AS c INNER JOIN orders AS o ON c.cid = o.cid WHERE o.amount >= 100;

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT c.cid) FROM customers AS c INNER JOIN orders AS o ON c.cid = o.cid WHERE o.amount >= 100;

/*
Prediction Result:
(4,)
*/