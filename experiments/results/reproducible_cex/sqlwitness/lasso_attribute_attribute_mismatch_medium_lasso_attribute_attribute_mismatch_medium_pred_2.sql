-- Schema DDL
CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, order_date DATE, shipped_date DATE, delivery_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO orders (order_id, customer_id, order_date, shipped_date, delivery_date) VALUES (1, 0, '2023-01-01', '2023-01-01', '2023-01-02'), (0, 1, NULL, '2023-10-27', '2023-01-02'), (2, 1, '2023-01-02', '2023-01-01', '2023-01-01'), (3, 1, NULL, NULL, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT order_id FROM Orders WHERE STRFTIME('%Y', shipped_date) = '2023';

/*
Gold Result:
(0,)
(1,)
(2,)
*/

-- Prediction Query
SELECT customer_id FROM Orders WHERE STRFTIME('%Y', shipped_date) = '2023';

/*
Prediction Result:
(1,)
(0,)
(1,)
*/