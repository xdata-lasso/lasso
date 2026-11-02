-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (8, 14, '1002-03-09', NULL);
INSERT INTO "Delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (18, NULL, '0998-06-30', '0998-06-30');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
WITH C AS (SELECT DELIVERY_ID FROM DELIVERY WHERE ORDER_DATE = CUSTOMER_PREF_DELIVERY_DATE) SELECT ROUND(CAST(COUNT(C.DELIVERY_ID) AS REAL) / COUNT(D.DELIVERY_ID) * 100, 2) AS IMMEDIATE_PERCENTAGE FROM DELIVERY AS D LEFT JOIN C ON D.DELIVERY_ID = C.DELIVERY_ID;

/*
Prediction Result:
(50.0,)
*/