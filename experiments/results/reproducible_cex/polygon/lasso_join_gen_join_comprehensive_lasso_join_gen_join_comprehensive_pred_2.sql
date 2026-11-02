-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, amount REAL, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "name") VALUES (10, NULL);
INSERT INTO "Customers" ("customer_id", "name") VALUES (11, '17');
INSERT INTO "Orders" ("order_id", "customer_id", "amount") VALUES (11, 10, 53);
INSERT INTO "Orders" ("order_id", "customer_id", "amount") VALUES (10, 10, 53);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.name, SUM(o.amount) FROM Customers AS c INNER JOIN Orders AS o ON c.customer_id = o.customer_id GROUP BY c.name;

/*
Gold Result:
(None, 106.0)
*/

-- Prediction Query
SELECT c.name, SUM(o.amount) FROM Customers AS c INNER JOIN Orders AS o ON c.customer_id = o.order_id GROUP BY c.name;

/*
Prediction Result:
(None, 53.0)
('17', 53.0)
*/