-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER, "store" TEXT(255), "price" INTEGER, PRIMARY KEY ("product_id", "store"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO products (product_id, store, price) VALUES (0, 'store2', NULL), (-1, 'store3', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_id, SUM(CASE WHEN store = 'store1' THEN price ELSE NULL END) AS store1, SUM(CASE WHEN store = 'store2' THEN price ELSE NULL END) AS store2, SUM(CASE WHEN store = 'store3' THEN price ELSE NULL END) AS store3 FROM products GROUP BY product_id;

/*
Gold Result:
(-1, None, None, None)
(0, None, None, None)
*/

-- Prediction Query
SELECT DISTINCT PRODUCT_ID, SUM(CASE WHEN STORE = 'store1' THEN COALESCE(PRICE, 0) END) AS STORE1, SUM(CASE WHEN STORE = 'store2' THEN COALESCE(PRICE, 0) END) AS STORE2, SUM(CASE WHEN STORE = 'store3' THEN COALESCE(PRICE, 0) END) AS STORE3 FROM PRODUCTS GROUP BY PRODUCT_ID;

/*
Prediction Result:
(-1, None, None, 0)
(0, None, 0, None)
*/