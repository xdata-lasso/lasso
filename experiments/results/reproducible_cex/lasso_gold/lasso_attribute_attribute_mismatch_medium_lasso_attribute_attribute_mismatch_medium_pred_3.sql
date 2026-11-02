-- Schema DDL
CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, order_date DATE, shipped_date DATE, delivery_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "shipped_date", "delivery_date") VALUES (1001, 1002, '1970-01-01', '2023-01-01', '1971-02-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT order_id FROM Orders WHERE STRFTIME('%Y', shipped_date) = '2023';

/*
Gold Result:
(1001,)
*/

-- Prediction Query
SELECT shipped_date FROM Orders WHERE STRFTIME('%Y', shipped_date) = '2023';

/*
Prediction Result:
('2023-01-01',)
*/