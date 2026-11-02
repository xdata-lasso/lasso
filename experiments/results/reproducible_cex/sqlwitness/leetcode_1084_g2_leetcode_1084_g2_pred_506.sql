-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, '2019-01-01', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, -1, -1, '2023-01-02', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT TOTAL.PRODUCT_ID, TOTAL.PRODUCT_NAME FROM (SELECT DISTINCT (P.PRODUCT_ID), P.PRODUCT_NAME FROM SALES AS S LEFT OUTER JOIN PRODUCT AS P USING (PRODUCT_ID)) AS TOTAL LEFT OUTER JOIN (SELECT DISTINCT (P.PRODUCT_ID), P.PRODUCT_NAME FROM SALES AS S LEFT OUTER JOIN PRODUCT AS P USING (PRODUCT_ID) WHERE NOT S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') AS NOTSPRING USING (PRODUCT_ID) WHERE NOTSPRING.PRODUCT_ID IS NULL;

/*
Prediction Result:
(None, None)
*/