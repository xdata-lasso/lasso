-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (21, 'S8', NULL);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (18, 'iPhone1', 1);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (21, 19, NULL, '1000-01-21', 1, 1);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (21, NULL, 25, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(None,)
(25,)
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES WHERE BUYER_ID IN (SELECT BUYER_ID FROM SALES JOIN PRODUCT USING (PRODUCT_ID) WHERE PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT BUYER_ID FROM SALES JOIN PRODUCT USING (PRODUCT_ID) WHERE PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
(25,)
*/