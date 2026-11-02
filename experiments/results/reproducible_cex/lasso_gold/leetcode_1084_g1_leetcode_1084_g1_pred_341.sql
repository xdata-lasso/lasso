-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (NULL, 1152, 1153, '2019-02-14', 1154, 1155);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
WITH T AS (SELECT SALES_DATA.PRODUCT_ID, SUM(SALE_OUT) AS DONT_INCL FROM (SELECT *, (S.SALE_DATE > '2019-03-31') OR (S.SALE_DATE < '2019-01-01') AS SALE_OUT FROM SALES AS S) AS SALES_DATA GROUP BY SALES_DATA.PRODUCT_ID) SELECT T.PRODUCT_ID, P.PRODUCT_NAME FROM T LEFT JOIN PRODUCT AS P ON T.PRODUCT_ID = P.PRODUCT_ID WHERE T.DONT_INCL = 0;

/*
Prediction Result:
(None, None)
*/