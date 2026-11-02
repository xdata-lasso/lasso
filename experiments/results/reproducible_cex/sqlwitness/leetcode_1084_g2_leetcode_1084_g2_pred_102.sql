-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, NULL), (2, 'default1', 2), (0, '2019-03-31', NULL), (-1, '2019-01-01', 1), (3, '2019-03-31', NULL), (4, '2019-03-31', NULL), (5, 'default2', 2), (6, 'default2', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 2, NULL, '2023-01-02', 2, NULL), (3, 1, -1, '2019-01-01', 1, 1), (NULL, NULL, 2, '2019-01-02', 2, 1), (3, -1, 0, '2019-01-02', 1, NULL), (-1, -1, 2, '2019-01-01', 2, 1), (4, NULL, 2, '2019-03-31', 2, NULL), (3, 1, 1, NULL, 1, 2), (0, 2, NULL, '2019-04-01', NULL, NULL), (5, 0, 0, '2018-12-31', NULL, NULL), (-1, 0, 2, '2019-03-30', NULL, 1), (3, 1, 2, '2019-03-30', NULL, 2), (-1, 1, -1, '2019-03-30', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(-1, '2019-01-01')
(3, '2019-03-31')
(4, '2019-03-31')
*/

-- Prediction Query
WITH T1 AS (SELECT P.PRODUCT_NAME, P.PRODUCT_ID, S.SALE_DATE, CASE WHEN S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN 1 ELSE 0 END AS TEMP1 FROM PRODUCT AS P INNER JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID) SELECT DISTINCT PRODUCT_ID, PRODUCT_NAME FROM T1 WHERE TEMP1 = 1 AND NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM T1 WHERE TEMP1 = 0);

/*
Prediction Result:
(-1, '2019-01-01')
(4, '2019-03-31')
*/