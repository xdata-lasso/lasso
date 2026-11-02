-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (100, 0, '2023-01-02', '2023-01-02'), (0, 0, '2023-01-02', NULL), (-1, -1, '2023-01-02', NULL), (1, 3, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(25.0,)
*/

-- Prediction Query
SELECT ROUND((CAST(A.SUM1 AS REAL) / B.SUM2) * 100, 2) AS IMMEDIATE_PERCENTAGE FROM (SELECT COUNT(*) AS SUM1 FROM DELIVERY WHERE CUSTOMER_PREF_DELIVERY_DATE = ORDER_DATE) AS A CROSS JOIN (SELECT COUNT(ORDER_DATE) AS SUM2 FROM DELIVERY) AS B;

/*
Prediction Result:
(33.33,)
*/