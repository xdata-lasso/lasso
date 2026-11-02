-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: delivery --
INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (1, -55602865, '2025-06-13', '2023-03-15');

INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (2, -664303813, '2022-12-08', '2020-06-07');

INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (3, -1726781632, '2021-12-04', '2022-04-27');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND((CAST((SELECT COUNT(DISTINCT DELIVERY_ID) FROM (SELECT DELIVERY_ID, CAST((JULIANDAY(CUSTOMER_PREF_DELIVERY_DATE) - JULIANDAY(ORDER_DATE)) AS INTEGER) AS DAYDIFF FROM DELIVERY) AS DD WHERE DD.DAYDIFF < 1) AS REAL) / COUNT(DISTINCT DELIVERY_ID)) * 100, 2) AS IMMEDIATE_PERCENTAGE FROM DELIVERY;

/*
Prediction Result:
(66.67,)
*/