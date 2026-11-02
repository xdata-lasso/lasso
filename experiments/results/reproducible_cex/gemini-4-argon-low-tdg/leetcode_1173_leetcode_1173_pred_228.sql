-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 7
-- Tests order_date > customer_pref_delivery_date (allowed by SQLite DDL due to string literal in CHECK constraint; catches < or <= mutants vs =).
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (1, 701, '2023-07-05', '2023-07-01');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (2, 702, '2023-07-02', '2023-07-02');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (3, 703, '2023-07-01', '2023-07-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(33.33,)
*/

-- Prediction Query
SELECT ROUND((SELECT AVG(CASE WHEN ORDER_DATE >= CUSTOMER_PREF_DELIVERY_DATE THEN 1 ELSE 0 END) * 100 FROM DELIVERY), 2) AS IMMEDIATE_PERCENTAGE;

/*
Prediction Result:
(66.67,)
*/