-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (31, 'S8', 1);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (34, NULL, 1);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (31, 29, 37, '1000-01-31', 1, 1);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (34, 32, 37, '1000-02-03', 1, 142);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(37,)
*/

-- Prediction Query
SELECT A.BUYER_ID FROM (SELECT DISTINCT BUYER_ID FROM SALES WHERE PRODUCT_ID = (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'S8')) AS A LEFT JOIN (SELECT DISTINCT BUYER_ID FROM SALES WHERE PRODUCT_ID = (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone')) AS B ON A.BUYER_ID = B.BUYER_ID WHERE B.BUYER_ID IS NULL;

/*
Prediction Result:
(37,)
*/