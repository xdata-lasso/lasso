-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-03-31', NULL), (0, NULL, 1), (2, 'default2', NULL), (3, 'default1', 1), (4, 'default2', NULL), (5, 'default2', NULL), (6, 'default2', NULL), (7, 'default1', 1), (8, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 0, 1, '2019-03-31', 1, 1), (NULL, NULL, NULL, '2019-03-30', NULL, 1), (6, 0, 0, '2018-12-31', 1, NULL), (5, 0, 1, '2019-03-30', NULL, 1), (7, 0, 1, '2018-12-31', 1, 1), (2, 1, 1, '2019-01-01', 1, NULL), (0, 1, NULL, '2019-04-01', NULL, NULL), (7, 0, NULL, '2019-01-02', NULL, 1), (3, 1, NULL, '2023-01-02', NULL, NULL), (0, 0, 0, '2018-12-31', NULL, 1), (1, 0, 0, '2019-01-01', 1, NULL), (8, 1, 1, '2019-01-01', NULL, 1), (1, NULL, 1, '2019-01-01', 1, 1), (5, 0, 0, NULL, NULL, 1), (8, NULL, NULL, '2019-03-31', 1, 1), (4, 1, 1, NULL, 1, 1), (6, 0, 1, NULL, 1, 1), (NULL, 1, 1, '2019-03-30', 1, 1), (3, 1, 1, '2018-12-31', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(5, 'default2')
(2, 'default2')
(1, '2019-03-31')
(8, 'default1')
(4, 'default2')
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE >= '2019-01-01' AND SALE_DATE <= '2019-03-31') SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT WHERE PRODUCT_ID IN (SELECT * FROM CTE) AND NOT PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
(1, '2019-03-31')
(2, 'default2')
(5, 'default2')
(8, 'default1')
*/