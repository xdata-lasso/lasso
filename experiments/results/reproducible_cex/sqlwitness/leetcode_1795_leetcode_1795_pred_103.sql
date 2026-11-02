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
SELECT P1.PRODUCT_ID, P2.STORE, P2.PRICE FROM PRODUCTS AS P1 LEFT JOIN (SELECT STORE1 AS STORE, STORE1 AS PRICE, PRODUCT_ID FROM PRODUCTS WHERE NOT STORE1 IS NULL UNION SELECT STORE2 AS STORE, STORE2 AS PRICE, PRODUCT_ID FROM PRODUCTS WHERE NOT STORE2 IS NULL UNION SELECT STORE3 AS STORE, STORE3 AS PRICE, PRODUCT_ID FROM PRODUCTS WHERE NOT STORE3 IS NULL) AS P2 ON P1.PRODUCT_ID = P2.PRODUCT_ID;

/*
Prediction Result:
(0, 0, 0)
(0, 1, 1)
*/