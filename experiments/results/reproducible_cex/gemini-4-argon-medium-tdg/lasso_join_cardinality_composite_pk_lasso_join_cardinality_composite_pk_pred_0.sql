-- Schema DDL
CREATE TABLE customers (cid INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE orders (oid INTEGER, cid INTEGER, amount REAL, PRIMARY KEY (oid, cid), FOREIGN KEY (cid) REFERENCES customers (cid));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests: Duplicate cid in join result (COUNT(c.cid) vs COUNT(DISTINCT c.cid)), and shared oid across different customers (COUNT(oid) vs COUNT(DISTINCT oid)).
INSERT INTO customers (cid, name) VALUES (1, 'Alice');
INSERT INTO customers (cid, name) VALUES (2, 'Bob');
INSERT INTO orders (oid, cid, amount) VALUES (100, 1, 200.0);
INSERT INTO orders (oid, cid, amount) VALUES (101, 1, 300.0);
INSERT INTO orders (oid, cid, amount) VALUES (100, 2, 400.0);
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