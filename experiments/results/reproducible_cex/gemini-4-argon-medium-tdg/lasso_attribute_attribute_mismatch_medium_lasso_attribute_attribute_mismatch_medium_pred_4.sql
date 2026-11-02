-- Schema DDL
CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, order_date DATE, shipped_date DATE, delivery_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Orders (order_id, customer_id, order_date, shipped_date, delivery_date) VALUES (101, 2023, '2022-12-28', '2023-01-01', '2024-01-05');
INSERT INTO Orders (order_id, customer_id, order_date, shipped_date, delivery_date) VALUES (102, 2023, '2023-05-15', '2022-12-31', '2023-06-01');
INSERT INTO Orders (order_id, customer_id, order_date, shipped_date, delivery_date) VALUES (103, 500, '2023-01-01', NULL, '2023-01-10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT order_id FROM Orders WHERE STRFTIME('%Y', shipped_date) = '2023';

/*
Gold Result:
(101,)
*/

-- Prediction Query
SELECT order_date FROM Orders WHERE STRFTIME('%Y', shipped_date) = '2023';

/*
Prediction Result:
('2022-12-28',)
*/