-- Schema DDL
CREATE TABLE "Delivery" ("delivery_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATE, "customer_pref_delivery_date" DATE, CHECK ("order_date" <= 'Delivery.customer_pref_delivery_date'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Delivery" ("delivery_id", "customer_id", "order_date", "customer_pref_delivery_date") VALUES (10, 17, '0998-06-17', '1002-03-09');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(IIF(order_date = customer_pref_delivery_date, 1, 0)) AS REAL) / COUNT(*)) * 100, 2) AS immediate_percentage FROM Delivery;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND((CAST(A.IM AS REAL) / COUNT(DELIVERY_ID) * 100), 2) AS IMMEDIATE_PERCENTAGE FROM DELIVERY AS A JOIN (SELECT COUNT(*) AS IM FROM DELIVERY AS D JOIN DELIVERY AS DD ON D.DELIVERY_ID = DD.DELIVERY_ID WHERE D.ORDER_DATE = DD.CUSTOMER_PREF_DELIVERY_DATE) AS A ON A.DELIVERY_ID = A.DELIVERY_ID;

/*
Prediction Result:
(0.0,)
*/