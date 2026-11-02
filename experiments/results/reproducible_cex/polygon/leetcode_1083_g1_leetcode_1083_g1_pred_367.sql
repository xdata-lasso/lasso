-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (21, 'S8', 1);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (20, 'iPhone1', 1);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (21, 29, 30, NULL, 1, NULL);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (21, 26, NULL, '1000-01-29', NULL, 142);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(30,)
*/

-- Prediction Query
WITH IP AS (SELECT BUYER_ID FROM PRODUCT AS P JOIN SALES AS S ON S.PRODUCT_ID = P.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone') SELECT S.BUYER_ID FROM PRODUCT AS P JOIN SALES AS S ON S.PRODUCT_ID = P.PRODUCT_ID LEFT JOIN IP ON IP.BUYER_ID = S.BUYER_ID WHERE P.PRODUCT_NAME = 'S8' AND IP.BUYER_ID IS NULL GROUP BY 1;

/*
Prediction Result:
(None,)
(30,)
*/