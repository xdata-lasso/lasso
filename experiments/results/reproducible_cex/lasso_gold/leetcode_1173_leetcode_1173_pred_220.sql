-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(None,)
*/

-- Prediction Query
WITH CTE_TOTAL AS (SELECT COUNT(DELIVERY_ID) AS TOTAL_DELIVERIES FROM DELIVERY) SELECT COALESCE(ROUND(CAST(100 * COUNT(DELIVERY_ID) AS REAL) / TOTAL_DELIVERIES, 2), 0) AS IMMEDIATE_PERCENTAGE FROM DELIVERY CROSS JOIN CTE_TOTAL WHERE CUSTOMER_PREF_DELIVERY_DATE = ORDER_DATE;

/*
Prediction Result:
(0,)
*/