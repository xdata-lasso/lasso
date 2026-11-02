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
SELECT PRODUCT_ID, MAX(STORE1) AS STORE1, MAX(STORE2) AS STORE2, MAX(STORE3) AS STORE3 FROM (SELECT PRODUCT_ID, PRICE AS STORE1, NULL AS STORE2, NULL AS STORE3 FROM PRODUCTS WHERE STORE = 'store1' UNION ALL SELECT PRODUCT_ID, NULL AS STORE1, PRICE AS STORE2, NULL AS STORE3 FROM PRODUCTS WHERE STORE = 'store2' UNION ALL SELECT PRODUCT_ID, NULL AS STORE1, NULL AS STORE2, PRICE AS STORE3 FROM PRODUCTS WHERE STORE = 'store3') AS T GROUP BY 1;

/*
Prediction Result:
(2, 10, None, None)
*/