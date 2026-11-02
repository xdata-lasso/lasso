-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "store1" INTEGER, "store2" INTEGER, "store3" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT product_id, 'store1' AS store, store1 AS price FROM products UNION SELECT product_id, 'store2' AS store, store2 AS price FROM products UNION SELECT product_id, 'store3' AS store, store3 AS price FROM products) AS t WHERE NOT price IS NULL;

/*
Gold Result:
*/

-- Prediction Query
SELECT P.PRODUCT_ID, 'store1' AS STORE, P2.STORE1 AS PRICE FROM PRODUCTS AS P JOIN PRODUCTS AS P2 ON P.PRODUCT_ID = P2.PRODUCT_ID AND NOT P2.STORE1 IS NULL UNION SELECT P.PRODUCT_ID, 'store2' AS STORE, P2.STORE2 AS PRICE FROM PRODUCTS AS P JOIN PRODUCTS AS P2 ON P.PRODUCT_ID = P2.PRODUCT_ID AND NOT P2.STORE2 IS NULL UNION SELECT P.PRODUCT_ID, 'store3' AS STORE, P2.STORE3 AS PRICE FROM PRODUCTS AS P JOIN PRODUCTS AS P2 ON P.PRODUCT_ID = P2.PRODUCT_ID AND NOT P2.STORE3 IS NULL;

/*
Prediction Result:
*/