-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (1, 1, '2023-01-01', '2023-01-01');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (2, 1, NULL, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(SUM(IMM_FLAG) AS REAL) / (SUM(SCHE_FLAG) + SUM(IMM_FLAG)) * 100, 2) AS IMMEDIATE_PERCENTAGE FROM (SELECT DELIVERY_ID, CASE WHEN (ORDER_DATE = CUSTOMER_PREF_DELIVERY_DATE) THEN 1 ELSE 0 END AS IMM_FLAG, CASE WHEN (ORDER_DATE <> CUSTOMER_PREF_DELIVERY_DATE) THEN 1 ELSE 0 END AS SCHE_FLAG FROM DELIVERY GROUP BY 1) AS M;

/*
Prediction Result:
(100.0,)
*/