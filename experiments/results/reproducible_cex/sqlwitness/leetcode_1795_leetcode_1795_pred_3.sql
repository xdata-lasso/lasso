-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "store1" INTEGER, "store2" INTEGER, "store3" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO products (product_id, store1, store2, store3) VALUES (0, 1, 1, 1), (1, 1, 0, 1), (2, 1, 1, 1), (3, 1, 1, 1), (4, 1, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT product_id, 'store1' AS store, store1 AS price FROM products UNION SELECT product_id, 'store2' AS store, store2 AS price FROM products UNION SELECT product_id, 'store3' AS store, store3 AS price FROM products) AS t WHERE NOT price IS NULL;

/*
Gold Result:
(0, 'store1', 1)
(0, 'store2', 1)
(0, 'store3', 1)
(1, 'store1', 1)
(1, 'store2', 0)
(1, 'store3', 1)
(2, 'store1', 1)
(2, 'store2', 1)
(2, 'store3', 1)
(3, 'store1', 1)
(3, 'store2', 1)
(3, 'store3', 1)
(4, 'store1', 1)
(4, 'store2', 1)
(4, 'store3', 0)
*/

-- Prediction Query
SELECT * FROM (SELECT PRODUCT_ID, STORE1 AS PRICE, 'store1' AS STORE FROM PRODUCTS UNION ALL SELECT PRODUCT_ID, STORE2 AS PRICE, 'store2' AS STORE FROM PRODUCTS UNION ALL SELECT PRODUCT_ID, STORE3 AS PRICE, 'store3' AS STORE FROM PRODUCTS) AS A WHERE NOT PRICE IS NULL;

/*
Prediction Result:
(0, 1, 'store1')
(1, 1, 'store1')
(2, 1, 'store1')
(3, 1, 'store1')
(4, 1, 'store1')
(0, 1, 'store2')
(1, 0, 'store2')
(2, 1, 'store2')
(3, 1, 'store2')
(4, 1, 'store2')
(0, 1, 'store3')
(1, 1, 'store3')
(2, 1, 'store3')
(3, 1, 'store3')
(4, 0, 'store3')
*/