-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "store1" INTEGER, "store2" INTEGER, "store3" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO products (product_id, store1, store2, store3) VALUES (1, 2, 2, 3), (0, 2, 1, 0), (3, 0, 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT product_id, 'store1' AS store, store1 AS price FROM products UNION SELECT product_id, 'store2' AS store, store2 AS price FROM products UNION SELECT product_id, 'store3' AS store, store3 AS price FROM products) AS t WHERE NOT price IS NULL;

/*
Gold Result:
(0, 'store1', 2)
(0, 'store2', 1)
(0, 'store3', 0)
(1, 'store1', 2)
(1, 'store2', 2)
(1, 'store3', 3)
(3, 'store1', 0)
(3, 'store2', 2)
(3, 'store3', 0)
*/

-- Prediction Query
SELECT PRODUCT_ID, 'store1' AS STORE, STORE1 AS PRICE FROM PRODUCTS WHERE STORE1 <> 'NULL' UNION SELECT PRODUCT_ID, 'store2' AS STORE, STORE2 AS PRICE FROM PRODUCTS WHERE STORE2 <> 'NULL' UNION SELECT PRODUCT_ID, 'store3' AS STORE, STORE3 AS PRICE FROM PRODUCTS WHERE STORE3 <> 'NULL' ORDER BY 2, PRODUCT_ID NULLS LAST, STORE NULLS LAST, PRICE NULLS LAST;

/*
Prediction Result:
(0, 'store1', 2)
(1, 'store1', 2)
(3, 'store1', 0)
(0, 'store2', 1)
(1, 'store2', 2)
(3, 'store2', 2)
(0, 'store3', 0)
(1, 'store3', 3)
(3, 'store3', 0)
*/