-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (1036, 1037, '1970-01-01', '1970-01-01');
INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (1038, 1039, '1970-01-01', '1970-01-01');
INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (1041, 1037, '1970-01-01', '1970-01-0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(66.67,)
*/

-- Prediction Query
SELECT ROUND((SELECT AVG(CASE WHEN ORDER_DATE >= CUSTOMER_PREF_DELIVERY_DATE THEN 1 ELSE 0 END) * 100 FROM DELIVERY), 2) AS IMMEDIATE_PERCENTAGE;

/*
Prediction Result:
(100.0,)
*/