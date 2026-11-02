-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER, "store" TEXT(255), "price" INTEGER, PRIMARY KEY ("product_id", "store"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Products (product_id, store, price) VALUES (1, 'store4', 99);
INSERT INTO Products (product_id, store, price) VALUES (2, 'store1', 10);
INSERT INTO Products (product_id, store, price) VALUES (2, 'store4', 20);
INSERT INTO Products (product_id, store, price) VALUES (3, 'Store1', 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_id, SUM(CASE WHEN store = 'store1' THEN price ELSE NULL END) AS store1, SUM(CASE WHEN store = 'store2' THEN price ELSE NULL END) AS store2, SUM(CASE WHEN store = 'store3' THEN price ELSE NULL END) AS store3 FROM products GROUP BY product_id;

/*
Gold Result:
(1, None, None, None)
(2, 10, None, None)
(3, None, None, None)
*/

-- Prediction Query
WITH T1 AS (SELECT PRODUCT_ID, SUM(PRICE) AS STORE1 FROM PRODUCTS WHERE STORE = 'store1' GROUP BY 1), T2 AS (SELECT PRODUCT_ID, SUM(PRICE) AS STORE2 FROM PRODUCTS WHERE STORE = 'store2' GROUP BY 1), T3 AS (SELECT PRODUCT_ID, SUM(PRICE) AS STORE3 FROM PRODUCTS WHERE STORE = 'store3' GROUP BY 1), T4 AS (SELECT DISTINCT PRODUCT_ID FROM T1 UNION ALL SELECT DISTINCT PRODUCT_ID FROM T2 UNION ALL SELECT DISTINCT PRODUCT_ID FROM T3) SELECT DISTINCT PRODUCT_ID, STORE1, STORE2, STORE3 FROM T4 LEFT JOIN T1 USING (PRODUCT_ID) LEFT JOIN T2 USING (PRODUCT_ID) LEFT JOIN T3 USING (PRODUCT_ID) GROUP BY 1;

/*
Prediction Result:
(2, 10, None, None)
*/