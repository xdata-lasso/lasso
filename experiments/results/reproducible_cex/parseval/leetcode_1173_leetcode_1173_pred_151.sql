-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: delivery --
INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (-2147483648, 1, '2024-06-15', '2024-06-15');

INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (-2147483647, 1, '2025-06-17', '2021-11-08');

INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (-2147483646, NULL, '2025-06-13', '2023-03-15');

INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (-2147483645, NULL, '2024-06-15', '2024-06-15');

INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (-2147483644, NULL, '2024-06-15', '2024-06-15');

INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (-2147483643, NULL, '2023-11-15', '2024-01-05');

INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (-2147483642, NULL, '2022-12-08', '2020-06-07');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(42.86,)
*/

-- Prediction Query
SELECT ROUND(CAST(IMMEDIATE AS REAL) / COUNT(D.CUSTOMER_ID) * 100, 2) AS IMMEDIATE_PERCENTAGE FROM (SELECT COUNT(A.CUSTOMER_ID) AS IMMEDIATE FROM DELIVERY AS A WHERE A.ORDER_DATE = A.CUSTOMER_PREF_DELIVERY_DATE) AS ABC CROSS JOIN DELIVERY AS D;

/*
Prediction Result:
(50.0,)
*/