-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER, "store" TEXT(255), "price" INTEGER, PRIMARY KEY ("product_id", "store"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "products" ("product_id", "store", "price") VALUES (1033, 'store1', 1036);
INSERT INTO "products" ("product_id", "store", "price") VALUES (1033, 'store2', 1043.0);
INSERT INTO "products" ("product_id", "store", "price") VALUES (1033, 'store3', 1050.0);
INSERT INTO "products" ("product_id", "store", "price") VALUES (NULL, 'store1', 1053);
INSERT INTO "products" ("product_id", "store", "price") VALUES (NULL, 'store2', 1060.0);
INSERT INTO "products" ("product_id", "store", "price") VALUES (NULL, 'store3', 1067.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_id, SUM(CASE WHEN store = 'store1' THEN price ELSE NULL END) AS store1, SUM(CASE WHEN store = 'store2' THEN price ELSE NULL END) AS store2, SUM(CASE WHEN store = 'store3' THEN price ELSE NULL END) AS store3 FROM products GROUP BY product_id;

/*
Gold Result:
(None, 1053, 1060, 1067)
(1033, 1036, 1043, 1050)
*/

-- Prediction Query
WITH CTE1 AS (SELECT P1.PRODUCT_ID, P1.PRICE AS STORE1 FROM PRODUCTS AS P1 WHERE P1.STORE = 'store1'), CTE2 AS (SELECT P2.PRODUCT_ID, P2.PRICE AS STORE2 FROM PRODUCTS AS P2 WHERE P2.STORE = 'store2'), CTE3 AS (SELECT P3.PRODUCT_ID, P3.PRICE AS STORE3 FROM PRODUCTS AS P3 WHERE P3.STORE = 'store3') SELECT DISTINCT P.PRODUCT_ID, CTE1.STORE1, CTE2.STORE2, CTE3.STORE3 FROM PRODUCTS AS P LEFT OUTER JOIN CTE1 ON P.PRODUCT_ID = CTE1.PRODUCT_ID LEFT OUTER JOIN CTE2 ON P.PRODUCT_ID = CTE2.PRODUCT_ID LEFT OUTER JOIN CTE3 ON P.PRODUCT_ID = CTE3.PRODUCT_ID;

/*
Prediction Result:
(None, None, None, None)
(1033, 1036, 1043, 1050)
*/