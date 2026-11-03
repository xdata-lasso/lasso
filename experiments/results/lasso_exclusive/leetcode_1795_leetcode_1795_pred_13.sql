-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "store1" INTEGER, "store2" INTEGER, "store3" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "products" ("product_id", "store1", "store2", "store3") VALUES (1029, 1030, 1030, 1030);
INSERT INTO "products" ("product_id", "store1", "store2", "store3") VALUES (1033, 'NULL%', 'NULL%', 'NULL%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT product_id, 'store1' AS store, store1 AS price FROM products UNION SELECT product_id, 'store2' AS store, store2 AS price FROM products UNION SELECT product_id, 'store3' AS store, store3 AS price FROM products) AS t WHERE NOT price IS NULL;

/*
Gold Result:
(1029, 'store1', 1030)
(1029, 'store2', 1030)
(1029, 'store3', 1030)
(1033, 'store1', 'NULL%')
(1033, 'store2', 'NULL%')
(1033, 'store3', 'NULL%')
*/

-- Prediction Query
SELECT PRODUCT_ID, 'store1' AS STORE, SUM(STORE1) AS PRICE FROM PRODUCTS WHERE NOT STORE1 IS NULL GROUP BY PRODUCT_ID UNION ALL SELECT PRODUCT_ID, 'store2' AS STORE, SUM(STORE2) AS PRICE FROM PRODUCTS WHERE NOT STORE2 IS NULL GROUP BY PRODUCT_ID UNION ALL SELECT PRODUCT_ID, 'store3' AS STORE, SUM(STORE3) AS PRICE FROM PRODUCTS WHERE NOT STORE3 IS NULL GROUP BY PRODUCT_ID;

/*
Prediction Result:
(1029, 'store1', 1030)
(1033, 'store1', 0.0)
(1029, 'store2', 1030)
(1033, 'store2', 0.0)
(1029, 'store3', 1030)
(1033, 'store3', 0.0)
*/