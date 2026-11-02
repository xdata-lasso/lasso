-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, amount REAL, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Customers (customer_id, name) VALUES (1, 'Alice');
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
('Alice', None)
*/