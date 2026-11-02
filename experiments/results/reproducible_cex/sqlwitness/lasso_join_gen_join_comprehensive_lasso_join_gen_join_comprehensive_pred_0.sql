-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, amount REAL, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, name) VALUES (0, 'default1');
INSERT INTO orders (order_id, customer_id, amount) VALUES (0, NULL, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.name, SUM(o.amount) FROM Customers AS c INNER JOIN Orders AS o ON c.customer_id = o.customer_id GROUP BY c.name;

/*
Gold Result:
*/

-- Prediction Query
SELECT c.name, SUM(o.amount) FROM Customers AS c LEFT JOIN Orders AS o ON c.customer_id = o.customer_id GROUP BY c.name;

/*
Prediction Result:
('default1', None)
*/