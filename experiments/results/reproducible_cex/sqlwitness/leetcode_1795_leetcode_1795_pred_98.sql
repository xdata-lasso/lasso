-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "store1" INTEGER, "store2" INTEGER, "store3" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO products (product_id, store1, store2, store3) VALUES (0, NULL, 1, 1), (2, NULL, 1, NULL), (1, 1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT product_id, 'store1' AS store, store1 AS price FROM products UNION SELECT product_id, 'store2' AS store, store2 AS price FROM products UNION SELECT product_id, 'store3' AS store, store3 AS price FROM products) AS t WHERE NOT price IS NULL;

/*
Gold Result:
(0, 'store2', 1)
(0, 'store3', 1)
(1, 'store1', 1)
(1, 'store2', 0)
(1, 'store3', 0)
(2, 'store2', 1)
*/

-- Prediction Query
SELECT DISTINCT P.PRODUCT_ID, P.STORE, P.PRICE FROM (SELECT DISTINCT PRODUCT_ID, CASE WHEN NOT STORE1 IS NULL THEN STORE1 END AS STORE, STORE1 AS PRICE FROM PRODUCTS UNION ALL SELECT DISTINCT PRODUCT_ID, CASE WHEN NOT STORE2 IS NULL THEN STORE2 END AS STORE, STORE2 AS PRICE FROM PRODUCTS UNION ALL SELECT DISTINCT PRODUCT_ID, CASE WHEN NOT STORE3 IS NULL THEN STORE3 END AS STORE, STORE3 AS PRICE FROM PRODUCTS) AS P WHERE 1 = 1 AND NOT P.STORE IS NULL;

/*
Prediction Result:
(1, 1, 1)
(0, 1, 1)
(1, 0, 0)
(2, 1, 1)
*/