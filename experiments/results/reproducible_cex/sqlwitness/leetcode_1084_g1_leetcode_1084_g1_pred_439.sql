-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, NULL), (0, '2019-01-01', NULL), (2, 'default2', NULL), (3, 'default2', NULL), (4, 'default1', NULL), (5, 'default1', NULL), (6, NULL, 1), (7, NULL, 1), (8, '2019-01-01', NULL), (9, '2019-03-31', 1), (10, NULL, 1), (11, '2019-01-01', 1), (12, 'default2', NULL), (13, 'default2', 1), (14, '2019-03-31', NULL), (15, 'default2', 1), (16, 'default1', 1), (17, '2019-01-01', 1), (18, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (18, 0, NULL, NULL, 1, NULL), (13, 0, 0, '2023-01-01', NULL, NULL), (15, NULL, NULL, NULL, 1, 1), (1, 1, NULL, '2019-03-31', 1, NULL), (13, 1, 1, NULL, NULL, NULL), (4, 1, 0, '2019-01-02', NULL, NULL), (3, 0, 0, '2018-12-31', 1, 1), (7, 0, NULL, '2019-03-31', NULL, NULL), (15, 1, 1, '2019-01-01', 1, NULL), (9, 1, NULL, '2019-04-01', NULL, 1), (1, NULL, NULL, '2019-03-30', NULL, 1), (1, 1, NULL, '2019-01-02', NULL, NULL), (16, NULL, 1, NULL, NULL, NULL), (3, 0, 0, '2023-01-02', 1, 1), (6, 1, NULL, '2019-01-01', NULL, NULL), (4, 0, 1, '2023-01-02', 1, 1), (6, 0, 1, NULL, 1, 1), (14, 0, 1, '2019-01-01', 1, 1), (16, NULL, 0, '2023-01-01', 1, NULL), (3, NULL, NULL, '2018-12-31', NULL, NULL), (0, 1, NULL, '2023-01-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(18, 'default2')
(15, 'default2')
(1, None)
(7, None)
(6, None)
(14, '2019-03-31')
*/

-- Prediction Query
SELECT DISTINCT (S.PRODUCT_ID), P.PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID WHERE S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT P.PRODUCT_ID IN (SELECT P.PRODUCT_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID WHERE NOT S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31');

/*
Prediction Result:
(1, None)
(7, None)
(15, 'default2')
(6, None)
(14, '2019-03-31')
*/