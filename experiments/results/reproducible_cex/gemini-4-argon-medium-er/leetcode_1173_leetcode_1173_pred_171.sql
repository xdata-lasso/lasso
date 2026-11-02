-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (1, 1, '2020-01-01 01:00:00', '2020-01-01 02:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH IM AS (SELECT DELIVERY_ID FROM DELIVERY GROUP BY DELIVERY_ID HAVING SUM(CASE WHEN ABS(CAST((JULIANDAY(ORDER_DATE) - JULIANDAY(CUSTOMER_PREF_DELIVERY_DATE)) AS INTEGER)) = 0 THEN 1 ELSE 0 END) = 1) SELECT ROUND((CAST(COUNT(IM.DELIVERY_ID) AS REAL) / COUNT(*)) * 100, 2) AS IMMEDIATE_PERCENTAGE FROM DELIVERY AS D LEFT JOIN IM ON D.DELIVERY_ID = IM.DELIVERY_ID;

/*
Prediction Result:
(100.0,)
*/