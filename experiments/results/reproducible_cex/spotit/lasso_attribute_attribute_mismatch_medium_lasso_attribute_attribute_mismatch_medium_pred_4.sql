-- Schema DDL
CREATE TABLE "ORDERS" (
    "ORDER_ID" INT,
    "CUSTOMER_ID" INT,
    "ORDER_DATE" DATE,
    "SHIPPED_DATE" DATE,
    "DELIVERY_DATE" DATE,
    PRIMARY KEY ("ORDER_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ORDERS VALUES (0, NULL, NULL, '2023-01-01', NULL);
INSERT INTO ORDERS VALUES (1, 0, '0000-04-01', '0000-01-01', '0000-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT order_id FROM Orders WHERE STRFTIME('%Y', shipped_date) = '2023';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT order_date FROM Orders WHERE STRFTIME('%Y', shipped_date) = '2023';

/*
Prediction Result:
(None,)
*/