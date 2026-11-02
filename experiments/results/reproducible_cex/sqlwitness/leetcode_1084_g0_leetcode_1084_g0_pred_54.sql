-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', 1), (0, 'default1', 1), (-1, '2019-03-31', 1), (2, 'default1', 2), (3, 'default2', NULL), (4, '2019-01-01', 1), (5, NULL, 2), (6, '2019-03-31', 2), (7, NULL, NULL), (8, '2019-03-31', 2), (9, 'default2', 1), (10, '2019-01-01', 1), (11, '2019-01-01', 2), (12, '2019-03-31', 1), (13, '2019-03-31', NULL), (14, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (14, NULL, 1, '2019-03-30', 2, 1), (4, 2, 0, '2023-01-01', NULL, 2), (6, 0, NULL, '2019-03-30', NULL, 1), (-1, 2, NULL, '2019-03-31', NULL, 1), (12, NULL, 2, '2023-01-02', 1, 1), (12, 0, 2, NULL, 1, 2), (8, 2, 0, '2018-12-31', 2, NULL), (4, -1, 0, '2018-12-31', 2, 1), (2, 2, 2, NULL, 2, 1), (0, 1, 2, '2019-01-02', 2, 1), (7, 0, 2, '2018-12-31', 1, 1), (6, 0, -1, '2019-03-30', 1, 1), (9, 1, NULL, NULL, 2, 2), (1, -1, 0, '2023-01-01', 1, 1), (8, -1, 0, '2019-01-01', 2, NULL), (2, 2, -1, '2019-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(-1, '2019-03-31')
(0, 'default1')
(2, 'default1')
(6, '2019-03-31')
(14, 'default1')
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY 1 HAVING (CAST(SUM(CASE WHEN S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN 1 ELSE 0 END) AS REAL) / COUNT(*)) = 1;

/*
Prediction Result:
(-1, '2019-03-31')
(0, 'default1')
(6, '2019-03-31')
(14, 'default1')
*/