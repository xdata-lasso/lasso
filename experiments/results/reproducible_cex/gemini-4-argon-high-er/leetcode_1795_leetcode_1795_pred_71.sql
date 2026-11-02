-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "store1" INTEGER, "store2" INTEGER, "store3" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Products (product_id, store1, store2, store3) VALUES (1, 100, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT product_id, 'store1' AS store, store1 AS price FROM products UNION SELECT product_id, 'store2' AS store, store2 AS price FROM products UNION SELECT product_id, 'store3' AS store, store3 AS price FROM products) AS t WHERE NOT price IS NULL;

/*
Gold Result:
(1, 'store1', 100)
*/

-- Prediction Query
WITH CTE AS (SELECT PRODUCT_ID, STORE1 AS PRICE, CASE WHEN NOT STORE1 IS NULL THEN STORE1 END AS STORE FROM PRODUCTS UNION ALL SELECT PRODUCT_ID, STORE2 AS PRICE, CASE WHEN NOT STORE2 IS NULL THEN STORE2 END AS STORE FROM PRODUCTS UNION ALL SELECT PRODUCT_ID, STORE3 AS PRICE, CASE WHEN NOT STORE3 IS NULL THEN STORE3 END AS STORE FROM PRODUCTS) SELECT * FROM CTE WHERE NOT PRICE IS NULL;

/*
Prediction Result:
(1, 100, 100)
*/