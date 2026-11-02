-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: delivery --
INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (-2147483648, -55602865, '2024-06-15', '2024-06-15');

INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (-2147483647, -59984348, '2024-06-15', '2024-06-15');

INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (2, -664303813, '2022-12-08', '2020-06-07');

INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (3, -1726781632, '2021-12-04', '2022-04-27');

INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (4, -1980249628, '2022-10-19', '2021-02-11');

INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (5, 809183447, '2025-11-03', '2023-09-09');

INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (6, -1865039888, '2021-05-05', '2023-01-06');

INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (7, -252690330, '2022-09-17', '2023-08-23');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(25.0,)
*/

-- Prediction Query
WITH MAIN AS (SELECT ROW_NUMBER() OVER () AS NUM FROM DELIVERY WHERE ORDER_DATE = CUSTOMER_PREF_DELIVERY_DATE) SELECT CASE WHEN ROUND(CAST((SELECT MAX(NUM) FROM MAIN) AS REAL) / (SELECT MAX(DELIVERY_ID) FROM DELIVERY) * 100, 2) IS NULL THEN 0.00 ELSE ROUND(CAST((SELECT MAX(NUM) FROM MAIN) AS REAL) / (SELECT MAX(DELIVERY_ID) FROM DELIVERY) * 100, 2) END AS IMMEDIATE_PERCENTAGE;

/*
Prediction Result:
(28.57,)
*/