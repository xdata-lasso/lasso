-- Schema DDL
CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, order_date DATE, shipped_date DATE, delivery_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "shipped_date", "delivery_date") VALUES (1, -55602865, '2025-06-13', '2023-01-01', '2023-03-15');

INSERT INTO "orders" ("order_id", "customer_id", "order_date", "shipped_date", "delivery_date") VALUES (2, -55602865, '2025-06-13', '2020-03-31', '2023-03-15');

INSERT INTO "orders" ("order_id", "customer_id", "order_date", "shipped_date", "delivery_date") VALUES (3, -664303813, '2022-12-08', NULL, '2020-06-07');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT order_id FROM Orders WHERE STRFTIME('%Y', shipped_date) = '2023';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT customer_id FROM Orders WHERE STRFTIME('%Y', shipped_date) = '2023';

/*
Prediction Result:
(-55602865,)
*/