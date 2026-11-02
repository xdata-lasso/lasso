-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (1, 'ValidProduct', 100);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (2, 'NullDateProduct', 200);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, '2019-02-01', 1, 100);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 1, 2, NULL, 1, 200);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (NULL, 2, 3, '2018-01-01', 1, 50);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (NULL, 2, 4, '2019-05-01', 1, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
WITH TA1 AS (SELECT T1.PRODUCT_ID, PRODUCT.PRODUCT_NAME FROM (SELECT S1.PRODUCT_ID FROM SALES AS S1 WHERE S1.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') AS T1 JOIN PRODUCT ON PRODUCT.PRODUCT_ID = T1.PRODUCT_ID), TA2 AS (SELECT T2.PRODUCT_ID, PRODUCT.PRODUCT_NAME FROM (SELECT S2.PRODUCT_ID FROM SALES AS S2 WHERE S2.SALE_DATE < '2019-01-01' OR S2.SALE_DATE > '2019-03-31') AS T2 JOIN PRODUCT ON PRODUCT.PRODUCT_ID = T2.PRODUCT_ID) SELECT DISTINCT TA1.PRODUCT_ID, TA1.PRODUCT_NAME FROM TA1 WHERE NOT (TA1.PRODUCT_ID) IN (SELECT TA2.PRODUCT_ID FROM TA2);

/*
Prediction Result:
(1, 'ValidProduct')
*/