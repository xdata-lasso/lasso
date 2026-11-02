-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-01-01', NULL), (0, '2019-03-31', NULL), (2, NULL, 1), (3, '2019-01-01', NULL), (4, '2019-03-31', NULL), (5, '2019-03-31', 1), (6, '2019-01-01', NULL), (7, 'default2', 1), (8, NULL, NULL), (9, '2019-03-31', NULL), (10, '2019-03-31', 1), (11, '2019-01-01', 1), (12, 'default2', 1), (13, NULL, NULL), (14, NULL, NULL), (15, '2019-03-31', 1), (16, 'default1', NULL), (17, '2019-03-31', NULL), (18, '2019-03-31', 1), (19, NULL, NULL), (20, 'default2', NULL), (21, 'default1', NULL), (22, 'default1', 1), (23, 'default1', 1), (24, 'default2', NULL), (25, 'default2', NULL), (26, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (17, NULL, 0, '2023-01-02', 1, NULL), (23, 0, NULL, '2023-01-02', 1, NULL), (6, 0, NULL, '2018-12-31', NULL, 1), (NULL, 1, 1, '2019-04-01', NULL, NULL), (15, 0, 0, '2019-03-31', 1, NULL), (18, 1, 0, NULL, 1, 1), (12, NULL, NULL, '2019-03-30', 1, 1), (0, NULL, 0, '2023-01-01', NULL, 1), (0, NULL, 1, '2019-04-01', 1, NULL), (23, 1, 0, '2023-01-02', NULL, NULL), (22, NULL, 1, '2019-01-02', 1, 1), (21, 1, 1, '2019-04-01', NULL, NULL), (20, NULL, 1, '2023-01-01', NULL, NULL), (8, 0, 1, '2023-01-02', 1, NULL), (14, 1, 1, '2019-01-01', 1, 1), (4, 1, NULL, '2019-01-01', 1, NULL), (4, 1, 0, '2023-01-01', 1, 1), (NULL, 1, 1, '2018-12-31', 1, 1), (16, NULL, 1, '2019-03-31', 1, 1), (14, 1, 1, '2019-03-31', NULL, NULL), (18, 0, 0, '2023-01-02', 1, NULL), (8, 1, NULL, '2019-01-01', NULL, NULL), (4, 1, 1, '2018-12-31', 1, 1), (21, NULL, 1, '2019-03-30', NULL, NULL), (0, 0, 1, '2023-01-01', 1, 1), (4, 0, NULL, '2019-03-31', 1, 1), (5, 0, 0, NULL, NULL, NULL), (6, 0, NULL, '2019-03-30', NULL, 1), (2, NULL, NULL, '2019-03-31', NULL, NULL), (0, NULL, NULL, '2019-04-01', 1, 1), (9, 1, 1, NULL, 1, NULL), (2, NULL, NULL, '2023-01-02', NULL, NULL), (13, 1, NULL, '2023-01-01', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(12, 'default2')
(14, None)
(15, '2019-03-31')
(16, 'default1')
(22, 'default1')
*/

-- Prediction Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE SALE_DATE >= '2019-01-01' AND SALE_DATE <= '2019-03-31' AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
*/