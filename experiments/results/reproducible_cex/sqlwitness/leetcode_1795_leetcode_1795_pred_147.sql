-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "store1" INTEGER, "store2" INTEGER, "store3" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO products (product_id, store1, store2, store3) VALUES (0, NULL, 0, NULL), (1, 1, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT product_id, 'store1' AS store, store1 AS price FROM products UNION SELECT product_id, 'store2' AS store, store2 AS price FROM products UNION SELECT product_id, 'store3' AS store, store3 AS price FROM products) AS t WHERE NOT price IS NULL;

/*
Gold Result:
(0, 'store2', 0)
(1, 'store1', 1)
(1, 'store3', 1)
*/

-- Prediction Query
SELECT PRODUCT_ID, 'STORE1 AS STORE', STORE1 AS PRICE FROM PRODUCTS WHERE NOT STORE1 IS NULL UNION SELECT PRODUCT_ID, 'STORE2 AS STORE', STORE2 AS STORE FROM PRODUCTS WHERE NOT STORE2 IS NULL UNION SELECT PRODUCT_ID, 'STORE3 AS STORE', STORE3 AS STORE FROM PRODUCTS WHERE NOT STORE3 IS NULL;

/*
Prediction Result:
(0, 'STORE2 AS STORE', 0)
(1, 'STORE1 AS STORE', 1)
(1, 'STORE3 AS STORE', 1)
*/