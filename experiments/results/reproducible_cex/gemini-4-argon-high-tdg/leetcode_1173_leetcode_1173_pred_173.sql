-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (10, 101, '2020-01-05', '2020-01-05');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (25, 102, '2020-01-06', '2020-01-06');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (40, 103, '2020-01-07', '2020-01-10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(66.67,)
*/

-- Prediction Query
WITH MAIN AS (SELECT ROW_NUMBER() OVER () AS NUM FROM DELIVERY WHERE ORDER_DATE = CUSTOMER_PREF_DELIVERY_DATE) SELECT CASE WHEN ROUND(CAST((SELECT MAX(NUM) FROM MAIN) AS REAL) / (SELECT MAX(DELIVERY_ID) FROM DELIVERY) * 100, 2) IS NULL THEN 0.00 ELSE ROUND(CAST((SELECT MAX(NUM) FROM MAIN) AS REAL) / (SELECT MAX(DELIVERY_ID) FROM DELIVERY) * 100, 2) END AS IMMEDIATE_PERCENTAGE;

/*
Prediction Result:
(5.0,)
*/