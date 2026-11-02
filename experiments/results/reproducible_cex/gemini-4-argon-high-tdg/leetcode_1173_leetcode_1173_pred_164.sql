-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (10, 101, '2020-01-05', '2020-01-05');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (25, 102, '2020-01-06', '2020-01-06');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (40, 103, '2020-01-07', '2020-01-10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(66.67,)
*/

-- Prediction Query
WITH CTE AS (SELECT *, IIF(CUSTOMER_PREF_DELIVERY_DATE = ORDER_DATE, 1, 0) AS IMMEDIATE_D FROM DELIVERY GROUP BY DELIVERY_ID) SELECT ROUND(CAST(SUM(IMMEDIATE_D) AS REAL) / MAX(DELIVERY_ID) * 100, 2) AS IMMEDIATE_PERCENTAGE FROM CTE;

/*
Prediction Result:
(5.0,)
*/