-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (11, NULL, NULL);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (12, '19', NULL);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (NULL, NULL, NULL, '2019-01-01', NULL, NULL);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (12, 17, NULL, '2019-01-01', NULL, 797);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(12, '19')
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P USING (PRODUCT_ID) GROUP BY P.PRODUCT_ID HAVING (MAX(SALE_DATE) BETWEEN '2019-01-01' AND '2019-03-31') AND (MIN(SALE_DATE) BETWEEN '2019-01-01' AND '2019-03-31');

/*
Prediction Result:
(None, None)
(12, '19')
*/