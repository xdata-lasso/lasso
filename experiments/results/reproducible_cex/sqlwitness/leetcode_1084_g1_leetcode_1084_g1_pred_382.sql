-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', NULL), (1, 'default2', 1), (2, NULL, 1), (3, '2019-01-01', 1), (4, NULL, 1), (5, 'default2', 1), (6, 'default1', NULL), (7, 'default2', 1), (8, '2019-01-01', 1), (9, '2019-01-01', NULL), (10, '2019-01-01', NULL), (11, 'default1', 1), (12, NULL, NULL), (13, NULL, 1), (14, 'default1', NULL), (15, '2019-01-01', NULL), (16, 'default2', 1), (17, '2019-03-31', 1), (18, 'default1', 1), (19, 'default2', NULL), (20, NULL, NULL), (21, 'default2', NULL), (22, NULL, NULL), (23, NULL, 1), (24, '2019-01-01', NULL), (25, '2019-01-01', NULL), (26, 'default2', NULL), (27, NULL, NULL), (28, NULL, NULL), (29, 'default1', NULL), (30, '2019-03-31', NULL), (31, '2019-03-31', 1), (32, NULL, 1), (33, '2019-01-01', 1), (34, '2019-03-31', NULL), (35, '2019-03-31', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, NULL, 1, '2023-01-01', 1, NULL), (11, 0, 1, '2023-01-02', NULL, 1), (11, 0, 1, '2019-03-31', 1, NULL), (13, 1, NULL, '2023-01-01', 1, NULL), (22, NULL, 1, '2019-01-01', NULL, NULL), (6, NULL, NULL, '2019-03-30', 1, 1), (15, 0, NULL, '2023-01-01', NULL, NULL), (23, 1, 0, '2019-01-02', 1, NULL), (31, NULL, 0, '2019-03-31', NULL, 1), (2, NULL, 0, '2019-03-31', 1, NULL), (34, 1, NULL, '2018-12-31', NULL, NULL), (6, NULL, NULL, '2019-04-01', NULL, 1), (25, 1, 1, '2023-01-01', NULL, 1), (25, 0, 0, '2019-03-30', 1, NULL), (2, 1, NULL, '2019-01-02', 1, NULL), (17, 1, NULL, '2019-03-30', NULL, NULL), (27, 1, NULL, '2019-01-02', NULL, 1), (11, NULL, NULL, '2019-04-01', NULL, 1), (13, 0, 1, '2019-01-02', NULL, 1), (6, NULL, 0, '2019-01-02', NULL, 1), (18, NULL, 0, '2023-01-01', NULL, 1), (10, NULL, 1, NULL, NULL, 1), (20, 0, 1, '2019-03-30', 1, NULL), (1, 0, NULL, '2019-03-30', 1, 1), (18, 1, 0, '2019-01-02', NULL, NULL), (6, 1, 0, '2019-04-01', 1, NULL), (7, NULL, NULL, NULL, NULL, NULL), (18, 1, NULL, '2019-03-30', 1, 1), (19, 0, 1, '2019-03-30', NULL, 1), (3, NULL, NULL, '2023-01-02', NULL, NULL), (15, NULL, 0, '2019-01-01', 1, NULL), (16, NULL, 1, '2023-01-02', 1, NULL), (17, 1, 1, '2019-01-01', 1, NULL), (9, 1, 0, '2023-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(22, None)
(23, None)
(31, '2019-03-31')
(17, '2019-03-31')
(27, None)
(10, '2019-01-01')
(20, None)
(1, 'default2')
(7, 'default2')
(19, 'default2')
*/

-- Prediction Query
WITH Q1_SOLD AS (SELECT DISTINCT (PRODUCT_ID) FROM SALES WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31'), NON_Q1_SOLD AS (SELECT DISTINCT (PRODUCT_ID) FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') SELECT A.PRODUCT_ID, B.PRODUCT_NAME FROM Q1_SOLD AS A JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE NOT A.PRODUCT_ID IN (SELECT PRODUCT_ID FROM NON_Q1_SOLD);

/*
Prediction Result:
(22, None)
(23, None)
(31, '2019-03-31')
(17, '2019-03-31')
(27, None)
(20, None)
(1, 'default2')
(19, 'default2')
*/