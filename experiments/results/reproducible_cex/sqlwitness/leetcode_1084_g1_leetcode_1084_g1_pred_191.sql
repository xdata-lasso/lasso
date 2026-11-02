-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default2', NULL), (0, 'default2', 1), (2, 'default1', NULL), (3, NULL, NULL), (4, NULL, NULL), (5, 'default1', 1), (6, 'default1', NULL), (7, 'default1', 1), (8, NULL, 1), (9, '2019-01-01', 1), (10, '2019-03-31', 1), (11, '2019-03-31', NULL), (12, '2019-01-01', NULL), (13, '2019-03-31', 1), (14, '2019-01-01', NULL), (15, '2019-01-01', NULL), (16, 'default1', NULL), (17, 'default1', NULL), (18, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 0, NULL, '2019-01-01', NULL, NULL), (16, NULL, 1, '2018-12-31', NULL, NULL), (14, 1, 0, NULL, NULL, 1), (11, NULL, NULL, '2019-03-30', 1, NULL), (3, 0, 1, '2023-01-02', NULL, 1), (13, 0, NULL, '2019-03-31', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(0, 'default2')
(14, '2019-01-01')
(11, '2019-03-31')
(13, '2019-03-31')
*/

-- Prediction Query
SELECT DISTINCT S.PRODUCT_ID, PRODUCT_NAME FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID AND SALE_DATE >= '2019-01-01' AND SALE_DATE <= '2019-03-31' AND NOT S.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
(0, 'default2')
(11, '2019-03-31')
(13, '2019-03-31')
*/