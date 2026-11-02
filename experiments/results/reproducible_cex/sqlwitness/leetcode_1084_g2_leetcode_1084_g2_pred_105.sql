-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, '2019-01-01', NULL), (0, '2019-01-01', 1), (2, '2019-03-31', NULL), (1, '2019-01-01', NULL), (3, '2019-03-31', NULL), (4, '2019-03-31', NULL), (5, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 1, -1, '2023-01-02', 2, NULL), (2, -1, 0, '2023-01-01', NULL, 1), (NULL, 1, 2, '2019-01-02', NULL, 1), (2, 2, -1, '2019-01-02', 1, 2), (-1, 1, NULL, '2019-01-02', 1, 2), (-1, 1, 1, NULL, NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(-1, '2019-01-01')
*/

-- Prediction Query
WITH CTE AS (SELECT PRODUCT_ID, SUM(QUANTITY) AS TOTAL_SOLD, SUM(CASE WHEN SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN QUANTITY ELSE 0 END) AS SOLD_SPRING FROM SALES GROUP BY 1) SELECT C.PRODUCT_ID, P.PRODUCT_NAME FROM CTE AS C JOIN PRODUCT AS P ON C.PRODUCT_ID = P.PRODUCT_ID WHERE TOTAL_SOLD = SOLD_SPRING;

/*
Prediction Result:
(-1, '2019-01-01')
(2, '2019-03-31')
*/