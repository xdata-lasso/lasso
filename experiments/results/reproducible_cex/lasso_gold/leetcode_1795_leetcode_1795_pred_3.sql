-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "store1" INTEGER, "store2" INTEGER, "store3" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "products" ("product_id", "store1", "store2", "store3") VALUES (1001, 1002, 1002, 1002);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT product_id, 'store1' AS store, store1 AS price FROM products UNION SELECT product_id, 'store2' AS store, store2 AS price FROM products UNION SELECT product_id, 'store3' AS store, store3 AS price FROM products) AS t WHERE NOT price IS NULL;

/*
Gold Result:
(1001, 'store1', 1002)
(1001, 'store2', 1002)
(1001, 'store3', 1002)
*/

-- Prediction Query
SELECT * FROM (SELECT PRODUCT_ID, STORE1 AS PRICE, 'store1' AS STORE FROM PRODUCTS UNION ALL SELECT PRODUCT_ID, STORE2 AS PRICE, 'store2' AS STORE FROM PRODUCTS UNION ALL SELECT PRODUCT_ID, STORE3 AS PRICE, 'store3' AS STORE FROM PRODUCTS) AS A WHERE NOT PRICE IS NULL;

/*
Prediction Result:
(1001, 1002, 'store1')
(1001, 1002, 'store2')
(1001, 1002, 'store3')
*/