-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (14, 'S8', NULL);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (13, 'S8', 1);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (14, NULL, 20, NULL, NULL, NULL);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (13, 22, NULL, '1000-01-25', 1, 142);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(20,)
*/

-- Prediction Query
SELECT BUYER_ID FROM (SELECT BUYER_ID, SUM(CASE WHEN P1.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8_CNT, SUM(CASE WHEN P1.PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IPHONE_CNT FROM SALES AS S1 INNER JOIN PRODUCT AS P1 ON S1.PRODUCT_ID = P1.PRODUCT_ID GROUP BY BUYER_ID) AS PC WHERE S8_CNT > 0 AND IPHONE_CNT = 0;

/*
Prediction Result:
(None,)
(20,)
*/