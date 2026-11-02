-- Schema DDL
CREATE TABLE "customers" ("id" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "orders" ("id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "item" TEXT, FOREIGN KEY ("customer_id") REFERENCES "customers" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: 1-to-many relationship (kills COUNT(DISTINCT c.id)), unmatched customer (kills LEFT JOIN, COUNT(customers)), NULL customer_id in orders (kills RIGHT JOIN, COUNT(*) on orders), NULL in non-key columns (kills COUNT(c.name) or COUNT(o.item)), and non-overlapping order IDs vs customer IDs (kills ON c.id = o.id).
INSERT INTO "customers" ("id", "name") VALUES (1, 'Alice');
INSERT INTO "customers" ("id", "name") VALUES (2, NULL);
INSERT INTO "customers" ("id", "name") VALUES (3, 'Charlie');
INSERT INTO "orders" ("id", "customer_id", "item") VALUES (10, 1, 'Book');
INSERT INTO "orders" ("id", "customer_id", "item") VALUES (20, 1, NULL);
INSERT INTO "orders" ("id", "customer_id", "item") VALUES (30, 2, 'Pen');
INSERT INTO "orders" ("id", "customer_id", "item") VALUES (40, NULL, 'Laptop');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(c.id) FROM customers AS c INNER JOIN orders AS o ON c.id = o.customer_id;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT c.id) FROM customers AS c WHERE c.id IN (SELECT customer_id FROM orders);

/*
Prediction Result:
(2,)
*/