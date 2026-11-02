-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-01-01', 2), (-1, '2019-03-31', 1), (0, '2019-03-31', 1), (2, 'default2', 1), (3, '2019-01-01', NULL), (4, NULL, 1), (5, 'default1', 1), (6, '2019-01-01', 1), (7, 'default1', NULL), (8, NULL, 2), (9, NULL, NULL), (10, 'default1', 2), (11, 'default1', 2), (12, '2019-01-01', 1), (13, '2019-03-31', 1), (14, NULL, 2), (15, '2019-03-31', NULL), (16, '2019-03-31', 1), (17, 'default2', 1), (18, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (17, -1, 2, NULL, 1, 2), (8, NULL, NULL, '2019-01-01', 1, 1), (15, 1, -1, '2023-01-01', 1, NULL), (3, NULL, 0, '2018-12-31', 1, NULL), (18, -1, 0, '2019-03-30', 1, NULL), (8, NULL, 2, '2019-01-01', 2, 1), (9, NULL, NULL, NULL, 1, NULL), (NULL, 2, 2, '2019-03-31', 1, NULL), (NULL, -1, -1, '2023-01-01', 2, 2), (11, 2, -1, '2019-04-01', 1, 2), (7, 2, 2, '2019-04-01', 1, NULL), (-1, 1, 1, '2019-04-01', 1, NULL), (4, -1, -1, '2023-01-01', 2, 2), (17, -1, NULL, '2019-01-01', 2, NULL), (13, 2, 2, '2023-01-01', 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(8, None)
(17, 'default2')
(18, 'default1')
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM (SELECT S.PRODUCT_ID, P.PRODUCT_NAME, SUM(IIF(NOT S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31', 1, 0)) AS CNT FROM SALES AS S JOIN PRODUCT AS P USING (PRODUCT_ID) GROUP BY S.PRODUCT_ID) AS SOLD_TIMES_OUT_OF_RANGE WHERE CNT = 0;

/*
Prediction Result:
(8, None)
(9, None)
(17, 'default2')
(18, 'default1')
*/