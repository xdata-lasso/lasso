-- Schema DDL
CREATE TABLE customers (cid INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE orders (oid INTEGER, cid INTEGER, amount REAL, PRIMARY KEY (oid, cid), FOREIGN KEY (cid) REFERENCES customers (cid));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("cid", "name") VALUES (1039, 'Lisa Jackson');
INSERT INTO "customers" ("cid", "name") VALUES (1043, 'Margaret Hawkins DDS');
INSERT INTO "orders" ("oid", "cid", "amount") VALUES (1040, 1039, 100.0);
INSERT INTO "orders" ("oid", "cid", "amount") VALUES (1042, 1039, 100.0);
INSERT INTO "orders" ("oid", "cid", "amount") VALUES (1044, 1043, 100.0);
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