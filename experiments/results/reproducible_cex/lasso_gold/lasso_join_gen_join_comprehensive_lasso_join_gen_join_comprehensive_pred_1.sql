-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, amount REAL, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "name") VALUES (1012, 'Daniel Wagner');
INSERT INTO "customers" ("customer_id", "name") VALUES (1015, 'Cristian Santos');
INSERT INTO "orders" ("order_id", "customer_id", "amount") VALUES (1013, 1012, 1014.5);
INSERT INTO "orders" ("order_id", "customer_id", "amount") VALUES (1016, 1015, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.name, SUM(o.amount) FROM Customers AS c INNER JOIN Orders AS o ON c.customer_id = o.customer_id GROUP BY c.name;

/*
Gold Result:
('Cristian Santos', None)
('Daniel Wagner', 1014.5)
*/

-- Prediction Query
SELECT c.name, SUM(o.amount) FROM Customers AS c CROSS JOIN Orders AS o GROUP BY c.name;

/*
Prediction Result:
('Cristian Santos', 1014.5)
('Daniel Wagner', 1014.5)
*/