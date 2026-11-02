-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1001, 'S8', 1002);
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1007, 'S8', 1002);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1001, 1003, 1004, '1970-01-01', 1005, 1006);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(1004,)
*/

-- Prediction Query
WITH CTE1 AS (SELECT S.BUYER_ID, SUM(CASE WHEN P.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8_FLG, SUM(CASE WHEN P.PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IPHONE_FLG FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY S.BUYER_ID) SELECT BUYER_ID FROM CTE1 WHERE S8_FLG >= '1' AND IPHONE_FLG = '0';

/*
Prediction Result:
*/