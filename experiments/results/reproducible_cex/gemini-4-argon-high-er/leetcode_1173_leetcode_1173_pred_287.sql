-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (1, 1, '2020-01-01', '2020-01-01');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (2, 2, '2020-01-01', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
WITH ORDER_STATUS AS (SELECT SUM(CASE WHEN ORDER_DATE = CUSTOMER_PREF_DELIVERY_DATE THEN 1 ELSE 0 END) AS NUM_IMMEDIATE, SUM(CASE WHEN ORDER_DATE <> CUSTOMER_PREF_DELIVERY_DATE THEN 1 ELSE 0 END) AS NUM_SCHEDULED FROM DELIVERY) SELECT ROUND(CAST(NUM_IMMEDIATE AS REAL) / (NUM_IMMEDIATE + NUM_SCHEDULED) * 100, 2) AS IMMEDIATE_PERCENTAGE FROM ORDER_STATUS;

/*
Prediction Result:
(100.0,)
*/