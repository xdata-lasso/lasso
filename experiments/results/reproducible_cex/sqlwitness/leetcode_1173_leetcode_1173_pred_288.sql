-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (100, 0, '2023-01-01', '2023-01-01'), (5, 2, '2023-01-02', NULL), (0, NULL, '2023-01-02', '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(66.67,)
*/

-- Prediction Query
SELECT CAST(CAST(SUM(CASE WHEN ORDER_DATE = CUSTOMER_PREF_DELIVERY_DATE THEN 1 ELSE 0 END) AS REAL) / COUNT(1) * 100 AS REAL(5, 2)) AS IMMEDIATE_PERCENTAGE FROM DELIVERY;

/*
Prediction Result:
(66.66666666666666,)
*/