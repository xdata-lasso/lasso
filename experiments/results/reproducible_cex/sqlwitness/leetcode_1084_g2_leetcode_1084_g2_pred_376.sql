-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', 1), (-1, NULL, NULL), (1, '2019-03-31', 1), (2, NULL, 1), (3, 'default2', 1), (4, NULL, 1), (5, '2019-03-31', NULL), (6, 'default1', 1), (7, NULL, NULL), (8, '2019-03-31', NULL), (9, NULL, NULL), (10, 'default2', 1), (11, '2019-03-31', 1), (12, '2019-01-01', NULL), (13, '2019-03-31', NULL), (14, '2019-03-31', NULL), (15, NULL, 1), (16, NULL, 1), (17, '2019-03-31', 1), (18, '2019-01-01', NULL), (19, '2019-01-01', NULL), (20, '2019-01-01', NULL), (21, NULL, 1), (22, 'default2', 1), (23, '2019-03-31', NULL), (24, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 1, 1, '2019-01-02', NULL, 1), (12, 1, 1, '2018-12-31', 1, NULL), (NULL, -1, 1, '2018-12-31', NULL, NULL), (15, -1, -1, '2019-03-31', NULL, NULL), (17, 0, 1, '2023-01-02', NULL, 1), (24, 0, 0, '2019-04-01', NULL, 1), (-1, -1, -1, '2019-03-31', 1, NULL), (10, 0, NULL, NULL, 1, NULL), (NULL, 1, 0, '2019-03-30', NULL, 1), (24, NULL, NULL, '2019-03-31', 1, 1), (-1, -1, -1, '2023-01-01', NULL, NULL), (0, 1, 0, '2019-01-02', NULL, NULL), (1, 1, -1, '2023-01-01', NULL, NULL), (10, 0, 0, NULL, NULL, NULL), (12, 1, NULL, '2019-01-01', 1, NULL), (22, 0, 0, '2019-01-02', NULL, NULL), (20, -1, -1, NULL, 1, NULL), (24, -1, -1, '2019-04-01', 1, 1), (1, 1, 1, '2019-03-31', 1, NULL), (12, 1, 0, NULL, 1, NULL), (NULL, 1, NULL, '2023-01-01', NULL, NULL), (11, 1, -1, '2019-04-01', NULL, 1), (8, 1, NULL, '2019-03-31', NULL, NULL), (12, 0, 1, '2023-01-02', 1, NULL), (2, -1, 1, '2023-01-02', 1, NULL), (17, 0, 1, '2019-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(0, 'default2')
(6, 'default1')
(8, '2019-03-31')
(15, None)
(22, 'default2')
*/

-- Prediction Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P CROSS JOIN SALES AS S WHERE P.PRODUCT_ID = S.PRODUCT_ID AND NOT P.PRODUCT_ID IN (SELECT P1.PRODUCT_ID FROM PRODUCT AS P1 CROSS JOIN SALES AS S1 WHERE P1.PRODUCT_ID = S1.PRODUCT_ID AND (S1.SALE_DATE < '2019-01-01' OR S1.SALE_DATE > '2019-03-31'));

/*
Prediction Result:
(0, 'default2')
(6, 'default1')
(8, '2019-03-31')
(10, 'default2')
(15, None)
(20, '2019-01-01')
(22, 'default2')
*/