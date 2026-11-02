-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (1, 'Prod1', 10);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, '2019-01-15', 1, 10);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (NULL, 1, 1, '2018-01-01', 1, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(1, 'Prod1')
*/

-- Prediction Query
WITH SALES_WITHIN_TIMEFRAME AS (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31'), SALES_OUTSIDE_TIMEFRAME AS (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') SELECT S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES_WITHIN_TIMEFRAME AS S LEFT JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID WHERE NOT S.PRODUCT_ID IN (SELECT * FROM SALES_OUTSIDE_TIMEFRAME);

/*
Prediction Result:
*/