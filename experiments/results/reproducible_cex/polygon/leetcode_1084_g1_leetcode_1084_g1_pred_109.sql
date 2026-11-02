-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (19, '18', 1);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (18, '26', 1);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (18, 24, NULL, NULL, 797, 853);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (18, NULL, NULL, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(18, '26')
*/

-- Prediction Query
WITH MIN_MAX AS (SELECT S.PRODUCT_ID, P.PRODUCT_NAME, MIN(SALE_DATE) AS MIN_SALE, MAX(SALE_DATE) AS MAX_SALE FROM SALES AS S INNER JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY 1) SELECT MM.PRODUCT_ID, MM.PRODUCT_NAME FROM MIN_MAX AS MM WHERE MM.MIN_SALE BETWEEN '2019-01-01' AND '2019-03-31' AND MM.MAX_SALE BETWEEN '2019-01-01' AND '2019-03-31';

/*
Prediction Result:
*/