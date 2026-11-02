-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (-563, -563, '0998-06-17', '0998-06-17');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT ROUND(IMMEDIATE_PERCENTAGE, 2) AS IMMEDIATE_PERCENTAGE FROM (SELECT 100 * (CAST(IMMEDIATE AS REAL) / (IMMEDIATE + SCHEDULED)) AS IMMEDIATE_PERCENTAGE FROM (SELECT SUM(CASE WHEN CUSTOMER_PREF_DELIVERY_DATE = ORDER_DATE THEN 1 ELSE 0 END) AS IMMEDIATE, SUM(CASE WHEN CUSTOMER_PREF_DELIVERY_DATE <> ORDER_DATE THEN 1 ELSE 0 END) AS SCHEDULED FROM DELIVERY) AS X) AS XX;

/*
Prediction Result:
(100.0,)
*/