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
SELECT COALESCE(ROUND(CAST((SELECT COUNT(DELIVERY_ID) FROM DELIVERY WHERE ORDER_DATE = CUSTOMER_PREF_DELIVERY_DATE) AS REAL) / (SELECT COUNT(DELIVERY_ID) FROM DELIVERY) * 100, 2), 0.00) AS IMMEDIATE_PERCENTAGE;

/*
Prediction Result:
(0.0,)
*/