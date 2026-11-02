-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "store1" INTEGER, "store2" INTEGER, "store3" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Products (product_id, store1, store2, store3) VALUES (1, 95, 100, 105);
INSERT INTO Products (product_id, store1, store2, store3) VALUES (2, 70, NULL, 80);
INSERT INTO Products (product_id, store1, store2, store3) VALUES (3, 110, 120, NULL);
INSERT INTO Products (product_id, store1, store2, store3) VALUES (4, NULL, 60, 65);
INSERT INTO Products (product_id, store1, store2, store3) VALUES (5, 50, NULL, NULL);
INSERT INTO Products (product_id, store1, store2, store3) VALUES (6, NULL, 55, NULL);
INSERT INTO Products (product_id, store1, store2, store3) VALUES (7, NULL, NULL, 45);
INSERT INTO Products (product_id, store1, store2, store3) VALUES (8, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT product_id, 'store1' AS store, store1 AS price FROM products UNION SELECT product_id, 'store2' AS store, store2 AS price FROM products UNION SELECT product_id, 'store3' AS store, store3 AS price FROM products) AS t WHERE NOT price IS NULL;

/*
Gold Result:
(1, 'store1', 95)
(1, 'store2', 100)
(1, 'store3', 105)
(2, 'store1', 70)
(2, 'store3', 80)
(3, 'store1', 110)
(3, 'store2', 120)
(4, 'store2', 60)
(4, 'store3', 65)
(5, 'store1', 50)
(6, 'store2', 55)
(7, 'store3', 45)
*/

-- Prediction Query
SELECT PRODUCT_ID, STORE, PRICE FROM (SELECT PRODUCT_ID, CASE WHEN NOT STORE1 IS NULL THEN STORE1 END AS STORE, CASE WHEN NOT STORE1 IS NULL THEN STORE1 END AS PRICE FROM PRODUCTS UNION SELECT PRODUCT_ID, CASE WHEN NOT STORE2 IS NULL THEN STORE2 END AS STORE, CASE WHEN NOT STORE2 IS NULL THEN STORE2 END AS PRICE FROM PRODUCTS UNION SELECT PRODUCT_ID, CASE WHEN NOT STORE3 IS NULL THEN STORE3 END AS STORE, CASE WHEN NOT STORE3 IS NULL THEN STORE3 END AS PRICE FROM PRODUCTS) AS X WHERE NOT STORE IS NULL;

/*
Prediction Result:
(1, 95, 95)
(1, 100, 100)
(1, 105, 105)
(2, 70, 70)
(2, 80, 80)
(3, 110, 110)
(3, 120, 120)
(4, 60, 60)
(4, 65, 65)
(5, 50, 50)
(6, 55, 55)
(7, 45, 45)
*/