-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER, "store" TEXT(255), "price" INTEGER, PRIMARY KEY ("product_id", "store"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Products" ("product_id", "store", "price") VALUES (NULL, 'store1', 10);
INSERT INTO "Products" ("product_id", "store", "price") VALUES (NULL, 'store1', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_id, SUM(CASE WHEN store = 'store1' THEN price ELSE NULL END) AS store1, SUM(CASE WHEN store = 'store2' THEN price ELSE NULL END) AS store2, SUM(CASE WHEN store = 'store3' THEN price ELSE NULL END) AS store3 FROM products GROUP BY product_id;

/*
Gold Result:
(None, 20, None, None)
*/

-- Prediction Query
SELECT DISTINCT PRODUCT_ID, MAX(CASE WHEN STORE = 'store1' THEN PRICE END) AS STORE1, MAX(CASE WHEN STORE = 'store2' THEN PRICE END) AS STORE2, MAX(CASE WHEN STORE = 'store3' THEN PRICE END) AS STORE3 FROM PRODUCTS GROUP BY 1 ORDER BY 1, PRODUCT_ID NULLS LAST, STORE1 NULLS LAST, STORE2 NULLS LAST, STORE3 NULLS LAST;

/*
Prediction Result:
(None, 10, None, None)
*/