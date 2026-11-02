-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (14, NULL, NULL);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (15, '25', 1);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (14, NULL, NULL, '2019-01-01', NULL, NULL);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (15, 23, 24, NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(14, None)
*/

-- Prediction Query
WITH CTE AS (SELECT A.PRODUCT_ID, A.PRODUCT_NAME, B.SALE_DATE, B.QUANTITY FROM PRODUCT AS A LEFT JOIN SALES AS B ON A.PRODUCT_ID = B.PRODUCT_ID) SELECT PRODUCT_ID, PRODUCT_NAME FROM (SELECT PRODUCT_ID, PRODUCT_NAME, SUM(CASE WHEN SALE_DATE >= DATE('2019-01-01') AND SALE_DATE <= ('2019-03-31') THEN QUANTITY ELSE 0 END) AS SPRING_19_SALES, SUM(CASE WHEN SALE_DATE < DATE('2019-01-01') OR SALE_DATE > ('2019-03-31') THEN QUANTITY ELSE 0 END) AS OTHER_SALES FROM CTE GROUP BY PRODUCT_ID) AS C WHERE SPRING_19_SALES > 0 AND OTHER_SALES = 0;

/*
Prediction Result:
*/