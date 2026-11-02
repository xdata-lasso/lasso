-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (41, 'S8', NULL);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (31, NULL, 1);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (41, NULL, 37, '1000-02-08', 1, 1);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (41, 39, 37, '1000-02-10', 1, 142);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(37,)
*/

-- Prediction Query
WITH CTE1 AS (SELECT S.BUYER_ID AS BOUGHTS8 FROM SALES AS S WHERE S.PRODUCT_ID = (SELECT P.PRODUCT_ID FROM PRODUCT AS P WHERE P.PRODUCT_NAME = 'S8')), CTE2 AS (SELECT S.BUYER_ID AS BOUGHTIPHONE FROM SALES AS S WHERE S.PRODUCT_ID = (SELECT P.PRODUCT_ID FROM PRODUCT AS P WHERE P.PRODUCT_NAME = 'iPhone')) SELECT DISTINCT S.BUYER_ID FROM SALES AS S WHERE S.BUYER_ID IN (SELECT BOUGHTS8 FROM CTE1) AND NOT S.BUYER_ID IN (SELECT BOUGHTIPHONE FROM CTE2);

/*
Prediction Result:
(37,)
*/