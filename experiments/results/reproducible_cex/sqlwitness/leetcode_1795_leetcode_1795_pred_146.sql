-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "store1" INTEGER, "store2" INTEGER, "store3" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO products (product_id, store1, store2, store3) VALUES (0, 1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT product_id, 'store1' AS store, store1 AS price FROM products UNION SELECT product_id, 'store2' AS store, store2 AS price FROM products UNION SELECT product_id, 'store3' AS store, store3 AS price FROM products) AS t WHERE NOT price IS NULL;

/*
Gold Result:
(0, 'store1', 1)
(0, 'store2', 0)
(0, 'store3', 0)
*/

-- Prediction Query
SELECT P2.PRODUCT_ID, 'store1' AS STORE, P2.STORE1 AS PRICE FROM PRODUCTS AS P1 LEFT JOIN PRODUCTS AS P2 ON P1.PRODUCT_ID = P2.PRODUCT_ID AND P2.STORE1 WHERE NOT P2.STORE1 IS NULL UNION SELECT P2.PRODUCT_ID, 'store2' AS STORE, P2.STORE2 AS PRICE FROM PRODUCTS AS P1 LEFT JOIN PRODUCTS AS P2 ON P1.PRODUCT_ID = P2.PRODUCT_ID WHERE NOT P2.STORE2 IS NULL UNION SELECT P2.PRODUCT_ID, 'store3' AS STORE, P2.STORE3 AS PRICE FROM PRODUCTS AS P1 LEFT JOIN PRODUCTS AS P2 ON P1.PRODUCT_ID = P2.PRODUCT_ID AND P2.STORE3 WHERE NOT P2.STORE3 IS NULL;

/*
Prediction Result:
(0, 'store1', 1)
(0, 'store2', 0)
*/