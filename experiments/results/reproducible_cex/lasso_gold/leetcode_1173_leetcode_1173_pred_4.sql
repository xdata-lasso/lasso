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
SELECT COALESCE(ROUND((CAST(COUNT(DISTINCT D1.DELIVERY_ID) AS REAL) / COUNT(DISTINCT D.DELIVERY_ID)) * 100, 2), 0) AS IMMEDIATE_PERCENTAGE FROM DELIVERY AS D CROSS JOIN (SELECT DELIVERY_ID FROM DELIVERY WHERE ORDER_DATE = CUSTOMER_PREF_DELIVERY_DATE) AS D1;

/*
Prediction Result:
(0,)
*/