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
INSERT INTO ORDERS VALUES (20231102, -2147483648, '0000-05-01', '2023-11-01', '0000-01-01');
INSERT INTO ORDERS VALUES (20231103, -2147483648, '0000-01-01', '2023-01-01', '0000-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT order_id FROM Orders WHERE STRFTIME('%Y', shipped_date) = '2023';

/*
Gold Result:
(20231102,)
(20231103,)
*/

-- Prediction Query
SELECT shipped_date FROM Orders WHERE STRFTIME('%Y', shipped_date) = '2023';

/*
Prediction Result:
('2023-11-01',)
('2023-01-01',)
*/