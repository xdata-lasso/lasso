-- Schema DDL
CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, order_date DATE, shipped_date DATE, delivery_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO orders (order_id, customer_id, order_date, shipped_date, delivery_date) VALUES (1, 0, '2023-10-27', '2023-10-27', '2023-10-27'), (0, NULL, '2023-01-02', '2023-10-27', '2023-01-01'), (2, 1, '2023-10-27', '2023-10-27', NULL), (3, 1, '2023-01-01', NULL, '2023-01-01');
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
SELECT order_id FROM Orders WHERE STRFTIME('%Y', delivery_date) = '2023';

/*
Prediction Result:
(0,)
(1,)
(3,)
*/