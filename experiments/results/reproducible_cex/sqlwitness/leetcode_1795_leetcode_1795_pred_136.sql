-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "store1" INTEGER, "store2" INTEGER, "store3" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO products (product_id, store1, store2, store3) VALUES (1, 0, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT product_id, 'store1' AS store, store1 AS price FROM products UNION SELECT product_id, 'store2' AS store, store2 AS price FROM products UNION SELECT product_id, 'store3' AS store, store3 AS price FROM products) AS t WHERE NOT price IS NULL;

/*
Gold Result:
(1, 'store1', 0)
(1, 'store3', 0)
*/

-- Prediction Query
SELECT P.PRODUCT_ID AS PRODUCT_ID, 'STORE1 AS STORE', P.STORE1 AS PRICE FROM PRODUCTS AS P WHERE NOT P.STORE1 IS NULL UNION SELECT P.PRODUCT_ID AS PRODUCT_ID, 'STORE2 AS STORE', P.STORE2 AS PRICE FROM PRODUCTS AS P WHERE NOT P.STORE2 IS NULL UNION SELECT P.PRODUCT_ID AS PRODUCT_ID, 'STORE3 AS STORE', P.STORE3 AS PRICE FROM PRODUCTS AS P WHERE NOT P.STORE3 IS NULL;

/*
Prediction Result:
(1, 'STORE1 AS STORE', 0)
(1, 'STORE3 AS STORE', 0)
*/