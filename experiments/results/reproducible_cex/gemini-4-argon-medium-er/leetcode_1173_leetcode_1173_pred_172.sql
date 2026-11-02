-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (1, 1, '2020-01-01', '2020-01-01');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (2, 1, '2020-01-01', '2020-01-02');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (3, 1, '2020-01-01', '2020-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(33.33,)
*/

-- Prediction Query
WITH IMMEDIATE_COUNT AS (SELECT COUNT(*) AS I_C FROM DELIVERY WHERE ORDER_DATE = CUSTOMER_PREF_DELIVERY_DATE), TOTAL_COUNT AS (SELECT COUNT(*) AS T_C FROM DELIVERY) SELECT TRUNC((CAST(I_C AS REAL) / T_C * 100)) AS IMMEDIATE_PERCENTAGE FROM IMMEDIATE_COUNT CROSS JOIN TOTAL_COUNT;

/*
Prediction Result:
(33.0,)
*/