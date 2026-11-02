-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES (4, 101, '2023-01-01', '2023-01-01'), (-1, 1, '2023-01-01', '2023-01-02'), (0, 100, '2023-01-02', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(33.33,)
*/

-- Prediction Query
SELECT CAST((CAST(COUNT(DISTINCT CASE WHEN ORDER_DATE = CUSTOMER_PREF_DELIVERY_DATE THEN DELIVERY_ID ELSE NULL END) AS REAL) / COUNT(DISTINCT DELIVERY_ID)) * 100 AS REAL(5, 2)) AS IMMEDIATE_PERCENTAGE FROM DELIVERY;

/*
Prediction Result:
(33.33333333333333,)
*/