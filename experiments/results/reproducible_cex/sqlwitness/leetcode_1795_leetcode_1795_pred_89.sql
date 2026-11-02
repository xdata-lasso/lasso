-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "store1" INTEGER, "store2" INTEGER, "store3" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO products (product_id, store1, store2, store3) VALUES (1, 0, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT product_id, 'store1' AS store, store1 AS price FROM products UNION SELECT product_id, 'store2' AS store, store2 AS price FROM products UNION SELECT product_id, 'store3' AS store, store3 AS price FROM products) AS t WHERE NOT price IS NULL;

/*
Gold Result:
(1, 'store1', 0)
(1, 'store3', 1)
*/

-- Prediction Query
SELECT * FROM (SELECT PRODUCT_ID, (CASE WHEN NOT STORE1 IS NULL THEN STORE1 ELSE NULL END) AS STORE, STORE1 AS PRICE FROM PRODUCTS UNION ALL SELECT PRODUCT_ID, (CASE WHEN NOT STORE2 IS NULL THEN STORE2 ELSE NULL END) AS STORE, STORE2 AS PRICE FROM PRODUCTS UNION ALL SELECT PRODUCT_ID, (CASE WHEN NOT STORE3 IS NULL THEN STORE3 ELSE NULL END) AS STORE, STORE3 AS PRICE FROM PRODUCTS) AS A WHERE NOT A.PRICE IS NULL ORDER BY A.PRODUCT_ID;

/*
Prediction Result:
(1, 0, 0)
(1, 1, 1)
*/