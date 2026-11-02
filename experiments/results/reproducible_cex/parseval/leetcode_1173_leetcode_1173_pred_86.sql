-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: delivery --
INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (1, -55602865, '2025-06-13', '2023-03-15');

INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (2, -664303813, '2024-06-15', '2024-06-15');

INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (3, -55602865, '2024-06-15', '2024-06-15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(66.67,)
*/

-- Prediction Query
SELECT CAST((CAST(COUNT(DISTINCT CASE WHEN ORDER_DATE = CUSTOMER_PREF_DELIVERY_DATE THEN DELIVERY_ID ELSE NULL END) AS REAL) / COUNT(DISTINCT DELIVERY_ID)) * 100 AS REAL(5, 2)) AS IMMEDIATE_PERCENTAGE FROM DELIVERY;

/*
Prediction Result:
(66.66666666666666,)
*/