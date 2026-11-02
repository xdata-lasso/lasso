-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (18, 'S8', 1);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (19, 'dense_rank20', NULL);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (18, 21, 22, '1000-01-24', 1, 1);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (19, NULL, 25, NULL, NULL, 142);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(22,)
*/

-- Prediction Query
WITH T AS (SELECT B.BUYER_ID, A.PRODUCT_NAME, DENSE_RANK() OVER (PARTITION BY B.BUYER_ID ORDER BY A.PRODUCT_NAME) AS BUY_RANK FROM PRODUCT AS A LEFT JOIN SALES AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE A.PRODUCT_NAME IN ('S8', 'iPhone')) SELECT DISTINCT BUYER_ID FROM T WHERE BUY_RANK = 1 AND PRODUCT_NAME = 'S8';

/*
Prediction Result:
(22,)
*/