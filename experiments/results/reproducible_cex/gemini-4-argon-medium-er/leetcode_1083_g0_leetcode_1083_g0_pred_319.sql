-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (1, 'S8', 100);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (2, 'iPhone', 200);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, '2020-01-01', 1, 100);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 1, NULL, '2020-01-01', 1, 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT SS8.BUYER_ID FROM SALES AS SS8 INNER JOIN PRODUCT AS PS8 ON PS8.PRODUCT_ID = SS8.PRODUCT_ID AND PRODUCT_NAME = 'S8' LEFT JOIN (SELECT BUYER_ID, S.PRODUCT_ID FROM SALES AS S INNER JOIN PRODUCT AS PIPHONE ON PIPHONE.PRODUCT_ID = S.PRODUCT_ID AND PIPHONE.PRODUCT_NAME = 'iPhone') AS SIPHONE ON SS8.BUYER_ID = SIPHONE.BUYER_ID WHERE NOT PS8.PRODUCT_ID IS NULL AND SIPHONE.PRODUCT_ID IS NULL;

/*
Prediction Result:
(1,)
*/