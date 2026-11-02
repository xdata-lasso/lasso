-- Schema DDL
CREATE TABLE customers (cid INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE orders (oid INTEGER, cid INTEGER, amount REAL, PRIMARY KEY (oid, cid), FOREIGN KEY (cid) REFERENCES customers (cid));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("cid", "name") VALUES (1, '5k5swwqcgs');

INSERT INTO "customers" ("cid", "name") VALUES (3, '9n8');

INSERT INTO "customers" ("cid", "name") VALUES (2, '4');

-- Inserting into table: orders --
INSERT INTO "orders" ("oid", "cid", "amount") VALUES (-2147483648, 1, 100.0);

INSERT INTO "orders" ("oid", "cid", "amount") VALUES (-2147483647, 2, 100.0);

INSERT INTO "orders" ("oid", "cid", "amount") VALUES (-2147483646, 2, 100.0);

INSERT INTO "orders" ("oid", "cid", "amount") VALUES (-2147483645, 2, 100.0);

INSERT INTO "orders" ("oid", "cid", "amount") VALUES (-2147483644, 2, 100.0);

INSERT INTO "orders" ("oid", "cid", "amount") VALUES (-2147483643, 1, 100.0);

INSERT INTO "orders" ("oid", "cid", "amount") VALUES (-2147483642, 1, 100.0);

INSERT INTO "orders" ("oid", "cid", "amount") VALUES (-2147483641, 1, 100.0);

INSERT INTO "orders" ("oid", "cid", "amount") VALUES (-2147483640, 1, 100.0);

INSERT INTO "orders" ("oid", "cid", "amount") VALUES (-2147483639, 1, 100.0);

INSERT INTO "orders" ("oid", "cid", "amount") VALUES (-2147483638, 1, 100.0);

INSERT INTO "orders" ("oid", "cid", "amount") VALUES (-2147483637, 1, 100.0);

INSERT INTO "orders" ("oid", "cid", "amount") VALUES (-2147483636, 1, 100.0);

INSERT INTO "orders" ("oid", "cid", "amount") VALUES (-2147483635, 1, 99.99);

INSERT INTO "orders" ("oid", "cid", "amount") VALUES (-2147483634, 1, 249.706432);

INSERT INTO "orders" ("oid", "cid", "amount") VALUES (-2147483633, 1, 99.523333);

INSERT INTO "orders" ("oid", "cid", "amount") VALUES (-2147483632, 1, 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(c.cid) FROM customers AS c INNER JOIN orders AS o ON c.cid = o.cid WHERE o.amount >= 100;

/*
Gold Result:
(15,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT c.cid) FROM customers AS c INNER JOIN orders AS o ON c.cid = o.cid WHERE o.amount >= 100;

/*
Prediction Result:
(2,)
*/