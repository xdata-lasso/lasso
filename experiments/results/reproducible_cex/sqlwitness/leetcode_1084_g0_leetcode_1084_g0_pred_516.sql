-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-03-31', 1), (0, 'default2', NULL), (2, 'default2', 1), (3, 'default1', NULL), (4, '2019-01-01', NULL), (5, '2019-03-31', NULL), (6, '2019-03-31', 1), (7, 'default2', 1), (8, '2019-01-01', 1), (9, 'default2', 1), (10, '2019-03-31', NULL), (11, '2019-03-31', NULL), (12, '2019-03-31', NULL), (13, '2019-03-31', 1), (14, NULL, NULL), (15, 'default2', NULL), (16, '2019-03-31', 1), (17, 'default1', NULL), (18, NULL, NULL), (19, NULL, NULL), (20, 'default1', NULL), (21, '2019-01-01', NULL), (22, NULL, 1), (23, 'default2', NULL), (24, 'default2', 1), (25, NULL, 1), (26, 'default1', NULL), (27, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 0, NULL, '2019-04-01', 1, 1), (15, NULL, 1, '2019-01-01', NULL, NULL), (NULL, NULL, NULL, '2019-04-01', 1, NULL), (6, 1, NULL, '2019-03-30', NULL, 1), (23, 0, NULL, '2019-04-01', 1, 1), (14, NULL, 0, '2018-12-31', NULL, 1), (10, 0, NULL, '2019-04-01', NULL, NULL), (3, 0, 0, '2019-01-02', NULL, 1), (24, NULL, NULL, '2019-03-30', 1, 1), (24, 1, 1, NULL, 1, NULL), (20, 0, 0, '2019-03-30', NULL, 1), (17, 0, 0, '2023-01-02', NULL, NULL), (21, NULL, 1, '2019-03-31', NULL, NULL), (3, 0, 1, '2019-03-31', 1, NULL), (1, 1, NULL, '2019-03-30', NULL, 1), (7, NULL, 1, '2019-03-30', 1, NULL), (12, 0, NULL, '2023-01-02', NULL, 1), (20, NULL, 0, NULL, NULL, 1), (6, NULL, NULL, '2018-12-31', NULL, NULL), (19, NULL, 0, '2019-04-01', 1, 1), (17, NULL, 0, NULL, 1, NULL), (7, 1, NULL, '2023-01-01', NULL, 1), (2, NULL, 0, '2023-01-02', 1, 1), (22, 0, 0, NULL, NULL, 1), (4, 0, 1, '2019-03-31', NULL, NULL), (5, 1, 0, NULL, 1, NULL), (20, 1, NULL, '2018-12-31', 1, 1), (24, 1, 0, NULL, 1, NULL), (23, 1, 1, '2019-01-01', 1, NULL), (11, 1, NULL, '2019-03-30', NULL, 1), (16, 1, 0, '2019-01-02', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(1, '2019-03-31')
(4, '2019-01-01')
(11, '2019-03-31')
(15, 'default2')
(16, '2019-03-31')
(21, '2019-01-01')
(24, 'default2')
*/

-- Prediction Query
SELECT DISTINCT PRODUCT_ID, (SELECT PRODUCT_NAME FROM PRODUCT WHERE PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID) AS PRODUCT_NAME FROM SALES WHERE SALE_DATE >= '2019-01-01' AND SALE_DATE <= '2019-03-31' AND NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
*/