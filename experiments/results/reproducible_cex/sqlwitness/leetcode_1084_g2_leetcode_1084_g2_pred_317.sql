-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, '2019-03-31', 2), (-1, 'default1', 2), (1, 'default1', 2), (0, 'default2', 2), (3, '2019-03-31', 1), (4, 'default2', 2), (5, '2019-01-01', 2), (6, NULL, 1), (7, 'default1', 1), (8, 'default1', 2), (9, '2019-01-01', NULL), (10, '2019-03-31', 1), (11, '2019-03-31', NULL), (12, NULL, 1), (13, 'default2', 2), (14, NULL, NULL), (15, NULL, 2), (16, NULL, 1), (17, '2019-01-01', 2), (18, 'default1', NULL), (19, '2019-01-01', 1), (20, 'default2', 1), (21, 'default1', NULL), (22, 'default1', NULL), (23, '2019-03-31', 2), (24, 'default2', 2), (25, '2019-01-01', 2), (26, '2019-03-31', 1), (27, '2019-01-01', NULL), (28, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 0, 2, '2023-01-01', NULL, 2), (17, NULL, NULL, '2023-01-02', NULL, 1), (27, 1, 1, '2023-01-01', 1, 2), (10, 1, 1, '2023-01-01', NULL, NULL), (6, NULL, 2, NULL, 1, 1), (18, 2, 0, '2018-12-31', 2, 2), (2, 2, 2, '2023-01-01', 1, 1), (25, 1, 1, '2023-01-01', 1, 2), (19, -1, NULL, '2019-01-01', NULL, NULL), (2, -1, NULL, '2023-01-02', NULL, 2), (27, 1, -1, '2019-03-31', NULL, 2), (21, 1, -1, '2019-03-31', 2, NULL), (4, NULL, -1, '2019-03-31', NULL, 2), (15, 2, NULL, '2023-01-02', 1, 2), (10, 0, 1, '2023-01-02', 2, NULL), (18, 2, NULL, '2019-01-01', 1, 1), (21, NULL, 1, '2019-03-30', 1, NULL), (21, 2, NULL, NULL, 2, 2), (0, 0, -1, '2019-03-30', 2, 1), (28, -1, -1, '2019-03-30', 2, 1), (1, -1, 0, '2019-03-30', NULL, NULL), (13, 2, -1, '2019-03-31', 1, NULL), (1, 0, 0, '2023-01-02', NULL, NULL), (14, -1, 0, '2019-04-01', 1, 2), (0, NULL, 2, '2019-03-31', NULL, 1), (25, 0, 0, '2019-03-30', NULL, 1), (22, 1, 1, '2023-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(0, 'default2')
(4, 'default2')
(13, 'default2')
(19, '2019-01-01')
(21, 'default1')
(28, None)
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES GROUP BY 1 HAVING COUNT(CASE WHEN SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN PRODUCT_ID END) = COUNT(PRODUCT_ID));

/*
Prediction Result:
(0, 'default2')
(4, 'default2')
(13, 'default2')
(19, '2019-01-01')
(28, None)
*/