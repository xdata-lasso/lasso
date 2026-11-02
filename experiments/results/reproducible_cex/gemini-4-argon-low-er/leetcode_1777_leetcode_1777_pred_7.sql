-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER, "store" TEXT(255), "price" INTEGER, PRIMARY KEY ("product_id", "store"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Products" ("product_id", "store", "price") VALUES (NULL, 'store1', 10);
INSERT INTO "Products" ("product_id", "store", "price") VALUES (NULL, 'store2', 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_id, SUM(CASE WHEN store = 'store1' THEN price ELSE NULL END) AS store1, SUM(CASE WHEN store = 'store2' THEN price ELSE NULL END) AS store2, SUM(CASE WHEN store = 'store3' THEN price ELSE NULL END) AS store3 FROM products GROUP BY product_id;

/*
Gold Result:
(None, 10, 20, None)
*/

-- Prediction Query
SELECT DISTINCT PRODUCT_ID, (SELECT PRICE FROM PRODUCTS AS Q WHERE STORE = 'store1' AND Q.PRODUCT_ID = P.PRODUCT_ID) AS STORE1, (SELECT PRICE FROM PRODUCTS AS Q WHERE STORE = 'store2' AND Q.PRODUCT_ID = P.PRODUCT_ID) AS STORE2, (SELECT PRICE FROM PRODUCTS AS Q WHERE STORE = 'store3' AND Q.PRODUCT_ID = P.PRODUCT_ID) AS STORE3 FROM PRODUCTS AS P;

/*
Prediction Result:
(None, None, None, None)
*/