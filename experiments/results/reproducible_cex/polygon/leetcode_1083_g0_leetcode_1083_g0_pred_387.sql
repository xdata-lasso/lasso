-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (29, 'S8', 1);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (22, NULL, NULL);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (29, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT DISTINCT (BUYER_ID) FROM SALES WHERE NOT BUYER_ID IN (SELECT S1.BUYER_ID FROM SALES AS S1 JOIN PRODUCT AS P1 ON S1.PRODUCT_ID = P1.PRODUCT_ID WHERE P1.PRODUCT_NAME = 'iPhone') AND BUYER_ID IN (SELECT S1.BUYER_ID FROM SALES AS S1 JOIN PRODUCT AS P1 ON S1.PRODUCT_ID = P1.PRODUCT_ID WHERE P1.PRODUCT_NAME = 'S8');

/*
Prediction Result:
*/