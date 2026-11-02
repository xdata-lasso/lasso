-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (1, 1, '2020-01-01', '2020-01-01');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (2, 2, '2020-01-01', '2020-01-02');
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (3, 3, '2020-01-01 00:00:00', '2020-01-01 12:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(33.33,)
*/

-- Prediction Query
WITH CTE AS (SELECT DELIVERY_ID, (CASE WHEN CAST((JULIANDAY(ORDER_DATE) - JULIANDAY(CUSTOMER_PREF_DELIVERY_DATE)) AS INTEGER) = 0 THEN 1 ELSE 0 END) AS FLAG FROM DELIVERY) SELECT ROUND(CAST(SUM(FLAG) AS REAL) / COUNT(FLAG), 4) * 100 AS IMMEDIATE_PERCENTAGE FROM CTE;

/*
Prediction Result:
(66.67,)
*/