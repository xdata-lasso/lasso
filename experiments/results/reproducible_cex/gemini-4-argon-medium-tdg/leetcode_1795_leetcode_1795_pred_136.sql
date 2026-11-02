-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "store1" INTEGER, "store2" INTEGER, "store3" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Products (product_id, store1, store2, store3) VALUES (0, 95, 100, 105);
INSERT INTO Products (product_id, store1, store2, store3) VALUES (1, 70, NULL, 80);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT product_id, 'store1' AS store, store1 AS price FROM products UNION SELECT product_id, 'store2' AS store, store2 AS price FROM products UNION SELECT product_id, 'store3' AS store, store3 AS price FROM products) AS t WHERE NOT price IS NULL;

/*
Gold Result:
(0, 'store1', 95)
(0, 'store2', 100)
(0, 'store3', 105)
(1, 'store1', 70)
(1, 'store3', 80)
*/

-- Prediction Query
SELECT P.PRODUCT_ID AS PRODUCT_ID, 'STORE1 AS STORE', P.STORE1 AS PRICE FROM PRODUCTS AS P WHERE NOT P.STORE1 IS NULL UNION SELECT P.PRODUCT_ID AS PRODUCT_ID, 'STORE2 AS STORE', P.STORE2 AS PRICE FROM PRODUCTS AS P WHERE NOT P.STORE2 IS NULL UNION SELECT P.PRODUCT_ID AS PRODUCT_ID, 'STORE3 AS STORE', P.STORE3 AS PRICE FROM PRODUCTS AS P WHERE NOT P.STORE3 IS NULL;

/*
Prediction Result:
(0, 'STORE1 AS STORE', 95)
(0, 'STORE2 AS STORE', 100)
(0, 'STORE3 AS STORE', 105)
(1, 'STORE1 AS STORE', 70)
(1, 'STORE3 AS STORE', 80)
*/