-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (1, 1, '2020-01-01', '2020-01-01');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (2, 2, NULL, '2020-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(COUNT(IMMEDIATE) AS REAL) / (COUNT(IMMEDIATE) + COUNT(SCHEDULED)) * 100, 2) AS IMMEDIATE_PERCENTAGE FROM (SELECT IIF(ORDER_DATE = CUSTOMER_PREF_DELIVERY_DATE, 'YES', NULL) AS IMMEDIATE, IIF(ORDER_DATE <> CUSTOMER_PREF_DELIVERY_DATE, 'YES', NULL) AS SCHEDULED FROM DELIVERY) AS NEW;

/*
Prediction Result:
(100.0,)
*/