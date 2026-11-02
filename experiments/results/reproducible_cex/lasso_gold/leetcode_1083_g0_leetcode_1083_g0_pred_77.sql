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
WITH BUYER AS (SELECT BUYER_ID, PRODUCT_NAME FROM SALES LEFT JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME IN ('iPhone', 'S8') GROUP BY 1, 2) SELECT DISTINCT T1.BUYER_ID FROM (SELECT BUYER_ID FROM BUYER WHERE PRODUCT_NAME = 'S8') AS T1 JOIN (SELECT BUYER_ID FROM BUYER GROUP BY 1 HAVING COUNT(*) = 1) AS T2 ON T1.BUYER_ID = T2.BUYER_ID;

/*
Prediction Result:
(1159,)
*/