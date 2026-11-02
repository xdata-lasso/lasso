-- Schema DDL
CREATE TABLE "ORDERS" (
    "ORDER_ID" INT,
    "CUST_ID" INT,
    PRIMARY KEY ("ORDER_ID")
);
CREATE TABLE "LINEITEM" (
    "ITEM_ID" INT,
    "ORDER_ID" INT,
    "QUANTITY" INT,
    "SHIP_DATE" DATE,
    PRIMARY KEY ("ITEM_ID"),
    FOREIGN KEY ("ORDER_ID") REFERENCES "ORDERS"("ORDER_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ORDERS VALUES (0, 0);
INSERT INTO ORDERS VALUES (-1, 0);
INSERT INTO LINEITEM VALUES (0, 0, 2147457362, '0001-01-02');
INSERT INTO LINEITEM VALUES (-1, 0, -1, '0001-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o.order_id, SUM(l.quantity) FROM orders AS o JOIN lineitem AS l ON o.order_id = l.order_id GROUP BY o.order_id;

/*
Gold Result:
(0, 2147457361)
*/

-- Prediction Query
SELECT o.order_id, SUM(l.quantity) FROM orders AS o JOIN lineitem AS l ON o.order_id = l.order_id GROUP BY o.order_id, l.ship_date;

/*
Prediction Result:
(0, -1)
(0, 2147457362)
*/