-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', NULL), (1, '2019-01-01', 1), (2, '2019-01-01', 1), (3, 'default1', 1), (4, '2019-03-31', NULL), (5, 'default1', 1), (6, '2019-03-31', NULL), (7, NULL, 1), (8, NULL, NULL), (9, 'default1', 1), (10, 'default2', NULL), (11, '2019-03-31', 1), (12, NULL, NULL), (13, 'default2', 1), (14, '2019-03-31', 1), (15, NULL, 1), (16, '2019-01-01', NULL), (17, NULL, 1), (18, 'default2', NULL), (19, 'default2', NULL), (20, '2019-01-01', 1), (21, 'default2', 1), (22, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, NULL, 0, '2019-03-30', NULL, 1), (16, 0, 0, '2019-04-01', NULL, 1), (10, 1, 1, '2018-12-31', 1, 1), (5, NULL, NULL, '2023-01-01', 1, 1), (15, NULL, 0, NULL, 1, NULL), (1, NULL, 1, NULL, NULL, NULL), (6, 1, NULL, '2018-12-31', 1, NULL), (17, NULL, NULL, '2019-01-01', 1, 1), (15, 0, NULL, NULL, 1, 1), (13, 1, NULL, '2019-04-01', 1, NULL), (10, 0, NULL, '2019-01-02', 1, 1), (21, NULL, 1, '2019-01-02', 1, 1), (22, NULL, 0, '2018-12-31', NULL, NULL), (18, 1, NULL, '2019-03-30', 1, NULL), (15, 0, 0, NULL, NULL, NULL), (14, 1, NULL, '2019-04-01', NULL, 1), (11, 1, NULL, NULL, NULL, NULL), (1, 0, 1, '2019-03-30', 1, 1), (18, NULL, 1, NULL, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(15, None)
(1, '2019-01-01')
(17, None)
(21, 'default2')
(18, 'default2')
(11, '2019-03-31')
*/

-- Prediction Query
SELECT DISTINCT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT JOIN SALES USING (PRODUCT_ID) WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
(17, None)
(21, 'default2')
(18, 'default2')
(1, '2019-01-01')
*/