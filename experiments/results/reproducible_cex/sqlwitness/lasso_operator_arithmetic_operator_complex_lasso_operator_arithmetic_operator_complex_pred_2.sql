-- Schema DDL
CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, order_date DATE, total_amount REAL, tax_rate REAL, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, discount_rate REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, name, discount_rate) VALUES (1, 'default1', NULL), (2, 'default2', 0.0);
INSERT INTO orders (order_id, customer_id, order_date, total_amount, tax_rate) VALUES (1, 1, '2023-01-01', 0.0, NULL), (2, 2, '2023-01-01', 1.0, 2.0), (3, 2, NULL, 2.0, 0.0), (0, NULL, '2023-01-02', 2.0, NULL), (4, 2, NULL, 0.0, NULL), (5, 1, '2023-01-01', 3.0, 3.0), (6, 1, '2023-01-01', NULL, NULL), (7, NULL, NULL, 1.0, NULL), (8, NULL, '2023-01-02', 0.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.name, o.total_amount FROM Orders AS o JOIN Customers AS c ON o.customer_id = c.customer_id WHERE o.total_amount * (1 - c.discount_rate) + (o.total_amount * o.tax_rate) > (SELECT total_amount * 2 FROM Orders WHERE tax_rate = 2);

/*
Gold Result:
('default2', 1.0)
*/

-- Prediction Query
SELECT c.name, o.total_amount FROM Orders AS o JOIN Customers AS c ON o.customer_id = c.customer_id WHERE o.total_amount * (1 - c.discount_rate) + (o.total_amount * o.tax_rate) > (SELECT total_amount + 2 FROM Orders WHERE tax_rate = 2);

/*
Prediction Result:
*/