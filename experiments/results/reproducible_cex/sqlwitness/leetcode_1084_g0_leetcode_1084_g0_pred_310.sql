-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', NULL), (1, 'default1', 1), (2, NULL, NULL), (3, 'default1', 1), (4, 'default1', 1), (5, NULL, 1), (6, '2019-03-31', NULL), (7, 'default1', 1), (8, 'default1', 1), (9, 'default1', NULL), (10, 'default1', 1), (11, NULL, NULL), (12, 'default2', NULL), (13, '2019-01-01', 1), (14, '2019-01-01', NULL), (15, '2019-01-01', 1), (16, '2019-01-01', 1), (17, 'default1', 1), (18, '2019-03-31', NULL), (19, '2019-01-01', NULL), (20, '2019-01-01', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (11, 1, 0, '2019-01-01', NULL, NULL), (1, 1, 1, '2019-01-01', 1, NULL), (8, 0, 1, '2023-01-01', NULL, NULL), (0, 0, NULL, '2019-03-31', NULL, 1), (12, 0, 1, '2019-03-30', NULL, 1), (10, 0, 0, '2018-12-31', NULL, NULL), (18, 0, NULL, '2023-01-02', 1, 1), (7, 1, NULL, '2019-04-01', 1, NULL), (12, 1, NULL, '2023-01-01', 1, 1), (12, 0, 1, NULL, NULL, 1), (13, 1, NULL, '2023-01-02', NULL, NULL), (19, 0, NULL, '2019-01-02', 1, NULL), (17, NULL, 1, '2019-01-01', NULL, NULL), (9, 0, 0, '2019-01-02', 1, NULL), (9, 0, 1, '2019-01-01', NULL, NULL), (15, NULL, 0, NULL, 1, 1), (0, 1, 0, '2019-03-31', 1, 1), (13, NULL, NULL, '2018-12-31', NULL, NULL), (13, NULL, 1, '2023-01-01', NULL, 1), (5, 0, 0, '2019-03-30', NULL, 1), (13, 0, NULL, '2019-03-31', 1, 1), (14, 1, 1, '2019-03-31', NULL, NULL), (NULL, 1, 1, '2019-03-31', NULL, NULL), (18, 1, 1, '2018-12-31', NULL, 1), (10, NULL, NULL, '2019-04-01', 1, 1), (NULL, 1, 0, '2019-04-01', NULL, 1), (19, 0, 1, '2019-01-02', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(0, 'default1')
(1, 'default1')
(5, None)
(9, 'default1')
(11, None)
(14, '2019-01-01')
(17, 'default1')
(19, '2019-01-01')
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31'), CTE1 AS (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31') SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT WHERE PRODUCT_ID IN (SELECT * FROM CTE) AND NOT PRODUCT_ID IN (SELECT * FROM CTE1);

/*
Prediction Result:
*/