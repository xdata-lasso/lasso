-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, order_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Customers with multiple orders (kills missing DISTINCT on count).
-- 2. Different customers sharing the same name (kills counting customer_id instead of name).
-- 3. Customers with no orders (kills missing JOIN or LEFT JOIN without filter).
INSERT INTO Customers (customer_id, name) VALUES (1, 'Alice');
INSERT INTO Customers (customer_id, name) VALUES (2, 'Alice');
INSERT INTO Customers (customer_id, name) VALUES (3, 'Bob');
INSERT INTO Customers (customer_id, name) VALUES (4, 'Charlie');
INSERT INTO Customers (customer_id, name) VALUES (5, 'David');
INSERT INTO Orders (order_id, customer_id, order_date) VALUES (101, 1, '2023-01-01');
INSERT INTO Orders (order_id, customer_id, order_date) VALUES (102, 1, '2023-01-02');
INSERT INTO Orders (order_id, customer_id, order_date) VALUES (103, 2, '2023-01-03');
INSERT INTO Orders (order_id, customer_id, order_date) VALUES (104, 3, '2023-01-04');
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
(4,)
*/