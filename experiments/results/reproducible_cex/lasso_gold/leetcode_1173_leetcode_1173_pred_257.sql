-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (1005, 1006, '2026-10-28 12:00:00', '2026-10-28 12:00:00');
INSERT INTO "delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (1007, 1008, '2026-10-28 12:00:00', '2026-10-28 12:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT (ROUND(CAST(100 * (SELECT COUNT(*) FROM DELIVERY AS A WHERE DATE(A.ORDER_DATE) = A.CUSTOMER_PREF_DELIVERY_DATE) AS REAL) / (SELECT COUNT(*) FROM DELIVERY), 2)) AS IMMEDIATE_PERCENTAGE;

/*
Prediction Result:
(0.0,)
*/