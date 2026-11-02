-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-03-31', 1), (-1, 'default1', 1), (0, 'default1', 1), (2, 'default2', NULL), (3, '2019-01-01', 2), (4, '2019-03-31', NULL), (5, '2019-01-01', NULL), (6, '2019-01-01', NULL), (7, '2019-01-01', 1), (8, '2019-01-01', 1), (9, 'default1', NULL), (10, 'default2', 2), (11, 'default1', NULL), (12, '2019-03-31', 2), (13, '2019-01-01', 2), (14, 'default1', 2), (15, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 0, 1, '2019-03-31', 1, 2), (4, -1, -1, '2019-01-01', NULL, 1), (2, 1, NULL, '2019-04-01', 1, 1), (3, NULL, 0, '2019-03-30', 2, NULL), (12, NULL, 0, '2019-03-31', 2, 2), (7, 0, 1, '2019-03-30', NULL, 1), (14, 2, 1, '2019-01-01', NULL, NULL), (1, 0, 0, '2023-01-01', NULL, 1), (10, NULL, NULL, '2023-01-02', NULL, 1), (6, 2, 1, '2019-01-01', 1, NULL), (5, NULL, 2, '2018-12-31', 2, 2), (11, -1, 2, '2023-01-02', NULL, NULL), (1, 0, 1, '2019-01-02', 1, 1), (NULL, NULL, 2, NULL, 2, 2), (NULL, 0, 2, '2019-03-30', 2, 1), (3, 2, 2, '2018-12-31', 1, NULL), (5, NULL, 2, NULL, 2, NULL), (15, 0, NULL, NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(0, 'default1')
(4, '2019-03-31')
(6, '2019-01-01')
(7, '2019-01-01')
(12, '2019-03-31')
(14, 'default1')
*/

-- Prediction Query
WITH SALESINFO AS (SELECT PRODUCT_ID, SUM(CASE WHEN SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31' THEN 1 ELSE 0 END) AS FLAG FROM SALES GROUP BY PRODUCT_ID) SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALESINFO WHERE FLAG = 0);

/*
Prediction Result:
(0, 'default1')
(4, '2019-03-31')
(6, '2019-01-01')
(7, '2019-01-01')
(12, '2019-03-31')
(14, 'default1')
(15, None)
*/