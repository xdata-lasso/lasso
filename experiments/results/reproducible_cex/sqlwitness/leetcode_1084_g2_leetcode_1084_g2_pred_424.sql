-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, '2019-01-01', 1), (2, NULL, NULL), (1, 'default1', 2), (0, NULL, NULL), (3, '2019-03-31', NULL), (4, NULL, NULL), (5, 'default2', NULL), (6, '2019-01-01', 2), (7, 'default1', 1), (8, '2019-03-31', NULL), (9, '2019-03-31', 2), (10, 'default1', 2), (11, '2019-03-31', 1), (12, NULL, NULL), (13, '2019-03-31', 2), (14, '2019-03-31', NULL), (15, 'default1', 2), (16, '2019-01-01', 2), (17, NULL, 1), (18, 'default2', NULL), (19, '2019-03-31', 1), (20, '2019-03-31', NULL), (21, NULL, NULL), (22, '2019-03-31', 2), (23, '2019-03-31', 2), (24, NULL, 2), (25, '2019-03-31', 1), (26, 'default1', 2), (27, NULL, NULL), (28, 'default1', 1), (29, '2019-01-01', 1), (30, 'default2', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (11, 1, NULL, '2019-03-30', 2, 2), (22, 0, -1, NULL, 1, 2), (15, 0, -1, '2019-03-31', 2, 2), (7, 2, 0, '2019-01-01', NULL, 1), (28, -1, 2, NULL, 2, 2), (0, 2, -1, NULL, 1, 2), (20, 1, NULL, '2019-01-02', 1, 2), (12, 1, -1, NULL, NULL, 1), (18, NULL, -1, '2023-01-01', 1, NULL), (NULL, 0, 2, '2019-03-31', 1, NULL), (24, -1, NULL, '2019-01-01', 1, 2), (30, 0, 0, NULL, 1, 1), (28, NULL, 0, '2019-01-02', 1, 2), (1, NULL, 0, '2023-01-01', 1, 2), (14, 1, 1, '2019-03-30', NULL, NULL), (23, NULL, NULL, '2018-12-31', NULL, 1), (1, 2, 1, '2023-01-02', 2, NULL), (2, NULL, 1, '2023-01-02', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(7, 'default1')
(11, '2019-03-31')
(14, '2019-03-31')
(15, 'default1')
(20, '2019-03-31')
(24, None)
(28, 'default1')
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING COUNT(CASE WHEN SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN PRODUCT_ID END) = COUNT(1));

/*
Prediction Result:
(7, 'default1')
(11, '2019-03-31')
(14, '2019-03-31')
(15, 'default1')
(20, '2019-03-31')
(24, None)
*/