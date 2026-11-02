-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (-1, 0, NULL, NULL), (3, 1, NULL, '2023-01-01'), (2, -1, NULL, '2023-01-02'), (100, 1, '2023-01-02', NULL), (0, 100, NULL, NULL), (1, NULL, NULL, '2023-01-01'), (99, 3, '2023-01-02', '2023-01-02'), (101, 0, NULL, '2023-01-02'), (4, 3, NULL, '2023-01-02'), (5, 100, '2023-01-02', '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(20.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(IMMEDIATE AS REAL) / COUNT(D.CUSTOMER_ID) * 100, 2) AS IMMEDIATE_PERCENTAGE FROM (SELECT COUNT(A.CUSTOMER_ID) AS IMMEDIATE FROM DELIVERY AS A WHERE A.ORDER_DATE = A.CUSTOMER_PREF_DELIVERY_DATE) AS ABC CROSS JOIN DELIVERY AS D;

/*
Prediction Result:
(22.22,)
*/