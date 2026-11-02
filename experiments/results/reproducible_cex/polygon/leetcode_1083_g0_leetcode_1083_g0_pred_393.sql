-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (23, 'S8', 1);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (22, 'iPhone', NULL);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (22, 24, NULL, '1000-01-26', 1, 1);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (23, 26, 33, NULL, NULL, 142);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH TEMP AS (SELECT BUYER_ID, PRODUCT_NAME FROM SALES AS T1 JOIN PRODUCT AS T2 ON T1.PRODUCT_ID = T2.PRODUCT_ID), BOTH_DATA AS (SELECT DISTINCT BUYER_ID FROM TEMP WHERE PRODUCT_NAME IN ('S8', 'iPhone')), ONLY_IPHONE AS (SELECT DISTINCT BUYER_ID FROM TEMP WHERE PRODUCT_NAME IN ('iPhone')) SELECT BUYER_ID FROM BOTH_DATA WHERE NOT BUYER_ID IN (SELECT BUYER_ID FROM ONLY_IPHONE);

/*
Prediction Result:
*/