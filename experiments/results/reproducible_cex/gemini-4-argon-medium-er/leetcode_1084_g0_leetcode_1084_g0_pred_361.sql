-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (1, 'Test Product', 10);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (NULL, 1, 1, '2019-02-01', 1, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
*/

-- Prediction Query
SELECT X.PRODUCT_ID, PRODUCT_NAME FROM (SELECT PRODUCT_ID, MIN(SALE_DATE) AS SD, MAX(SALE_DATE) AS ED FROM SALES GROUP BY PRODUCT_ID HAVING SD BETWEEN '2019-01-01' AND '2019-03-31' AND ED BETWEEN '2019-01-01' AND '2019-03-31') AS X LEFT JOIN (SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT GROUP BY PRODUCT_ID, PRODUCT_NAME) AS Y ON X.PRODUCT_ID = Y.PRODUCT_ID;

/*
Prediction Result:
(None, None)
*/