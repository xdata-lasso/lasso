-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'default1', 2), (0, 'default2', 2), (-1, 'default1', 1), (1, '2019-01-01', 2), (3, 'default1', 2), (4, 'default2', 1), (5, '2019-01-01', 1), (6, '2019-01-01', 2), (7, '2019-01-01', 2), (8, 'default1', 1), (9, 'default1', 1), (10, '2019-03-31', NULL), (11, '2019-03-31', 2), (12, 'default2', NULL), (13, '2019-01-01', 1), (14, NULL, 1), (15, NULL, 1), (16, '2019-03-31', NULL), (17, NULL, NULL), (18, 'default2', NULL), (19, 'default2', NULL), (20, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (7, -1, NULL, '2018-12-31', 2, NULL), (NULL, NULL, -1, '2023-01-02', 1, 2), (2, 1, 2, '2019-04-01', 2, 2), (12, 0, NULL, '2023-01-01', 2, 1), (9, -1, 0, '2019-01-01', 1, 2), (13, 0, 2, '2018-12-31', 1, 2), (5, 1, -1, '2019-03-30', 1, 1), (0, 2, 0, '2019-01-01', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
SELECT S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY S.PRODUCT_ID, P.PRODUCT_NAME HAVING MAX(IIF(NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31', 1, 0)) = 0;

/*
Prediction Result:
(0, 'default2')
(5, '2019-01-01')
(9, 'default1')
*/