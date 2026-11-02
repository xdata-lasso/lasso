-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', 1), (1, 'default1', 1), (2, 'default1', 1), (3, 'default2', 1), (4, NULL, NULL), (5, '2019-03-31', 1), (6, '2019-03-31', NULL), (7, '2019-01-01', NULL), (8, '2019-03-31', 1), (9, 'default2', NULL), (10, '2019-03-31', 1), (11, '2019-01-01', 1), (12, NULL, 1), (13, NULL, NULL), (14, NULL, 1), (15, 'default2', NULL), (16, 'default1', 1), (17, 'default2', NULL), (18, 'default2', 1), (19, 'default1', NULL), (20, '2019-03-31', 1), (21, '2019-01-01', NULL), (22, '2019-03-31', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (8, NULL, 1, '2019-03-31', 1, 1), (6, 0, 0, '2019-03-31', 1, 1), (6, 0, 0, '2018-12-31', NULL, 1), (13, NULL, NULL, NULL, NULL, 1), (0, NULL, NULL, '2019-01-01', NULL, NULL), (20, NULL, 0, NULL, NULL, NULL), (7, NULL, 0, '2019-01-02', 1, NULL), (16, NULL, 1, '2023-01-01', 1, 1), (2, 1, 0, '2023-01-01', 1, NULL), (11, 0, 1, '2023-01-02', NULL, NULL), (19, 1, NULL, '2023-01-02', NULL, 1), (17, 1, 1, '2019-04-01', 1, 1), (18, NULL, 1, NULL, 1, 1), (14, 0, NULL, '2018-12-31', 1, 1), (9, NULL, NULL, NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(8, '2019-03-31')
(13, None)
(0, 'default2')
(20, '2019-03-31')
(7, '2019-01-01')
(18, 'default2')
(9, 'default2')
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCT JOIN SALES USING (PRODUCT_ID) WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31'));

/*
Prediction Result:
(0, 'default2')
(7, '2019-01-01')
(8, '2019-03-31')
*/