-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (32, '33', 1);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (22, '29', NULL);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (32, NULL, NULL, '2019-01-01', NULL, NULL);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (22, 27, 28, NULL, 1, 853);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(32, '33')
(22, '29')
*/

-- Prediction Query
WITH Q1PRODUCTS AS (SELECT DISTINCT A.PRODUCT_ID, B.PRODUCT_NAME FROM SALES AS A INNER JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE SALE_DATE >= '2019-01-01' AND SALE_DATE <= '2019-03-31') SELECT PRODUCT_ID, PRODUCT_NAME FROM Q1PRODUCTS WHERE NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
(32, '33')
*/