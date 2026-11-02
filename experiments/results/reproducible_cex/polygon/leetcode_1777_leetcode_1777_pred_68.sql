-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER, "store" TEXT(255), "price" INTEGER, PRIMARY KEY ("product_id", "store"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_id, SUM(CASE WHEN store = 'store1' THEN price ELSE NULL END) AS store1, SUM(CASE WHEN store = 'store2' THEN price ELSE NULL END) AS store2, SUM(CASE WHEN store = 'store3' THEN price ELSE NULL END) AS store3 FROM products GROUP BY product_id;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT PRODUCT_ID, SUM(CASE WHEN STORE = 'store1' THEN PRICE END) AS STORE1, SUM(CASE WHEN STORE = 'store2' THEN PRICE END) AS STORE2, SUM(CASE WHEN STORE = 'store3' THEN PRICE END) AS STORE3 FROM PRODUCTS GROUP BY PRODUCT_ID) SELECT * FROM CTE;

/*
Prediction Result:
*/