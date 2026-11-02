-- Schema DDL
CREATE TABLE customers (cid INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE orders (oid INTEGER, cid INTEGER, amount REAL, PRIMARY KEY (oid, cid), FOREIGN KEY (cid) REFERENCES customers (cid));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customers (cid, name) VALUES (1, 'Alice');
INSERT INTO customers (cid, name) VALUES (2, NULL);
INSERT INTO customers (cid, name) VALUES (3, 'Charlie');
INSERT INTO orders (oid, cid, amount) VALUES (101, 1, 100.0);
INSERT INTO orders (oid, cid, amount) VALUES (102, 1, 250.5);
INSERT INTO orders (oid, cid, amount) VALUES (103, 1, 99.99);
INSERT INTO orders (oid, cid, amount) VALUES (104, 2, 100.01);
INSERT INTO orders (oid, cid, amount) VALUES (105, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(c.cid) FROM customers AS c INNER JOIN orders AS o ON c.cid = o.cid WHERE o.amount >= 100;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT c.cid) FROM customers AS c INNER JOIN orders AS o ON c.cid = o.cid WHERE o.amount >= 100;

/*
Prediction Result:
(2,)
*/