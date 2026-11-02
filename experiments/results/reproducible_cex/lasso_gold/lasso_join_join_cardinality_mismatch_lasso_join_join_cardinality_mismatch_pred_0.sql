-- Schema DDL
CREATE TABLE "customers" ("id" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "orders" ("id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "item" TEXT, FOREIGN KEY ("customer_id") REFERENCES "customers" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("id", "name") VALUES (1027, 'Michele Williams');
INSERT INTO "customers" ("id", "name") VALUES (1031, 'Donald Reid');
INSERT INTO "orders" ("id", "customer_id", "item") VALUES (1028, 1027, 'drive');
INSERT INTO "orders" ("id", "customer_id", "item") VALUES (1030, 1027, 'trial');
INSERT INTO "orders" ("id", "customer_id", "item") VALUES (1032, 1031, 'his');
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