-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER, "store" TEXT(255), "price" INTEGER, PRIMARY KEY ("product_id", "store"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: products --
INSERT INTO "products" ("product_id", "store", "price") VALUES (1, 'pro_1b9a84', 247012447);

INSERT INTO "products" ("product_id", "store", "price") VALUES (1, 'pro_328d64', 1744686505);

INSERT INTO "products" ("product_id", "store", "price") VALUES (1, 'pro_b4721a', 1115440883);

INSERT INTO "products" ("product_id", "store", "price") VALUES (1, 'store1', 1644814318);

INSERT INTO "products" ("product_id", "store", "price") VALUES (1, 'store2', 1465859724);

INSERT INTO "products" ("product_id", "store", "price") VALUES (1, 'store3', 1019800248);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_id, SUM(CASE WHEN store = 'store1' THEN price ELSE NULL END) AS store1, SUM(CASE WHEN store = 'store2' THEN price ELSE NULL END) AS store2, SUM(CASE WHEN store = 'store3' THEN price ELSE NULL END) AS store3 FROM products GROUP BY product_id;

/*
Gold Result:
(1, 1644814318, 1465859724, 1019800248)
*/

-- Prediction Query
SELECT P.PRODUCT_ID, STORE1, STORE2, STORE3 FROM (SELECT DISTINCT PRODUCT_ID FROM PRODUCTS) AS P LEFT JOIN (SELECT PRODUCT_ID, PRICE AS STORE1 FROM PRODUCTS WHERE STORE LIKE STORE1) AS S1 ON P.PRODUCT_ID = S1.PRODUCT_ID LEFT JOIN (SELECT PRODUCT_ID, PRICE AS STORE2 FROM PRODUCTS WHERE STORE LIKE STORE2) AS S2 ON P.PRODUCT_ID = S2.PRODUCT_ID LEFT JOIN (SELECT PRODUCT_ID, PRICE AS STORE3 FROM PRODUCTS WHERE STORE LIKE STORE3) AS S3 ON P.PRODUCT_ID = S3.PRODUCT_ID;

/*
Prediction Result:
(1, None, None, None)
*/