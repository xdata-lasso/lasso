-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1156, 'S8', 1157);
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1162, 'S8', 1157);
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1163, 'iPhone', 1164);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1156, 1158, 1159, '1992-01-23', 1160, 1161);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1163, 1165, NULL, '1993-02-01', 1166, 1167);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH A AS (SELECT BUYER_ID, SUM(CASE WHEN PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8FLAG, SUM(CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IPFLAG FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY BUYER_ID) SELECT BUYER_ID FROM A WHERE S8FLAG >= 1 AND IPFLAG = 0;

/*
Prediction Result:
(1159,)
*/