-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 7
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (1, NULL, '2022-01-01', '2022-01-01');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (2, 1, '2022-01-02', '2022-01-05');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (3, 2, '2022-01-03', NULL);
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (4, 3, '2022-01-04', '2022-01-04');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT ROUND(IMMEDIATE_PERCENTAGE, 2) AS IMMEDIATE_PERCENTAGE FROM (SELECT 100 * (CAST(IMMEDIATE AS REAL) / (IMMEDIATE + SCHEDULED)) AS IMMEDIATE_PERCENTAGE FROM (SELECT SUM(CASE WHEN CUSTOMER_PREF_DELIVERY_DATE = ORDER_DATE THEN 1 ELSE 0 END) AS IMMEDIATE, SUM(CASE WHEN CUSTOMER_PREF_DELIVERY_DATE <> ORDER_DATE THEN 1 ELSE 0 END) AS SCHEDULED FROM DELIVERY) AS X) AS XX;

/*
Prediction Result:
(66.67,)
*/