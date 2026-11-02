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
SELECT IIF(B.PERCENTAGE IS NULL, 0, B.PERCENTAGE) AS IMMEDIATE_PERCENTAGE FROM (SELECT ROUND(CAST(COUNT(A.DELIVERY_ID) * 100 AS REAL) / A.TOTDELIVER, 2) AS PERCENTAGE FROM (SELECT *, COUNT(DELIVERY_ID) OVER () AS TOTDELIVER FROM DELIVERY) AS A WHERE A.ORDER_DATE = A.CUSTOMER_PREF_DELIVERY_DATE) AS B;

/*
Prediction Result:
(0,)
*/