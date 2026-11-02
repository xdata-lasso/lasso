-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, amount REAL, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Customers (customer_id, name) VALUES (1, 'Alice');
INSERT INTO Customers (customer_id, name) VALUES (2, 'Bob');
INSERT INTO Customers (customer_id, name) VALUES (3, 'Charlie');
INSERT INTO Orders (order_id, customer_id, amount) VALUES (101, 1, 50.0);
INSERT INTO Orders (order_id, customer_id, amount) VALUES (102, 1, 25.5);
INSERT INTO Orders (order_id, customer_id, amount) VALUES (103, 2, 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.name, SUM(o.amount) FROM Customers AS c INNER JOIN Orders AS o ON c.customer_id = o.customer_id GROUP BY c.name;

/*
Gold Result:
('Alice', 75.5)
('Bob', 100.0)
*/

-- Prediction Query
SELECT c.name, SUM(o.amount) FROM Customers AS c LEFT JOIN Orders AS o ON c.customer_id = o.customer_id GROUP BY c.name;

/*
Prediction Result:
('Alice', 75.5)
('Bob', 100.0)
('Charlie', None)
*/