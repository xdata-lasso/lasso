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
SELECT D.PRODUCT_ID, D.STORE, D.PRICE FROM (SELECT PRODUCT_ID, 'store1' AS STORE, STORE1 AS PRICE FROM PRODUCTS GROUP BY STORE1, PRODUCT_ID UNION ALL SELECT PRODUCT_ID, 'store2' AS STORE, STORE2 AS PRICE FROM PRODUCTS GROUP BY STORE2, PRODUCT_ID UNION ALL SELECT PRODUCT_ID, 'store3' AS STORE, STORE3 AS PRICE FROM PRODUCTS GROUP BY STORE3, PRODUCT_ID) AS D WHERE NOT D.PRICE IS NULL;

/*
Prediction Result:
*/