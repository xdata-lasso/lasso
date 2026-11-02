-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (23, NULL, NULL);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (24, '28', NULL);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (24, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (24, NULL, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
*/

-- Prediction Query
SELECT TOTAL.PRODUCT_ID, TOTAL.PRODUCT_NAME FROM (SELECT DISTINCT (P.PRODUCT_ID), P.PRODUCT_NAME FROM SALES AS S LEFT OUTER JOIN PRODUCT AS P USING (PRODUCT_ID)) AS TOTAL LEFT OUTER JOIN (SELECT DISTINCT (P.PRODUCT_ID), P.PRODUCT_NAME FROM SALES AS S LEFT OUTER JOIN PRODUCT AS P USING (PRODUCT_ID) WHERE NOT S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') AS NOTSPRING USING (PRODUCT_ID) WHERE NOTSPRING.PRODUCT_ID IS NULL;

/*
Prediction Result:
(24, '28')
*/