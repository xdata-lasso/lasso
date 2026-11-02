-- Schema DDL
CREATE TABLE "customers" ("id" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "orders" ("id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "item" TEXT, FOREIGN KEY ("customer_id") REFERENCES "customers" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("id", "name") VALUES (1, '5k5swwqcgs');

INSERT INTO "customers" ("id", "name") VALUES (2, '4');

INSERT INTO "customers" ("id", "name") VALUES (4, 'gu7v');

-- Inserting into table: orders --
INSERT INTO "orders" ("id", "customer_id", "item") VALUES (-2147483648, 1, '9n8');

INSERT INTO "orders" ("id", "customer_id", "item") VALUES (-2147483647, 4, 'e4');

INSERT INTO "orders" ("id", "customer_id", "item") VALUES (-2147483646, 4, 'hria2ypuzhs');

INSERT INTO "orders" ("id", "customer_id", "item") VALUES (-2147483645, 4, 'rwbbp6luhvd');

INSERT INTO "orders" ("id", "customer_id", "item") VALUES (2, 1, 'tti');

INSERT INTO "orders" ("id", "customer_id", "item") VALUES (3, 1, 'bnp');

INSERT INTO "orders" ("id", "customer_id", "item") VALUES (-2147483642, 1, 'mdpos');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(c.id) FROM customers AS c INNER JOIN orders AS o ON c.id = o.customer_id;

/*
Gold Result:
(7,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT c.id) FROM customers AS c WHERE c.id IN (SELECT customer_id FROM orders);

/*
Prediction Result:
(2,)
*/