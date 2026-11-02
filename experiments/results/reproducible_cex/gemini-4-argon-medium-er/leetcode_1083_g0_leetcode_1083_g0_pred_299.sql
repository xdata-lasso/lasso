-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (1, 'S8', 100);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (2, 'iPhone', 200);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, '2023-01-01', 1, 100);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 1, NULL, '2023-01-01', 1, 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH CTE1 AS (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'S8'), CTE2 AS (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone'), CTE3 AS (SELECT DISTINCT BUYER_ID FROM SALES AS S JOIN CTE1 ON CTE1.PRODUCT_ID = S.PRODUCT_ID), CTE4 AS (SELECT DISTINCT BUYER_ID FROM SALES AS S JOIN CTE2 ON CTE2.PRODUCT_ID = S.PRODUCT_ID) SELECT CTE3.BUYER_ID FROM CTE3 LEFT JOIN CTE4 ON CTE3.BUYER_ID = CTE4.BUYER_ID WHERE CTE4.BUYER_ID IS NULL;

/*
Prediction Result:
(1,)
*/