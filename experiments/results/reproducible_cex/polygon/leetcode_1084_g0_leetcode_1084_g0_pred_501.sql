-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (17, '18', 1);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (19, '20', 1);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (17, 17, 17, '2019-01-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(17, '18')
*/

-- Prediction Query
SELECT P1.PRODUCT_ID, P1.PRODUCT_NAME FROM PRODUCT AS P1 WHERE NOT P1.PRODUCT_ID IN (SELECT DISTINCT S.PRODUCT_ID FROM SALES AS S WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31' AND QUANTITY > 0);

/*
Prediction Result:
(17, '18')
(19, '20')
*/