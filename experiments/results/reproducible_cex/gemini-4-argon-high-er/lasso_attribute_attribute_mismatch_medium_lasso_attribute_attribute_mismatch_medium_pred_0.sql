-- Schema DDL
CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, order_date DATE, shipped_date DATE, delivery_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Orders (order_id, customer_id, order_date, shipped_date, delivery_date) VALUES (1, 100, '2022-12-31', '2023-01-02', '2023-01-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT order_id FROM Orders WHERE STRFTIME('%Y', shipped_date) = '2023';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT order_id FROM Orders WHERE STRFTIME('%Y', order_date) = '2023';

/*
Prediction Result:
*/