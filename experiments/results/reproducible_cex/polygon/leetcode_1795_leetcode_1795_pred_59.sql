-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "store1" INTEGER, "store2" INTEGER, "store3" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Products" ("product_id", "store1", "store2", "store3") VALUES (17, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT product_id, 'store1' AS store, store1 AS price FROM products UNION SELECT product_id, 'store2' AS store, store2 AS price FROM products UNION SELECT product_id, 'store3' AS store, store3 AS price FROM products) AS t WHERE NOT price IS NULL;

/*
Gold Result:
*/

-- Prediction Query
SELECT PRODUCT_ID, CASE WHEN NOT STORE1 IS NULL THEN STORE1 END AS STORE, STORE1 AS PRICE FROM PRODUCTS WHERE NOT STORE1 IS NULL UNION SELECT PRODUCT_ID, CASE WHEN NOT STORE2 IS NULL THEN STORE2 END AS STORE, STORE2 AS PRICE FROM PRODUCTS WHERE NOT STORE2 IS NULL UNION SELECT PRODUCT_ID, CASE WHEN NOT STORE3 IS NULL THEN STORE3 END AS STORE, STORE3 AS PRICE FROM PRODUCTS WHERE NOT STORE3 IS NULL;

/*
Prediction Result:
*/