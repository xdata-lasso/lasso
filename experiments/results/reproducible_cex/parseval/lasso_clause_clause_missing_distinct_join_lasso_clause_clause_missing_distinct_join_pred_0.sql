-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, order_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "name") VALUES (1, '5k5swwqcgs');

INSERT INTO "customers" ("customer_id", "name") VALUES (3, '9n8c4pgu7v');

INSERT INTO "customers" ("customer_id", "name") VALUES (2, 'e4');

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "customer_id", "order_date") VALUES (-2147483648, 1, '2021-12-04');

INSERT INTO "orders" ("order_id", "customer_id", "order_date") VALUES (-2147483647, 2, '2021-05-05');

INSERT INTO "orders" ("order_id", "customer_id", "order_date") VALUES (-2147483646, 2, '2023-01-06');

INSERT INTO "orders" ("order_id", "customer_id", "order_date") VALUES (-2147483645, 2, '2021-07-04');

INSERT INTO "orders" ("order_id", "customer_id", "order_date") VALUES (2, 1, '2020-01-20');

INSERT INTO "orders" ("order_id", "customer_id", "order_date") VALUES (3, 1, '2024-12-12');

INSERT INTO "orders" ("order_id", "customer_id", "order_date") VALUES (-2147483642, 1, '2024-03-30');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT c.name) FROM Customers AS c JOIN Orders AS o ON c.customer_id = o.customer_id;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(c.customer_id) FROM Customers AS c JOIN Orders AS o ON c.customer_id = o.customer_id;

/*
Prediction Result:
(7,)
*/