-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (20, 'S8', 1);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (19, 'S820', 1);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (20, 25, 36, '1000-01-27', NULL, 1);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (20, 27, NULL, '1000-01-30', 1, 142);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(36,)
*/

-- Prediction Query
WITH CTE1 AS (SELECT SALES.BUYER_ID, SALES.PRODUCT_ID FROM SALES LEFT JOIN (SELECT BUYER_ID, PRODUCT_NAME, PRODUCT.PRODUCT_ID FROM SALES INNER JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT.PRODUCT_NAME = 'iPhone') AS P ON SALES.BUYER_ID = P.BUYER_ID WHERE P.BUYER_ID IS NULL) SELECT DISTINCT CTE1.BUYER_ID AS BUYER_ID FROM CTE1 LEFT JOIN PRODUCT ON CTE1.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT.PRODUCT_NAME = 'S8';

/*
Prediction Result:
(36,)
(None,)
*/