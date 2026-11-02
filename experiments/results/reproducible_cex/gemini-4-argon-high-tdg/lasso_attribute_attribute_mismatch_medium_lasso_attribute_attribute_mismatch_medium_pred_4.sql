-- Schema DDL
CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, order_date DATE, shipped_date DATE, delivery_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Orders (order_id, customer_id, order_date, shipped_date, delivery_date) VALUES (1, 501, '2022-12-28', '2023-01-05', '2024-01-02');
INSERT INTO Orders (order_id, customer_id, order_date, shipped_date, delivery_date) VALUES (2, 502, '2023-12-29', '2024-01-03', '2024-01-10');
INSERT INTO Orders (order_id, customer_id, order_date, shipped_date, delivery_date) VALUES (3, 503, '2022-12-20', '2022-12-25', '2023-01-04');
INSERT INTO Orders (order_id, customer_id, order_date, shipped_date, delivery_date) VALUES (4, 504, '2023-06-10', '2023-06-15', '2023-06-20');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT order_id FROM Orders WHERE STRFTIME('%Y', shipped_date) = '2023';

/*
Gold Result:
(1,)
(4,)
*/

-- Prediction Query
SELECT order_date FROM Orders WHERE STRFTIME('%Y', shipped_date) = '2023';

/*
Prediction Result:
('2022-12-28',)
('2023-06-10',)
*/