-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, NULL), (0, '2019-03-31', 1), (2, '2019-01-01', NULL), (3, 'default1', NULL), (4, '2019-01-01', NULL), (5, '2019-01-01', NULL), (6, 'default2', NULL), (7, 'default2', 1), (8, '2019-01-01', NULL), (9, NULL, 1), (10, '2019-03-31', NULL), (11, NULL, NULL), (12, NULL, NULL), (13, 'default1', 1), (14, 'default1', 1), (15, 'default1', 1), (16, 'default1', 1), (17, NULL, 1), (18, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (7, 1, 0, '2023-01-01', NULL, NULL), (18, NULL, 0, '2023-01-01', 1, NULL), (1, 0, 0, '2019-03-30', 1, 1), (16, NULL, NULL, NULL, NULL, 1), (7, NULL, 0, '2019-01-01', 1, NULL), (6, 0, 0, '2019-03-30', NULL, NULL), (14, NULL, 0, NULL, NULL, 1), (10, 0, NULL, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(1, None)
(16, 'default1')
(6, 'default2')
(14, 'default1')
(10, '2019-03-31')
*/

-- Prediction Query
WITH CTE AS (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31')) SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM CTE);

/*
Prediction Result:
(1, None)
(6, 'default2')
*/