-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (3, 100, NULL, '2023-01-02'), (-1, NULL, NULL, NULL), (1, NULL, '2023-01-02', '2023-01-02'), (2, NULL, NULL, '2023-01-01'), (0, -1, '2023-01-01', NULL), (100, 99, '2023-01-02', '2023-01-02'), (99, 99, '2023-01-02', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(28.57,)
*/

-- Prediction Query
SELECT ROUND((CAST(TEMP.IMMDEL AS REAL) / COUNT(DELIVERY.CUSTOMER_ID)) * 100, 2) AS IMMEDIATE_PERCENTAGE FROM (SELECT COUNT(CUSTOMER_ID) AS IMMDEL FROM DELIVERY WHERE ORDER_DATE = CUSTOMER_PREF_DELIVERY_DATE) AS TEMP CROSS JOIN DELIVERY;

/*
Prediction Result:
(25.0,)
*/