-- Schema DDL
CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, order_date DATE, total_amount REAL, tax_rate REAL, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, discount_rate REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Customers (customer_id, name, discount_rate) VALUES (1, 'Alice', 0.1);
INSERT INTO Customers (customer_id, name, discount_rate) VALUES (2, 'Bob', 0.2);
INSERT INTO Customers (customer_id, name, discount_rate) VALUES (3, 'Charlie', 0.5);
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, tax_rate) VALUES (101, 1, '2023-01-01', 100.0, 2.0);
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, tax_rate) VALUES (102, 1, '2023-01-02', 200.0, 0.1);
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, tax_rate) VALUES (103, 2, '2023-01-03', 200.0, 0.2);
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, tax_rate) VALUES (104, 3, '2023-01-04', 250.0, 0.2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.name, o.total_amount FROM Orders AS o JOIN Customers AS c ON o.customer_id = c.customer_id WHERE o.total_amount * (1 - c.discount_rate) + (o.total_amount * o.tax_rate) > (SELECT total_amount * 2 FROM Orders WHERE tax_rate = 2);

/*
Gold Result:
('Alice', 100.0)
*/

-- Prediction Query
SELECT c.name, o.total_amount FROM Orders AS o JOIN Customers AS c ON o.customer_id = c.customer_id WHERE o.total_amount * (1 - c.discount_rate) - (o.total_amount * o.tax_rate) > (SELECT total_amount * 2 FROM Orders WHERE tax_rate = 2);

/*
Prediction Result:
*/