-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: delivery --
INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (-2147483648, -55602865, '2024-06-15', '2024-06-15');

INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (-2147483647, -59984348, NULL, '2024-06-15');

INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (-2147483646, -664303813, '2024-06-15', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(33.33,)
*/

-- Prediction Query
WITH A AS (SELECT (ORDER_DATE = CUSTOMER_PREF_DELIVERY_DATE) AS NB FROM DELIVERY) SELECT ROUND(CAST(SUM(NB) AS REAL) / COUNT(NB) * 100, 2) AS IMMEDIATE_PERCENTAGE FROM A;

/*
Prediction Result:
(100.0,)
*/