-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-03-31', 1), (1, 'default1', NULL), (2, NULL, NULL), (3, '2019-03-31', 1), (4, '2019-01-01', NULL), (5, NULL, NULL), (6, '2019-01-01', NULL), (7, '2019-03-31', 1), (8, '2019-03-31', NULL), (9, '2019-01-01', 1), (10, NULL, 1), (11, 'default2', 1), (12, 'default2', 1), (13, '2019-01-01', NULL), (14, 'default2', NULL), (15, '2019-01-01', NULL), (16, '2019-03-31', 1), (17, NULL, NULL), (18, 'default1', 1), (19, '2019-01-01', NULL), (20, 'default1', 1), (21, '2019-01-01', NULL), (22, '2019-01-01', 1), (23, 'default2', NULL), (24, NULL, NULL), (25, '2019-03-31', 1), (26, NULL, 1), (27, 'default1', NULL), (28, 'default1', 1), (29, '2019-03-31', 1), (30, NULL, NULL), (31, 'default1', 1), (32, 'default1', NULL), (33, 'default2', 1), (34, NULL, NULL), (35, '2019-03-31', NULL), (36, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (26, 0, 1, NULL, 1, NULL), (29, NULL, NULL, '2019-03-30', 1, NULL), (35, NULL, 0, '2019-03-30', 1, NULL), (3, NULL, 0, NULL, NULL, NULL), (18, NULL, 0, '2023-01-01', 1, NULL), (3, 1, 1, '2019-01-01', 1, NULL), (28, NULL, NULL, '2019-01-01', NULL, NULL), (0, NULL, 0, '2019-01-02', 1, NULL), (0, NULL, 0, '2018-12-31', NULL, NULL), (33, NULL, 0, '2018-12-31', 1, NULL), (30, 0, 0, '2019-01-01', NULL, 1), (19, NULL, NULL, '2018-12-31', 1, NULL), (26, 0, NULL, '2023-01-02', NULL, NULL), (32, NULL, 1, '2019-03-30', NULL, 1), (30, 0, NULL, '2018-12-31', 1, NULL), (29, 0, 1, '2019-03-30', NULL, 1), (13, 1, NULL, '2019-03-30', NULL, 1), (14, 1, NULL, '2023-01-01', NULL, NULL), (8, 0, NULL, '2019-03-30', NULL, 1), (16, 0, NULL, '2019-04-01', NULL, NULL), (1, NULL, 1, '2019-01-01', 1, NULL), (0, NULL, 1, '2019-04-01', NULL, NULL), (8, 1, 0, '2019-03-30', NULL, NULL), (21, 0, 1, NULL, 1, 1), (19, 0, 0, '2018-12-31', 1, 1), (20, NULL, NULL, '2019-01-02', NULL, NULL), (1, NULL, 1, '2019-03-31', 1, NULL), (26, 0, 0, '2019-01-02', 1, NULL), (24, NULL, NULL, '2019-01-01', 1, 1), (12, NULL, 0, NULL, NULL, 1), (16, 0, 0, '2019-01-01', 1, 1), (23, 0, NULL, '2023-01-01', 1, NULL), (30, 1, 1, '2023-01-01', 1, 1), (27, 1, 1, '2023-01-02', NULL, NULL), (20, 1, 0, '2019-01-02', NULL, NULL), (16, 1, 1, '2023-01-01', NULL, 1), (12, 0, 0, '2023-01-02', 1, 1), (34, 1, 0, '2019-03-30', 1, NULL), (0, 1, 0, '2019-01-01', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(29, '2019-03-31')
(35, '2019-03-31')
(3, '2019-03-31')
(28, 'default1')
(32, 'default1')
(13, '2019-01-01')
(8, '2019-03-31')
(1, 'default1')
(21, '2019-01-01')
(20, 'default1')
(24, None)
(34, None)
*/

-- Prediction Query
SELECT S.PRODUCT_ID, PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY S.PRODUCT_ID HAVING S.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') AND NOT S.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
(1, 'default1')
(3, '2019-03-31')
(8, '2019-03-31')
(13, '2019-01-01')
(20, 'default1')
(24, None)
(28, 'default1')
(29, '2019-03-31')
(32, 'default1')
(34, None)
(35, '2019-03-31')
*/