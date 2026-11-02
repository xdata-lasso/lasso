-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, amount REAL, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "name") VALUES (1, 'c_s_b88b0f');

INSERT INTO "customers" ("customer_id", "name") VALUES (-2147483647, 'c_s_b88b0f');

INSERT INTO "customers" ("customer_id", "name") VALUES (2, 'c_s_b88b0f');

INSERT INTO "customers" ("customer_id", "name") VALUES (3, 'c_s_b88b0f');

INSERT INTO "customers" ("customer_id", "name") VALUES (4, 'c_s_b88b0f');

INSERT INTO "customers" ("customer_id", "name") VALUES (5, 'swwqcgsk');

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "customer_id", "amount") VALUES (-2147483648, 1, 582.588439);

INSERT INTO "orders" ("order_id", "customer_id", "amount") VALUES (-2147483647, 1, 680.190136);

INSERT INTO "orders" ("order_id", "customer_id", "amount") VALUES (-2147483646, 1, 487.053947);

INSERT INTO "orders" ("order_id", "customer_id", "amount") VALUES (-2147483645, 5, 572.766956);

INSERT INTO "orders" ("order_id", "customer_id", "amount") VALUES (-2147483644, 5, 206.939346);

INSERT INTO "orders" ("order_id", "customer_id", "amount") VALUES (-2147483643, 5, 604.777832);

INSERT INTO "orders" ("order_id", "customer_id", "amount") VALUES (2, 1, 874.871895);

INSERT INTO "orders" ("order_id", "customer_id", "amount") VALUES (3, 1, 475.173408);

INSERT INTO "orders" ("order_id", "customer_id", "amount") VALUES (-2147483640, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "amount") VALUES (-2147483639, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "amount") VALUES (-2147483638, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "amount") VALUES (-2147483637, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "amount") VALUES (-2147483636, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "amount") VALUES (-2147483635, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "amount") VALUES (-2147483634, 1, NULL);

INSERT INTO "orders" ("order_id", "customer_id", "amount") VALUES (-2147483633, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.name, SUM(o.amount) FROM Customers AS c INNER JOIN Orders AS o ON c.customer_id = o.customer_id GROUP BY c.name;

/*
Gold Result:
('c_s_b88b0f', 3099.877825)
('swwqcgsk', 1384.484134)
*/

-- Prediction Query
SELECT c.name, SUM(o.amount) FROM Customers AS c INNER JOIN Orders AS o ON c.customer_id = o.order_id GROUP BY c.name;

/*
Prediction Result:
('c_s_b88b0f', 2030.235439)
*/