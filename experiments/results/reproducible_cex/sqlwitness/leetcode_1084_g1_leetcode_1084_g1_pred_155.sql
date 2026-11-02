-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-01-01', NULL), (1, '2019-03-31', NULL), (2, '2019-01-01', NULL), (3, NULL, NULL), (4, 'default1', NULL), (5, '2019-03-31', 1), (6, NULL, NULL), (7, NULL, 1), (8, NULL, 1), (9, 'default2', NULL), (10, 'default1', 1), (11, '2019-03-31', 1), (12, NULL, NULL), (13, 'default1', 1), (14, 'default2', NULL), (15, '2019-03-31', NULL), (16, '2019-01-01', 1), (17, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (14, 1, 0, NULL, NULL, 1), (4, 1, 1, '2018-12-31', NULL, 1), (14, NULL, 1, NULL, 1, NULL), (8, 1, 1, NULL, NULL, 1), (10, NULL, NULL, '2019-04-01', 1, NULL), (1, 1, NULL, '2018-12-31', 1, 1), (11, NULL, NULL, '2023-01-02', 1, 1), (17, NULL, 0, '2019-03-30', 1, 1), (8, NULL, NULL, '2019-03-31', NULL, NULL), (16, 0, 0, '2018-12-31', NULL, 1), (6, NULL, NULL, '2023-01-01', 1, NULL), (4, 0, 0, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(14, 'default2')
(8, None)
(17, 'default2')
*/

-- Prediction Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT P.PRODUCT_ID FROM PRODUCT AS P JOIN SALES AS S ON S.PRODUCT_ID = P.PRODUCT_ID WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31') ORDER BY P.PRODUCT_ID, P.PRODUCT_NAME NULLS LAST;

/*
Prediction Result:
(8, None)
(14, 'default2')
(17, 'default2')
*/