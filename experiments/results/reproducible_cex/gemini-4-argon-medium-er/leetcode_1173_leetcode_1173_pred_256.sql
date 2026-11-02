-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (1, 1, '2020-01-01 01:00:00', '2020-01-01 02:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CASE WHEN A.DELIVERY_ID IS NULL THEN 0.00 ELSE ROUND((CAST(COUNT(A.DELIVERY_ID) AS REAL) / CNT * 100), 2) END AS IMMEDIATE_PERCENTAGE FROM DELIVERY AS A CROSS JOIN (SELECT COUNT(*) AS CNT FROM DELIVERY) AS B WHERE CAST((JULIANDAY(A.CUSTOMER_PREF_DELIVERY_DATE) - JULIANDAY(A.ORDER_DATE)) AS INTEGER) = 0;

/*
Prediction Result:
(100.0,)
*/