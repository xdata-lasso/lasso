-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO "Delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (1, 1, '2023-08-01', '2023-08-01');
INSERT INTO "Delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (2, 2, '2023-08-02', '2023-08-05');
INSERT INTO "Delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (3, NULL, '2023-08-03', '2023-08-10');
INSERT INTO "Delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (4, 3, NULL, '2023-08-12');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(25.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(100 * PART.IMMEDIATE AS REAL) / COUNT(ORDER_DATE), 2) AS IMMEDIATE_PERCENTAGE FROM DELIVERY AS D CROSS JOIN (SELECT COUNT(ORDER_DATE) AS IMMEDIATE FROM DELIVERY WHERE ORDER_DATE = CUSTOMER_PREF_DELIVERY_DATE) AS PART;

/*
Prediction Result:
(33.33,)
*/