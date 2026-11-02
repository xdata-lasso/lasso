-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (1, 99, '2023-01-01', '2023-01-02'), (-1, 1, '2023-01-02', NULL), (0, 2, '2023-01-02', '2023-01-02'), (2, -1, '2023-01-02', NULL), (101, 3, '2023-01-02', '2023-01-02'), (100, 101, '2023-01-01', NULL), (99, 3, '2023-01-02', NULL), (3, 2, '2023-01-01', '2023-01-02'), (4, 2, '2023-01-02', '2023-01-02'), (5, 100, NULL, '2023-01-02'), (6, 3, '2023-01-02', '2023-01-02'), (7, 0, '2023-01-02', NULL), (8, NULL, '2023-01-01', '2023-01-01'), (9, 101, '2023-01-02', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(35.71,)
*/

-- Prediction Query
SELECT ROUND(CAST((SELECT COUNT(CUSTOMER_ID) FROM DELIVERY WHERE ORDER_DATE = CUSTOMER_PREF_DELIVERY_DATE) AS REAL) / (SELECT COUNT(CUSTOMER_ID) FROM DELIVERY) * 100, 2) AS IMMEDIATE_PERCENTAGE;

/*
Prediction Result:
(30.77,)
*/