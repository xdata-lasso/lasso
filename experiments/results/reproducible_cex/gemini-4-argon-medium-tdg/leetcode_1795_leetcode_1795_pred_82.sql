-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "store1" INTEGER, "store2" INTEGER, "store3" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Products (product_id, store1, store2, store3) VALUES (0, 95, 100, 105);
INSERT INTO Products (product_id, store1, store2, store3) VALUES (1, 70, NULL, 80);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT product_id, 'store1' AS store, store1 AS price FROM products UNION SELECT product_id, 'store2' AS store, store2 AS price FROM products UNION SELECT product_id, 'store3' AS store, store3 AS price FROM products) AS t WHERE NOT price IS NULL;

/*
Gold Result:
(0, 'store1', 95)
(0, 'store2', 100)
(0, 'store3', 105)
(1, 'store1', 70)
(1, 'store3', 80)
*/

-- Prediction Query
SELECT PRODUCT_ID, STORE1 AS STORE, 'store1' AS PRICE FROM PRODUCTS WHERE NOT STORE1 IS NULL UNION SELECT PRODUCT_ID, STORE2 AS STORE, 'store2' AS PRICE FROM PRODUCTS WHERE NOT STORE2 IS NULL UNION SELECT PRODUCT_ID, STORE3 AS STORE, 'store3' AS PRICE FROM PRODUCTS WHERE NOT STORE3 IS NULL;

/*
Prediction Result:
(0, 95, 'store1')
(0, 100, 'store2')
(0, 105, 'store3')
(1, 70, 'store1')
(1, 80, 'store3')
*/