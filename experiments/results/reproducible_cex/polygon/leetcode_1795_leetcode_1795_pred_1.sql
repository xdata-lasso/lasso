-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "store1" INTEGER, "store2" INTEGER, "store3" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Products" ("product_id", "store1", "store2", "store3") VALUES (21, 22, 22, NULL);
INSERT INTO "Products" ("product_id", "store1", "store2", "store3") VALUES (20, 23, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT product_id, 'store1' AS store, store1 AS price FROM products UNION SELECT product_id, 'store2' AS store, store2 AS price FROM products UNION SELECT product_id, 'store3' AS store, store3 AS price FROM products) AS t WHERE NOT price IS NULL;

/*
Gold Result:
(20, 'store1', 23)
(21, 'store1', 22)
(21, 'store2', 22)
*/

-- Prediction Query
SELECT * FROM (SELECT PRODUCT_ID, CASE WHEN NOT STORE1 IS NULL THEN STORE1 END AS STORE, CASE WHEN NOT STORE1 IS NULL THEN STORE1 END AS PRICE FROM PRODUCTS UNION SELECT PRODUCT_ID, CASE WHEN NOT STORE2 IS NULL THEN STORE2 END AS STORE, CASE WHEN NOT STORE2 IS NULL THEN STORE2 END AS PRICE FROM PRODUCTS UNION SELECT PRODUCT_ID, CASE WHEN NOT STORE3 IS NULL THEN STORE3 END AS STORE, CASE WHEN NOT STORE3 IS NULL THEN STORE3 END AS PRICE FROM PRODUCTS) AS TMP WHERE NOT STORE IS NULL;

/*
Prediction Result:
(20, 23, 23)
(21, 22, 22)
*/