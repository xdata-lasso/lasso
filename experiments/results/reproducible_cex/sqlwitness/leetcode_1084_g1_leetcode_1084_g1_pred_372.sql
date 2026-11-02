-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', 1), (1, '2019-01-01', 1), (2, '2019-03-31', 1), (3, '2019-01-01', NULL), (4, '2019-03-31', NULL), (5, '2019-03-31', NULL), (6, NULL, 1), (7, 'default1', NULL), (8, '2019-01-01', 1), (9, 'default2', 1), (10, NULL, NULL), (11, 'default1', NULL), (12, 'default1', NULL), (13, 'default1', NULL), (14, '2019-01-01', 1), (15, '2019-03-31', 1), (16, NULL, 1), (17, '2019-03-31', 1), (18, 'default1', 1), (19, 'default1', 1), (20, 'default2', 1), (21, 'default2', 1), (22, '2019-03-31', NULL), (23, '2019-03-31', NULL), (24, '2019-03-31', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (17, 0, 0, '2018-12-31', 1, NULL), (12, 1, 1, '2019-04-01', 1, 1), (13, NULL, NULL, '2023-01-01', NULL, 1), (19, 1, 0, '2018-12-31', NULL, 1), (13, 1, 1, '2019-01-01', NULL, NULL), (23, 1, 0, '2023-01-02', 1, NULL), (21, 0, 0, '2023-01-02', NULL, NULL), (13, 1, NULL, '2019-04-01', NULL, NULL), (6, NULL, NULL, '2019-04-01', 1, NULL), (12, 1, NULL, '2019-04-01', 1, 1), (22, 1, 0, '2019-01-01', NULL, 1), (7, 1, NULL, '2019-01-01', NULL, NULL), (4, NULL, NULL, '2018-12-31', 1, 1), (7, 0, 0, '2019-03-31', 1, 1), (1, NULL, NULL, NULL, NULL, 1), (23, 1, 0, '2019-03-30', NULL, 1), (23, 0, 1, NULL, 1, NULL), (13, 0, 1, NULL, NULL, NULL), (22, 0, 1, '2019-03-31', NULL, 1), (12, NULL, NULL, '2019-01-02', NULL, 1), (23, NULL, NULL, '2023-01-01', 1, NULL), (2, 1, 0, '2023-01-01', 1, NULL), (9, NULL, 0, '2019-03-31', NULL, 1), (14, 1, 1, '2019-03-31', 1, 1), (23, 0, NULL, '2019-04-01', NULL, 1), (0, NULL, 0, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(22, '2019-03-31')
(7, 'default1')
(1, '2019-01-01')
(9, 'default2')
(14, '2019-01-01')
(0, 'default2')
*/

-- Prediction Query
WITH Q1PRODUCTS AS (SELECT DISTINCT A.PRODUCT_ID, B.PRODUCT_NAME FROM SALES AS A INNER JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE SALE_DATE >= '2019-01-01' AND SALE_DATE <= '2019-03-31') SELECT PRODUCT_ID, PRODUCT_NAME FROM Q1PRODUCTS WHERE NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
(22, '2019-03-31')
(7, 'default1')
(9, 'default2')
(14, '2019-01-01')
*/