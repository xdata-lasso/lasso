-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (5, 797, '1002-03-09', '1002-03-09');
INSERT INTO "Delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (4, 797, '0998-12-09', '0998-12-09');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
WITH NEW AS (SELECT CASE WHEN ORDER_DATE = CUSTOMER_PREF_DELIVERY_DATE THEN 1 ELSE 0 END AS IMMEDIATE, CASE WHEN ORDER_DATE <> CUSTOMER_PREF_DELIVERY_DATE THEN 1 ELSE 0 END AS SCHEDULED FROM DELIVERY) SELECT ROUND(CAST(SUM(IMMEDIATE) AS REAL) / SUM(IMMEDIATE + SCHEDULED) * 100, 2) AS IMMEDIATE_PERCENTAGE FROM NEW;

/*
Prediction Result:
(100.0,)
*/