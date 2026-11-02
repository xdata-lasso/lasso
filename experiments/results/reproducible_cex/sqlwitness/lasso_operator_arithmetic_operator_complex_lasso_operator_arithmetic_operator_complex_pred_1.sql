-- Schema DDL
CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, order_date DATE, total_amount REAL, tax_rate REAL, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, discount_rate REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, name, discount_rate) VALUES (0, NULL, 0.0), (2, 'default1', 2.0), (1, NULL, 0.0), (3, 'default2', 1.0), (4, NULL, 0.0), (5, 'default1', 1.0), (6, 'default2', 1.0), (7, NULL, 3.0), (8, NULL, 0.0);
INSERT INTO orders (order_id, customer_id, order_date, total_amount, tax_rate) VALUES (2, 4, '2023-01-02', 2.0, 3.0), (3, 3, '2023-01-01', 1.0, 0.0), (0, 5, '2023-01-02', 3.0, 3.0), (1, 5, '2023-01-02', 0.0, 3.0), (4, NULL, '2023-01-01', NULL, NULL), (5, NULL, '2023-01-01', 3.0, 1.0), (6, 0, NULL, 1.0, 3.0), (7, 8, NULL, NULL, NULL), (8, 8, '2023-01-01', NULL, 1.0), (9, 8, NULL, NULL, 3.0), (10, 8, NULL, 2.0, NULL), (11, 8, NULL, 3.0, NULL), (12, 2, NULL, 3.0, 3.0), (13, 2, NULL, 0.0, 2.0), (14, 1, '2023-01-01', 1.0, 1.0), (15, 1, NULL, 3.0, 3.0), (16, 3, '2023-01-01', NULL, 3.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.name, o.total_amount FROM Orders AS o JOIN Customers AS c ON o.customer_id = c.customer_id WHERE o.total_amount * (1 - c.discount_rate) + (o.total_amount * o.tax_rate) > (SELECT total_amount * 2 FROM Orders WHERE tax_rate = 2);

/*
Gold Result:
('default1', 3.0)
(None, 2.0)
(None, 1.0)
('default1', 3.0)
(None, 1.0)
(None, 3.0)
*/

-- Prediction Query
SELECT c.name, o.total_amount FROM Orders AS o JOIN Customers AS c ON o.customer_id = c.customer_id WHERE o.total_amount * (1 - c.discount_rate) + (o.total_amount / o.tax_rate) > (SELECT total_amount * 2 FROM Orders WHERE tax_rate = 2);

/*
Prediction Result:
('default1', 3.0)
(None, 2.0)
(None, 1.0)
(None, 1.0)
(None, 3.0)
*/