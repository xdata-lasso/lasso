-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'default2', NULL), (1, '2019-03-31', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, NULL, 1, '2019-01-02', NULL, NULL), (-1, NULL, -1, '2019-04-01', 1, NULL), (-1, 0, NULL, '2019-01-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT PROD.PRODUCT_ID AS PRODUCT_ID, PROD.PRODUCT_NAME AS PRODUCT_NAME FROM PRODUCT AS PROD LEFT JOIN SALES AS SALES ON PROD.PRODUCT_ID = SALES.PRODUCT_ID AND (SALES.SALE_DATE > '2019-03-31' OR SALES.SALE_DATE < '2019-01-01') WHERE SALES.SELLER_ID IS NULL;

/*
Prediction Result:
(-1, 'default2')
(1, '2019-03-31')
*/