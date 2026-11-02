-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, amount REAL, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Customers (customer_id, name) VALUES (1, 'ActiveCustomer');
INSERT INTO Customers (customer_id, name) VALUES (2, 'UnmatchedCustomer');
INSERT INTO Orders (order_id, customer_id, amount) VALUES (101, 1, 75.5);
INSERT INTO Orders (order_id, customer_id, amount) VALUES (102, NULL, 99.99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.name, SUM(o.amount) FROM Customers AS c INNER JOIN Orders AS o ON c.customer_id = o.customer_id GROUP BY c.name;

/*
Gold Result:
('ActiveCustomer', 75.5)
*/

-- Prediction Query
SELECT c.name, SUM(o.amount) FROM Customers AS c LEFT JOIN Orders AS o ON c.customer_id = o.customer_id GROUP BY c.name;

/*
Prediction Result:
('ActiveCustomer', 75.5)
('UnmatchedCustomer', None)
*/