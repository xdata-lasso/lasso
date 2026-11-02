-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER, "store" TEXT(255), "price" INTEGER, PRIMARY KEY ("product_id", "store"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Products (product_id, store, price) VALUES (5, 'store1', NULL);
INSERT INTO Products (product_id, store, price) VALUES (5, 'store2', 1);
INSERT INTO Products (product_id, store, price) VALUES (6, 'store3', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_id, SUM(CASE WHEN store = 'store1' THEN price ELSE NULL END) AS store1, SUM(CASE WHEN store = 'store2' THEN price ELSE NULL END) AS store2, SUM(CASE WHEN store = 'store3' THEN price ELSE NULL END) AS store3 FROM products GROUP BY product_id;

/*
Gold Result:
(5, None, 1, None)
(6, None, None, None)
*/

-- Prediction Query
SELECT PRODUCT_ID, SUM(CASE WHEN STORE = 'store1' THEN COALESCE(PRICE, 0) END) AS STORE1, SUM(CASE WHEN STORE = 'store2' THEN COALESCE(PRICE, 0) END) AS STORE2, SUM(CASE WHEN STORE = 'store3' THEN COALESCE(PRICE, 0) END) AS STORE3 FROM PRODUCTS GROUP BY 1;

/*
Prediction Result:
(5, 0, 1, None)
(6, None, None, 0)
*/