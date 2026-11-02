-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', 1), (0, NULL, 1), (2, '2019-03-31', NULL), (3, 'default2', NULL), (4, 'default1', NULL), (5, 'default1', NULL), (6, 'default1', NULL), (7, '2019-03-31', NULL), (8, '2019-03-31', 1), (9, 'default2', NULL), (10, '2019-01-01', NULL), (11, 'default2', NULL), (12, 'default1', NULL), (13, 'default1', NULL), (14, 'default2', NULL), (15, NULL, NULL), (16, 'default1', 1), (17, '2019-01-01', NULL), (18, 'default2', 1), (19, 'default1', NULL), (20, 'default2', NULL), (21, NULL, 1), (22, 'default2', NULL), (23, '2019-01-01', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (17, NULL, 0, '2019-03-31', NULL, 1), (14, NULL, 1, '2019-04-01', NULL, NULL), (20, NULL, 0, '2019-01-02', 1, NULL), (15, 1, 0, '2019-01-01', 1, 1), (8, NULL, NULL, '2019-04-01', NULL, NULL), (19, 1, 1, '2019-03-31', NULL, 1), (11, NULL, 1, '2019-01-01', NULL, NULL), (18, 1, 0, '2019-03-30', NULL, NULL), (2, NULL, 0, '2023-01-02', 1, NULL), (16, NULL, 1, '2019-03-30', NULL, NULL), (13, 0, NULL, NULL, NULL, NULL), (2, 1, NULL, '2019-01-02', 1, 1), (6, NULL, 0, '2023-01-02', NULL, 1), (4, NULL, 0, '2019-03-30', 1, 1), (7, NULL, 0, '2019-03-30', 1, 1), (NULL, NULL, 0, '2019-01-01', NULL, NULL), (5, NULL, 1, '2023-01-01', NULL, 1), (17, NULL, 1, '2019-03-31', 1, NULL), (8, NULL, 1, '2019-01-01', NULL, 1), (NULL, NULL, 1, '2019-03-31', NULL, 1), (2, 1, 0, '2019-04-01', NULL, NULL), (16, 1, 0, '2019-04-01', 1, 1), (16, NULL, 1, '2019-04-01', NULL, 1), (9, NULL, 1, '2019-01-01', NULL, 1), (7, NULL, 0, NULL, 1, NULL), (12, 1, 1, '2023-01-01', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(17, '2019-01-01')
(20, 'default2')
(15, None)
(19, 'default1')
(11, 'default2')
(18, 'default2')
(13, 'default1')
(4, 'default1')
(7, '2019-03-31')
(9, 'default2')
*/

-- Prediction Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT S.PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
(17, '2019-01-01')
(20, 'default2')
(15, None)
(19, 'default1')
(11, 'default2')
(18, 'default2')
(4, 'default1')
(7, '2019-03-31')
(9, 'default2')
*/