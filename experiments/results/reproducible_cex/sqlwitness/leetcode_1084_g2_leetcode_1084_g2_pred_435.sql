-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-03-31', 2), (0, 'default2', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 3, 1, '2023-01-01', 1, 3), (NULL, 0, 0, '2019-03-31', NULL, 3), (0, 1, NULL, '2019-01-02', 3, 3), (1, 0, 0, '2019-03-31', 2, 3), (0, -1, -1, '2019-01-02', 3, NULL), (0, -1, NULL, '2019-04-01', NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(1, '2019-03-31')
*/

-- Prediction Query
WITH SALES_REPORT AS (SELECT A.PRODUCT_ID, A.PRODUCT_NAME, SUM(CASE WHEN SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN QUANTITY ELSE 0 END) AS "2019_SPRING_SALES", SUM(CASE WHEN SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN 0 ELSE QUANTITY END) AS OTHER_SALES FROM PRODUCT AS A INNER JOIN SALES AS B ON A.PRODUCT_ID = B.PRODUCT_ID GROUP BY 1, 2) SELECT PRODUCT_ID, PRODUCT_NAME FROM SALES_REPORT WHERE OTHER_SALES = 0 AND "2019_SPRING_SALES" > 0;

/*
Prediction Result:
(0, 'default2')
(1, '2019-03-31')
*/