-- Schema DDL
CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, order_date DATE, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, name) VALUES (0, 'default2'), (1, 'default1');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (1, 1, '2023-01-02'), (0, 0, NULL), (2, 0, '2023-01-02'), (3, 1, '2023-01-01'), (4, 1, '2023-01-01');
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
(5,)
*/