-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (1, 'S8', 1000);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 10, 100, '2023-01-01', 1, 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(100,)
*/

-- Prediction Query
WITH S8_ID AS (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'S8'), IPHONE_ID AS (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone') SELECT BUYER_ID FROM SALES AS S CROSS JOIN S8_ID AS S8 CROSS JOIN IPHONE_ID AS IP GROUP BY BUYER_ID HAVING SUM(IIF(S.PRODUCT_ID = S8.PRODUCT_ID, 1, 0)) > 0 AND SUM(IIF(S.PRODUCT_ID = IP.PRODUCT_ID, 1, 0)) = 0;

/*
Prediction Result:
*/