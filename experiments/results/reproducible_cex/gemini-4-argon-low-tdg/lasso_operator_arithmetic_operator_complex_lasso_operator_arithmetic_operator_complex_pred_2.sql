-- Schema DDL
CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, order_date DATE, total_amount REAL, tax_rate REAL, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, discount_rate REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Core arithmetic, join, and boundary condition testing.
-- Subquery evaluates to: 100.0 * 2 = 200.0
-- Order 2: 200 * (1 - 0.1) + 200 * 0.1 = 180 + 20 = 200.0 (Exact boundary, tests > vs >=)
-- Order 3: 200 * (1 - 0.1) + 200 * 0.2 = 180 + 40 = 220.0 (Strictly greater, tests discount and tax arithmetic)
-- Order 4: 250 * (1 - 0.3) + 250 * 0.05 = 175 + 12.5 = 187.5 (Less than 200, tests high discount)
INSERT INTO Customers (customer_id, name, discount_rate) VALUES (1, 'SubqueryCust', 0.0);
INSERT INTO Customers (customer_id, name, discount_rate) VALUES (2, 'Alice', 0.1);
INSERT INTO Customers (customer_id, name, discount_rate) VALUES (3, 'Bob', 0.3);
INSERT INTO Customers (customer_id, name, discount_rate) VALUES (4, 'UnmatchedCust', 0.5);
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, tax_rate) VALUES (1, 1, '2023-01-01', 100.0, 2.0);
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, tax_rate) VALUES (2, 2, '2023-01-02', 200.0, 0.1);
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, tax_rate) VALUES (3, 2, '2023-01-03', 200.0, 0.2);
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, tax_rate) VALUES (4, 3, '2023-01-04', 250.0, 0.05);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.name, o.total_amount FROM Orders AS o JOIN Customers AS c ON o.customer_id = c.customer_id WHERE o.total_amount * (1 - c.discount_rate) + (o.total_amount * o.tax_rate) > (SELECT total_amount * 2 FROM Orders WHERE tax_rate = 2);

/*
Gold Result:
('SubqueryCust', 100.0)
('Alice', 200.0)
*/

-- Prediction Query
SELECT c.name, o.total_amount FROM Orders AS o JOIN Customers AS c ON o.customer_id = c.customer_id WHERE o.total_amount * (1 - c.discount_rate) + (o.total_amount * o.tax_rate) > (SELECT total_amount + 2 FROM Orders WHERE tax_rate = 2);

/*
Prediction Result:
('SubqueryCust', 100.0)
('Alice', 200.0)
('Alice', 200.0)
('Bob', 250.0)
*/