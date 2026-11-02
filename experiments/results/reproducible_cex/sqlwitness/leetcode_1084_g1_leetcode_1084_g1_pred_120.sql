-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-01-01', NULL), (1, NULL, 1), (2, 'default1', NULL), (3, NULL, NULL), (4, 'default2', 1), (5, '2019-03-31', 1), (6, 'default1', 1), (7, '2019-01-01', NULL), (8, 'default2', NULL), (9, '2019-03-31', 1), (10, '2019-03-31', NULL), (11, '2019-01-01', 1), (12, 'default2', 1), (13, 'default1', NULL), (14, NULL, NULL), (15, 'default2', 1), (16, '2019-03-31', NULL), (17, 'default2', NULL), (18, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (8, 1, NULL, '2019-01-01', NULL, 1), (14, 1, 0, '2019-01-01', 1, 1), (0, 1, 1, '2019-03-30', NULL, NULL), (15, 1, 1, NULL, 1, 1), (11, 1, 1, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(8, 'default2')
(14, None)
(0, '2019-01-01')
(15, 'default2')
(11, '2019-01-01')
*/

-- Prediction Query
SELECT DISTINCT S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT S.PRODUCT_ID IN (SELECT S.PRODUCT_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
(8, 'default2')
(14, None)
(0, '2019-01-01')
*/