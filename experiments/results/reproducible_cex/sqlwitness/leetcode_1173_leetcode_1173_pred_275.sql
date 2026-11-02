-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (99, 100, NULL, '2023-01-02'), (6, 1, NULL, NULL), (4, 0, '2023-01-01', '2023-01-02'), (101, 100, '2023-01-01', '2023-01-02'), (100, 0, NULL, '2023-01-01'), (-1, NULL, '2023-01-02', NULL), (1, 4, '2023-01-01', '2023-01-01'), (0, 3, '2023-01-02', '2023-01-02'), (2, 99, '2023-01-01', '2023-01-02'), (3, 3, '2023-01-02', '2023-01-02'), (5, 3, NULL, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(27.27,)
*/

-- Prediction Query
SELECT CAST(CAST(100 * COUNT(DELIVERY_ID) AS REAL) / (SELECT COUNT(DELIVERY_ID) FROM DELIVERY) AS REAL(5, 2)) AS IMMEDIATE_PERCENTAGE FROM DELIVERY WHERE ORDER_DATE = CUSTOMER_PREF_DELIVERY_DATE;

/*
Prediction Result:
(27.272727272727273,)
*/