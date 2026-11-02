-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', 2), (1, '2019-03-31', 1), (-1, '2019-01-01', NULL), (2, '2019-01-01', NULL), (3, '2019-03-31', NULL), (4, 'default1', 1), (5, '2019-03-31', NULL), (6, 'default1', 1), (7, NULL, 1), (8, 'default2', 1), (9, '2019-03-31', NULL), (10, 'default1', NULL), (11, '2019-03-31', NULL), (12, NULL, NULL), (13, 'default1', 1), (14, '2019-03-31', 1), (15, 'default1', 2), (16, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 2, NULL, '2019-03-31', 1, NULL), (14, NULL, NULL, '2023-01-02', NULL, NULL), (8, -1, -1, '2023-01-02', NULL, 2), (16, 1, 1, '2023-01-01', 1, 1), (NULL, 1, -1, '2019-01-02', 2, 1), (2, -1, 0, NULL, NULL, 2), (6, -1, 1, NULL, NULL, 1), (8, 2, 2, '2019-01-01', 1, NULL), (2, 1, 0, '2019-04-01', NULL, NULL), (14, 0, 1, '2018-12-31', 1, 1), (15, 2, NULL, '2023-01-02', NULL, 1), (1, 1, 2, '2019-04-01', 1, 1), (1, 1, 1, '2023-01-02', NULL, 1), (8, 0, NULL, '2023-01-02', 2, NULL), (15, 0, NULL, '2019-01-01', 1, NULL), (5, 1, 0, '2018-12-31', 2, NULL), (14, 1, NULL, '2023-01-01', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(4, 'default1')
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM (SELECT S.PRODUCT_ID, P.PRODUCT_NAME, SUM(IIF(NOT S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31', 1, 0)) AS CNT FROM SALES AS S JOIN PRODUCT AS P USING (PRODUCT_ID) GROUP BY S.PRODUCT_ID) AS SOLD_TIMES_OUT_OF_RANGE WHERE CNT = 0;

/*
Prediction Result:
(4, 'default1')
(6, 'default1')
*/