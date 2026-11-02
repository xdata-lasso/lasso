-- Schema DDL
CREATE TABLE "customers" ("id" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "orders" ("id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "item" TEXT, FOREIGN KEY ("customer_id") REFERENCES "customers" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customers (id, name) VALUES (10, 'Alice');
INSERT INTO customers (id, name) VALUES (20, 'Bob');
INSERT INTO customers (id, name) VALUES (30, 'Charlie');
INSERT INTO orders (id, customer_id, item) VALUES (101, 10, 'Book');
INSERT INTO orders (id, customer_id, item) VALUES (102, 10, 'Pen');
INSERT INTO orders (id, customer_id, item) VALUES (103, 10, 'Notebook');
INSERT INTO orders (id, customer_id, item) VALUES (104, NULL, 'OrphanItem');
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
(1,)
*/