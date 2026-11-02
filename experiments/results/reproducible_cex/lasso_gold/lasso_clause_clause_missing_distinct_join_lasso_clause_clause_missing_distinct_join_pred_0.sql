-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, order_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "name") VALUES (1007, 'Cristian Santos');
INSERT INTO "customers" ("customer_id", "name") VALUES (1009, 'Cristian Santos');
INSERT INTO "orders" ("order_id", "customer_id", "order_date") VALUES (1008, 1007, '1972-03-03');
INSERT INTO "orders" ("order_id", "customer_id", "order_date") VALUES (1010, 1009, '1973-04-04');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT c.name) FROM Customers AS c JOIN Orders AS o ON c.customer_id = o.customer_id;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(c.customer_id) FROM Customers AS c JOIN Orders AS o ON c.customer_id = o.customer_id;

/*
Prediction Result:
(2,)
*/