-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER, "store" TEXT(255), "price" INTEGER, PRIMARY KEY ("product_id", "store"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Products (product_id, store, price) VALUES (NULL, 'store1', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_id, SUM(CASE WHEN store = 'store1' THEN price ELSE NULL END) AS store1, SUM(CASE WHEN store = 'store2' THEN price ELSE NULL END) AS store2, SUM(CASE WHEN store = 'store3' THEN price ELSE NULL END) AS store3 FROM products GROUP BY product_id;

/*
Gold Result:
(None, 10, None, None)
*/

-- Prediction Query
SELECT PRODUCT_ID, (SELECT P.PRICE FROM PRODUCTS AS P WHERE P.PRODUCT_ID = P2.PRODUCT_ID AND P.STORE = 'store1' LIMIT 1) AS STORE1, (SELECT P.PRICE FROM PRODUCTS AS P WHERE P.PRODUCT_ID = P2.PRODUCT_ID AND P.STORE = 'store2' LIMIT 1) AS STORE2, (SELECT P.PRICE FROM PRODUCTS AS P WHERE P.PRODUCT_ID = P2.PRODUCT_ID AND P.STORE = 'store3' LIMIT 1) AS STORE3 FROM PRODUCTS AS P2 GROUP BY PRODUCT_ID;

/*
Prediction Result:
(None, None, None, None)
*/