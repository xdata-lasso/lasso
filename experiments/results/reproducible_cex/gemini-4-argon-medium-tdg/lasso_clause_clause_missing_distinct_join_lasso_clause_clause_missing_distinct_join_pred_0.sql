-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, order_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Customers (customer_id, name) VALUES (1, 'Alice');
INSERT INTO Customers (customer_id, name) VALUES (2, 'Bob');
INSERT INTO Customers (customer_id, name) VALUES (3, 'Alice');
INSERT INTO Customers (customer_id, name) VALUES (4, 'Charlie');
INSERT INTO Customers (customer_id, name) VALUES (5, NULL);
INSERT INTO Orders (order_id, customer_id, order_date) VALUES (101, 1, '2023-01-01');
INSERT INTO Orders (order_id, customer_id, order_date) VALUES (102, 1, '2023-01-02');
INSERT INTO Orders (order_id, customer_id, order_date) VALUES (103, 3, '2023-01-03');
INSERT INTO Orders (order_id, customer_id, order_date) VALUES (104, 5, '2023-01-04');
INSERT INTO Orders (order_id, customer_id, order_date) VALUES (105, NULL, '2023-01-05');
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
(4,)
*/