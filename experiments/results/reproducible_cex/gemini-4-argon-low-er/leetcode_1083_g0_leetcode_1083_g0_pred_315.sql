-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (1, 'S8', 100);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (2, 'iPhone', 100);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, '2023-01-01', 1, 100);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 1, NULL, '2023-01-01', 1, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT BUYER_ID FROM PRODUCT AS P INNER JOIN SALES AS S ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8'), CTE2 AS (SELECT BUYER_ID FROM PRODUCT AS P INNER JOIN SALES AS S ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'iPhone') SELECT DISTINCT A.BUYER_ID FROM CTE AS A LEFT JOIN CTE2 AS B ON A.BUYER_ID = B.BUYER_ID WHERE B.BUYER_ID IS NULL;

/*
Prediction Result:
(1,)
*/