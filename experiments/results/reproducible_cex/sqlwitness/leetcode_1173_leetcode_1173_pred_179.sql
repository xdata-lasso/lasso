-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (99, NULL, '2023-01-02', '2023-01-02'), (2, -1, '2023-01-01', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT ROUND(CAST((SELECT COUNT(CUSTOMER_ID) FROM DELIVERY WHERE ORDER_DATE - CUSTOMER_PREF_DELIVERY_DATE = 0) AS REAL) / COUNT(*) * 100, 2) AS IMMEDIATE_PERCENTAGE FROM DELIVERY;

/*
Prediction Result:
(0.0,)
*/