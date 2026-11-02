-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, 1), (1, '2019-01-01', 1), (2, 'default2', 1), (3, 'default2', NULL), (4, 'default1', NULL), (5, 'default2', 1), (6, '2019-01-01', NULL), (7, '2019-01-01', 1), (8, '2019-01-01', 1), (9, '2019-03-31', 1), (10, 'default1', NULL), (11, '2019-03-31', NULL), (12, 'default2', 1), (13, NULL, 1), (14, '2019-03-31', NULL), (15, 'default1', NULL), (16, '2019-03-31', NULL), (17, '2019-03-31', NULL), (18, '2019-03-31', 1), (19, 'default2', NULL), (20, 'default1', 1), (21, '2019-01-01', 1), (22, 'default2', 1), (23, '2019-01-01', 1), (24, 'default1', 1), (25, NULL, NULL), (26, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (22, 1, NULL, '2019-01-01', NULL, 1), (8, 1, 1, '2019-01-02', 1, NULL), (7, 0, 1, '2018-12-31', 1, 1), (4, NULL, 1, '2019-01-01', 1, 1), (24, 1, 1, '2019-03-31', NULL, NULL), (3, NULL, 1, '2019-01-02', NULL, 1), (6, 1, 0, '2019-03-31', 1, 1), (22, NULL, NULL, '2023-01-01', NULL, 1), (24, NULL, 1, '2018-12-31', 1, 1), (4, NULL, 1, '2019-03-31', NULL, 1), (15, NULL, 1, '2019-04-01', 1, NULL), (7, NULL, 0, '2019-01-01', 1, NULL), (17, NULL, 0, '2019-03-31', 1, NULL), (5, 0, 1, '2019-01-02', NULL, NULL), (21, NULL, 1, '2018-12-31', 1, 1), (24, 0, NULL, '2019-01-02', NULL, NULL), (24, NULL, 0, NULL, 1, 1), (4, 1, 0, '2023-01-02', NULL, 1), (14, NULL, 1, '2018-12-31', 1, 1), (1, NULL, 0, '2023-01-01', NULL, NULL), (14, 1, 1, '2019-03-30', 1, NULL), (14, NULL, 1, '2023-01-01', 1, 1), (22, 1, NULL, '2019-03-30', NULL, 1), (2, 1, 1, NULL, NULL, 1), (1, 0, 0, '2019-04-01', NULL, 1), (21, 0, 0, '2018-12-31', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(8, '2019-01-01')
(3, 'default2')
(6, '2019-01-01')
(17, '2019-03-31')
(5, 'default2')
(2, 'default2')
*/

-- Prediction Query
SELECT DISTINCT PRODUCT_ID, PRODUCT_NAME FROM SALES NATURAL JOIN PRODUCT WHERE SALE_DATE >= '2019-01-01' AND SALE_DATE <= '2019-03-31' AND NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
(8, '2019-01-01')
(3, 'default2')
(6, '2019-01-01')
(17, '2019-03-31')
(5, 'default2')
*/