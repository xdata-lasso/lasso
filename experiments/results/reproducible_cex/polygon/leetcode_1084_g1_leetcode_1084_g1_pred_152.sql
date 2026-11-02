-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (26, '1', 797);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (33, '34', 1);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (NULL, 36, 37, '2019-01-01', 1, 1);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (33, 31, 32, '2019-01-02', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(33, '34')
*/

-- Prediction Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE CAST((JULIANDAY(S.SALE_DATE) - JULIANDAY('2019-01-01')) AS INTEGER) >= 0 AND CAST((JULIANDAY('2019-03-31') - JULIANDAY(S.SALE_DATE)) AS INTEGER) >= 0 AND NOT P.PRODUCT_ID IN (SELECT DISTINCT P.PRODUCT_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE CAST((JULIANDAY('2019-01-01') - JULIANDAY(S.SALE_DATE)) AS INTEGER) > 0 OR CAST((JULIANDAY(S.SALE_DATE) - JULIANDAY('2019-03-31')) AS INTEGER) > 0);

/*
Prediction Result:
(None, None)
(33, '34')
*/