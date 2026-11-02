-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1182, 'S8', 1183);
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1188, 'S8', 1183);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1182, 1184, NULL, '1996-05-04', 1186, 1187);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(None,)
*/

-- Prediction Query
WITH IPHONEBUYERS AS (SELECT BUYER_ID FROM SALES AS A CROSS JOIN PRODUCT AS B WHERE A.PRODUCT_ID = B.PRODUCT_ID AND B.PRODUCT_NAME = 'iPhone'), S8BUYERS AS (SELECT BUYER_ID FROM SALES AS A CROSS JOIN PRODUCT AS B WHERE A.PRODUCT_ID = B.PRODUCT_ID AND B.PRODUCT_NAME = 'S8') SELECT DISTINCT A.BUYER_ID FROM SALES AS A CROSS JOIN S8BUYERS AS I WHERE A.BUYER_ID = I.BUYER_ID AND NOT A.BUYER_ID IN (SELECT BUYER_ID FROM IPHONEBUYERS);

/*
Prediction Result:
*/