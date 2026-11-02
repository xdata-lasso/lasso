-- Schema DDL
CREATE TABLE "ORDERS" (
    "ORDER_ID" INT,
    "STATUS" TEXT,
    PRIMARY KEY ("ORDER_ID")
);
CREATE TABLE "LINEITEM" (
    "ORDER_ID" INT,
    "SUPP_ID" INT,
    PRIMARY KEY ("ORDER_ID", "SUPP_ID"),
    FOREIGN KEY ("ORDER_ID") REFERENCES "ORDERS"("ORDER_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ORDERS VALUES (0, 7);
INSERT INTO ORDERS VALUES (1, 5815292197760961916);
INSERT INTO LINEITEM VALUES (0, 0);
INSERT INTO LINEITEM VALUES (0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT order_id FROM orders WHERE status = 'O' AND EXISTS(SELECT * FROM lineitem WHERE lineitem.order_id = orders.order_id AND lineitem.supp_id <> 10);

/*
Gold Result:
*/

-- Prediction Query
SELECT order_id FROM orders WHERE status = 'O' AND NOT EXISTS(SELECT * FROM lineitem WHERE lineitem.order_id = orders.order_id AND lineitem.supp_id <> 10);

/*
Prediction Result:
*/