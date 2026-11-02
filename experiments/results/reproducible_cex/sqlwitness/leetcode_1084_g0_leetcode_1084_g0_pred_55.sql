-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-01-01', NULL), (2, 'default1', NULL), (-1, 'default2', NULL), (1, 'default2', 2), (3, 'default1', NULL), (4, 'default2', 2), (5, 'default2', NULL), (6, 'default2', 1), (7, 'default1', 2), (8, '2019-03-31', 2), (9, 'default1', 1), (10, 'default1', 1), (11, 'default2', NULL), (12, '2019-01-01', 1), (13, NULL, 1), (14, 'default1', NULL), (15, NULL, 1), (16, '2019-03-31', NULL), (17, '2019-03-31', 1), (18, '2019-03-31', 2), (19, 'default1', 1), (20, '2019-03-31', 2), (21, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, NULL, NULL, '2019-01-02', 2, 2), (14, -1, -1, '2018-12-31', 2, 2), (3, -1, 1, '2019-01-01', 1, NULL), (4, 2, -1, '2019-03-31', NULL, NULL), (NULL, 0, 1, '2019-03-31', NULL, 2), (6, -1, -1, NULL, 2, 1), (2, -1, 2, '2023-01-01', NULL, NULL), (15, -1, 0, '2019-03-30', 2, 1), (13, NULL, -1, '2019-01-02', NULL, 1), (NULL, -1, 1, '2019-03-31', 2, 1), (NULL, 2, 0, '2019-03-30', 2, NULL), (16, NULL, 0, '2019-03-30', 1, NULL), (7, -1, NULL, '2019-03-30', NULL, NULL), (18, 2, -1, '2019-04-01', 2, 1), (4, 1, 1, '2023-01-01', 2, 2), (13, 1, 0, '2019-03-30', 1, 2), (-1, 1, 1, '2019-03-31', 2, NULL), (3, NULL, 0, '2019-03-30', 2, NULL), (9, 2, 0, '2019-04-01', NULL, 1), (7, -1, 0, '2018-12-31', NULL, 1), (1, 2, 1, NULL, NULL, NULL), (17, 1, 2, '2023-01-01', 1, 2), (6, 2, -1, '2019-01-01', 1, 2), (1, 2, 1, NULL, NULL, NULL), (15, 0, 0, '2019-01-01', 1, 1), (8, 2, 0, '2019-01-02', 1, NULL), (21, NULL, -1, '2019-03-30', 1, NULL), (10, 1, 0, '2019-04-01', 2, 2), (NULL, -1, 2, '2019-03-30', NULL, 2), (1, 0, 1, NULL, 2, 2), (2, -1, 1, '2019-01-01', NULL, NULL), (15, 2, NULL, '2019-03-30', NULL, 1), (NULL, 1, NULL, '2023-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(-1, 'default2')
(3, 'default1')
(6, 'default2')
(8, '2019-03-31')
(13, None)
(15, None)
(16, '2019-03-31')
(21, None)
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING SUM(IIF(SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31', 0, 1)) = 0;

/*
Prediction Result:
(-1, 'default2')
(3, 'default1')
(8, '2019-03-31')
(13, None)
(15, None)
(16, '2019-03-31')
(21, None)
*/