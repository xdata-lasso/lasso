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
SELECT T1.PRODUCT_ID, T1.STORE, T1.VALUE AS PRICE FROM (SELECT PRODUCT_ID, 'store1' AS STORE, STORE1 AS VALUE FROM PRODUCTS UNION SELECT PRODUCT_ID, 'store2' AS STORE, STORE2 AS VALUE FROM PRODUCTS UNION SELECT PRODUCT_ID, 'store3' AS STORE, STORE3 AS VALUE FROM PRODUCTS) AS T1 WHERE NOT T1.VALUE IS NULL;

/*
Prediction Result:
*/