-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-01-01', 1), (1, 'default2', 1), (2, 'default1', 1), (3, 'default1', 1), (4, 'default1', NULL), (5, NULL, 1), (6, '2019-03-31', NULL), (7, 'default2', NULL), (8, NULL, NULL), (9, 'default1', 1), (10, '2019-01-01', NULL), (11, 'default1', NULL), (12, NULL, NULL), (13, '2019-01-01', 1), (14, 'default2', NULL), (15, 'default2', 1), (16, '2019-01-01', NULL), (17, NULL, NULL), (18, '2019-03-31', NULL), (19, '2019-03-31', NULL), (20, '2019-03-31', NULL), (21, NULL, NULL), (22, '2019-01-01', NULL), (23, '2019-01-01', 1), (24, '2019-03-31', NULL), (25, 'default2', 1), (26, 'default2', 1), (27, '2019-01-01', NULL), (28, NULL, NULL), (29, '2019-03-31', 1), (30, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 1, NULL, '2019-01-01', 1, 1), (20, 1, NULL, NULL, NULL, NULL), (8, NULL, 1, '2023-01-01', 1, 1), (18, 1, 1, '2019-01-01', 1, 1), (12, NULL, 1, '2018-12-31', 1, NULL), (13, 1, 1, '2019-04-01', NULL, 1), (7, 1, NULL, '2019-03-30', 1, 1), (18, NULL, NULL, '2019-03-31', 1, NULL), (25, NULL, 0, '2023-01-02', 1, NULL), (15, NULL, 0, '2019-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(6, '2019-03-31')
(7, 'default2')
(15, 'default2')
(18, '2019-03-31')
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P CROSS JOIN SALES AS S WHERE P.PRODUCT_ID = S.PRODUCT_ID AND NOT (P.PRODUCT_ID, P.PRODUCT_NAME) IN (SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE NOT S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') GROUP BY P.PRODUCT_ID ORDER BY P.PRODUCT_ID, P.PRODUCT_NAME NULLS LAST;

/*
Prediction Result:
(6, '2019-03-31')
(7, 'default2')
(15, 'default2')
(18, '2019-03-31')
(20, '2019-03-31')
*/