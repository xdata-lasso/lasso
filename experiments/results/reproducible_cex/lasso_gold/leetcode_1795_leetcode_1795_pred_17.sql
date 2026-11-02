-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "store1" INTEGER, "store2" INTEGER, "store3" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "products" ("product_id", "store1", "store2", "store3") VALUES (1048, 0, 0, 0);
INSERT INTO "products" ("product_id", "store1", "store2", "store3") VALUES (1050, -1, -1, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT product_id, 'store1' AS store, store1 AS price FROM products UNION SELECT product_id, 'store2' AS store, store2 AS price FROM products UNION SELECT product_id, 'store3' AS store, store3 AS price FROM products) AS t WHERE NOT price IS NULL;

/*
Gold Result:
(1048, 'store1', 0)
(1048, 'store2', 0)
(1048, 'store3', 0)
(1050, 'store1', -1)
(1050, 'store2', -1)
(1050, 'store3', -1)
*/

-- Prediction Query
SELECT PRODUCT_ID, 'store1' AS STORE, STORE1 AS PRICE FROM PRODUCTS WHERE STORE1 > 0 UNION SELECT PRODUCT_ID, 'store2' AS STORE, STORE2 AS PRICE FROM PRODUCTS WHERE STORE2 > 0 UNION SELECT PRODUCT_ID, 'store3' AS STORE, STORE3 AS PRICE FROM PRODUCTS WHERE STORE3 > 0;

/*
Prediction Result:
*/