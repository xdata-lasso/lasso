-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (6, NULL, '0998-06-17', '1002-03-09');
INSERT INTO "Delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (15, 16, '0998-12-09', '0998-12-09');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
WITH CTE_TOTAL AS (SELECT COUNT(DELIVERY_ID) AS TOTAL_DELIVERIES FROM DELIVERY) SELECT COALESCE(ROUND(CAST(100 * COUNT(DELIVERY_ID) AS REAL) / TOTAL_DELIVERIES, 2), 0) AS IMMEDIATE_PERCENTAGE FROM DELIVERY CROSS JOIN CTE_TOTAL WHERE CUSTOMER_PREF_DELIVERY_DATE = ORDER_DATE;

/*
Prediction Result:
(50.0,)
*/