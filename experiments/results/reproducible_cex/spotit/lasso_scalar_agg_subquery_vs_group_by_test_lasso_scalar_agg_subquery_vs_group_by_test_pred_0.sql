-- Schema DDL
CREATE TABLE "PRODUCTS" (
    "PRODUCT_ID" INT,
    "STOCK_COUNT" INT,
    PRIMARY KEY ("PRODUCT_ID")
);
CREATE TABLE "ORDERS" (
    "ORDER_ID" INT,
    "PRODUCT_ID" INT,
    "QUANTITY" INT,
    PRIMARY KEY ("ORDER_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO PRODUCTS VALUES (-1, 1);
INSERT INTO PRODUCTS VALUES (0, 2);
INSERT INTO ORDERS VALUES (0, 0, 1);
INSERT INTO ORDERS VALUES (-1, -1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT p.product_id FROM products AS p WHERE (p.product_id, p.stock_count) IN (SELECT o.product_id, COUNT(o.quantity) FROM orders AS o WHERE o.quantity > 0);

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT p.product_id FROM products AS p JOIN (SELECT o.product_id, COUNT(o.quantity) AS cnt FROM orders AS o WHERE o.quantity > 0 GROUP BY o.product_id) AS g ON p.product_id = g.product_id AND p.stock_count = g.cnt;

/*
Prediction Result:
(-1,)
*/