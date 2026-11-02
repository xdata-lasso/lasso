-- Schema DDL
CREATE TABLE "customers" ("id" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "orders" ("id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "item" TEXT, FOREIGN KEY ("customer_id") REFERENCES "customers" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (1, 'Alice');
INSERT INTO orders (id, customer_id, item) VALUES (1, 1, 'Book');
INSERT INTO orders (id, customer_id, item) VALUES (2, 1, 'Pen');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(c.id) FROM customers AS c INNER JOIN orders AS o ON c.id = o.customer_id;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT c.id) FROM customers AS c WHERE c.id IN (SELECT customer_id FROM orders);

/*
Prediction Result:
(1,)
*/