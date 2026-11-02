-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER, "store" TEXT(255), "price" INTEGER, PRIMARY KEY ("product_id", "store"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Products" ("product_id", "store", "price") VALUES (NULL, 'store1', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_id, SUM(CASE WHEN store = 'store1' THEN price ELSE NULL END) AS store1, SUM(CASE WHEN store = 'store2' THEN price ELSE NULL END) AS store2, SUM(CASE WHEN store = 'store3' THEN price ELSE NULL END) AS store3 FROM products GROUP BY product_id;

/*
Gold Result:
(None, 10, None, None)
*/

-- Prediction Query
WITH STORE1 AS (SELECT PRODUCT_ID, PRICE AS STORE1 FROM PRODUCTS WHERE STORE = 'store1'), STORE2 AS (SELECT PRODUCT_ID, PRICE AS STORE2 FROM PRODUCTS WHERE STORE = 'store2'), STORE3 AS (SELECT PRODUCT_ID, PRICE AS STORE3 FROM PRODUCTS WHERE STORE = 'store3') SELECT T.PRODUCT_ID, STORE1, STORE2, STORE3 FROM (SELECT DISTINCT PRODUCT_ID FROM PRODUCTS) AS T LEFT JOIN STORE1 AS S1 ON T.PRODUCT_ID = S1.PRODUCT_ID LEFT JOIN STORE2 AS S2 ON T.PRODUCT_ID = S2.PRODUCT_ID LEFT JOIN STORE3 AS S3 ON T.PRODUCT_ID = S3.PRODUCT_ID;

/*
Prediction Result:
(None, None, None, None)
*/