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
SELECT DISTINCT P.PRODUCT_ID, A.AP AS STORE1, B.AP AS STORE2, C.AP AS STORE3 FROM PRODUCTS AS P LEFT JOIN (SELECT PRODUCT_ID, STORE, AVG(PRICE) AS AP FROM PRODUCTS WHERE STORE = 'store1' GROUP BY PRODUCT_ID, STORE) AS A ON P.PRODUCT_ID = A.PRODUCT_ID LEFT JOIN (SELECT PRODUCT_ID, STORE, AVG(PRICE) AS AP FROM PRODUCTS WHERE STORE = 'store2' GROUP BY PRODUCT_ID, STORE) AS B ON P.PRODUCT_ID = B.PRODUCT_ID LEFT JOIN (SELECT PRODUCT_ID, STORE, AVG(PRICE) AS AP FROM PRODUCTS WHERE STORE = 'store3' GROUP BY PRODUCT_ID, STORE) AS C ON P.PRODUCT_ID = C.PRODUCT_ID;

/*
Prediction Result:
(None, None, None, None)
*/