-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "store1" INTEGER, "store2" INTEGER, "store3" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Products" ("product_id", "store1", "store2", "store3") VALUES (1, 10, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT product_id, 'store1' AS store, store1 AS price FROM products UNION SELECT product_id, 'store2' AS store, store2 AS price FROM products UNION SELECT product_id, 'store3' AS store, store3 AS price FROM products) AS t WHERE NOT price IS NULL;

/*
Gold Result:
(1, 'store1', 10)
*/

-- Prediction Query
WITH RECURSIVE CTE AS (SELECT 1 AS NUM UNION ALL SELECT NUM + 1 AS NUM FROM CTE WHERE NUM + 1 <= 3), CJ AS (SELECT PRODUCT_ID, CASE WHEN NUM = 1 THEN STORE1 WHEN NUM = 2 THEN STORE2 WHEN NUM = 3 THEN STORE3 END AS STORE, CASE WHEN NUM = 1 THEN STORE1 WHEN NUM = 2 THEN STORE2 WHEN NUM = 3 THEN STORE3 END AS PRICE FROM PRODUCTS CROSS JOIN CTE) SELECT * FROM CJ WHERE NOT PRICE IS NULL;

/*
Prediction Result:
(1, 10, 10)
*/