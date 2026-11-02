-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, '2019-03-31', 2), (0, '2019-01-01', 2), (2, '2019-03-31', 1), (1, '2019-03-31', NULL), (3, 'default1', NULL), (4, 'default2', NULL), (5, '2019-01-01', 2), (6, NULL, 1), (7, NULL, 1), (8, NULL, 1), (9, '2019-03-31', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, NULL, NULL, '2023-01-01', 2, 2), (8, 0, 1, '2023-01-02', 1, NULL), (-1, 2, -1, '2018-12-31', NULL, 2), (1, NULL, -1, '2019-04-01', 2, 2), (4, NULL, 2, '2023-01-02', 2, NULL), (0, 1, 1, '2019-03-30', NULL, NULL), (2, 2, 1, NULL, NULL, NULL), (-1, -1, NULL, '2019-04-01', NULL, NULL), (1, 2, -1, '2019-03-31', NULL, 1), (2, 1, 2, '2019-03-30', 2, NULL), (2, 1, 1, '2019-01-02', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(0, '2019-01-01')
(2, '2019-03-31')
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY 1 HAVING (CAST(SUM(CASE WHEN S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN 1 ELSE 0 END) AS REAL) / COUNT(*)) = 1;

/*
Prediction Result:
(0, '2019-01-01')
*/