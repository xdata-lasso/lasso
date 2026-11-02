-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (1, NULL, '2020-01-01', '2020-01-01');
INSERT INTO "Delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (2, 1, '2020-01-01', '2020-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
WITH TOT AS (SELECT COUNT(CUSTOMER_ID) AS NB_TOT FROM DELIVERY), IMMEDIATE_NUM AS (SELECT COUNT(CUSTOMER_ID) AS NB_IMMEDIATE FROM DELIVERY WHERE ORDER_DATE = CUSTOMER_PREF_DELIVERY_DATE) SELECT ROUND(CAST(NB_IMMEDIATE AS REAL) / NB_TOT * 100, 2) AS IMMEDIATE_PERCENTAGE FROM IMMEDIATE_NUM CROSS JOIN TOT;

/*
Prediction Result:
(0.0,)
*/