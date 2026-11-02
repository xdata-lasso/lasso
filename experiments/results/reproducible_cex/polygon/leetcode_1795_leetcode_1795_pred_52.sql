-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "store1" INTEGER, "store2" INTEGER, "store3" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Products" ("product_id", "store1", "store2", "store3") VALUES (20, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT product_id, 'store1' AS store, store1 AS price FROM products UNION SELECT product_id, 'store2' AS store, store2 AS price FROM products UNION SELECT product_id, 'store3' AS store, store3 AS price FROM products) AS t WHERE NOT price IS NULL;

/*
Gold Result:
*/

-- Prediction Query
SELECT PRO1.PRODUCT_ID AS PRODUCT_ID, 'store1' AS STORE, PRO1.STORE1 AS PRICE FROM PRODUCTS AS PRO1 WHERE NOT PRO1.STORE1 IS NULL UNION SELECT PRO2.PRODUCT_ID AS PRODUCT_ID, 'store2' AS STORE, PRO2.STORE2 AS PRICE FROM PRODUCTS AS PRO2 WHERE NOT PRO2.STORE2 IS NULL UNION SELECT PRO3.PRODUCT_ID AS PRODUCT_ID, 'store3' AS STORE, PRO3.STORE3 AS PRICE FROM PRODUCTS AS PRO3 WHERE NOT PRO3.STORE3 IS NULL;

/*
Prediction Result:
*/