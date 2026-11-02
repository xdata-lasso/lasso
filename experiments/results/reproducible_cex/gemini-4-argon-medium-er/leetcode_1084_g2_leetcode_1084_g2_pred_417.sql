-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Product (product_id, product_name, unit_price) VALUES (1, 'Test Product', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
*/

-- Prediction Query
WITH TEMP AS (SELECT P.PRODUCT_ID AS PRODUCT_ID, P.PRODUCT_NAME, S.SALE_DATE FROM PRODUCT AS P LEFT JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') SELECT P2.PRODUCT_ID, P2.PRODUCT_NAME FROM PRODUCT AS P2 WHERE NOT P2.PRODUCT_ID IN (SELECT PRODUCT_ID FROM TEMP);

/*
Prediction Result:
(1, 'Test Product')
*/