-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "store1" INTEGER, "store2" INTEGER, "store3" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Products" ("product_id", "store1", "store2", "store3") VALUES (22, NULL, NULL, NULL);
INSERT INTO "Products" ("product_id", "store1", "store2", "store3") VALUES (21, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT product_id, 'store1' AS store, store1 AS price FROM products UNION SELECT product_id, 'store2' AS store, store2 AS price FROM products UNION SELECT product_id, 'store3' AS store, store3 AS price FROM products) AS t WHERE NOT price IS NULL;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT PRODUCT_ID, 'store1' AS STORE FROM PRODUCTS WHERE NOT STORE1 IS NULL UNION SELECT PRODUCT_ID, 'store2' AS STORE FROM PRODUCTS WHERE NOT STORE2 IS NULL UNION SELECT PRODUCT_ID, 'store3' AS STORE FROM PRODUCTS WHERE NOT STORE3 IS NULL) SELECT A.PRODUCT_ID, A.STORE, CASE WHEN A.STORE = 'store1' THEN B.STORE1 WHEN A.STORE = 'store2' THEN B.STORE2 WHEN A.STORE = 'store3' THEN B.STORE3 END AS PRICE FROM CTE AS A INNER JOIN PRODUCTS AS B ON A.PRODUCT_ID = B.PRODUCT_ID;

/*
Prediction Result:
*/