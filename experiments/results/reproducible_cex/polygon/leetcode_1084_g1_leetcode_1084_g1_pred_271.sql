-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (32, '33', NULL);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (31, NULL, 1);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (32, NULL, NULL, '2019-01-01', NULL, NULL);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (31, 28, 29, NULL, 1, 853);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(32, '33')
(31, None)
*/

-- Prediction Query
WITH CTE AS (SELECT A.PRODUCT_ID, A.SALE_DATE, B.PRODUCT_NAME FROM SALES AS A JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID) SELECT PRODUCT_ID, PRODUCT_NAME FROM CTE WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM CTE WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') AND NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM CTE WHERE (SALE_DATE < '2019-01-01') OR (SALE_DATE > '2019-03-31')) GROUP BY PRODUCT_ID, PRODUCT_NAME;

/*
Prediction Result:
(32, '33')
*/