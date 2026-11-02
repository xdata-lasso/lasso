-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', 1), (1, '2019-03-31', NULL), (-1, NULL, 1), (2, 'default1', NULL), (3, NULL, NULL), (4, 'default2', 1), (5, 'default1', 1), (6, '2019-01-01', 1), (7, NULL, NULL), (8, '2019-01-01', NULL), (9, NULL, NULL), (10, '2019-03-31', 1), (11, NULL, 1), (12, NULL, 1), (13, 'default1', NULL), (14, NULL, NULL), (15, '2019-01-01', NULL), (16, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 0, 1, '2019-04-01', NULL, NULL), (1, -1, -1, '2018-12-31', 1, NULL), (11, NULL, 1, '2023-01-02', NULL, 1), (8, 0, -1, '2019-04-01', NULL, NULL), (15, 0, NULL, '2018-12-31', NULL, 1), (11, NULL, 0, '2019-03-30', NULL, NULL), (9, NULL, NULL, '2023-01-01', 1, NULL), (5, 1, 0, '2018-12-31', 1, NULL), (8, -1, NULL, '2019-01-02', NULL, 1), (6, NULL, -1, '2023-01-02', 1, NULL), (10, NULL, 0, '2019-04-01', 1, 1), (15, 0, 0, NULL, 1, NULL), (9, -1, -1, NULL, 1, NULL), (10, -1, -1, '2018-12-31', NULL, NULL), (7, 1, 0, '2019-03-30', 1, NULL), (1, -1, NULL, '2019-01-02', NULL, 1), (6, -1, NULL, '2019-04-01', NULL, NULL), (-1, -1, NULL, '2019-03-31', 1, NULL), (11, -1, 0, '2019-01-01', 1, 1), (7, -1, -1, '2018-12-31', 1, NULL), (7, 0, NULL, '2019-04-01', 1, 1), (2, 1, 0, '2023-01-02', 1, 1), (15, -1, 0, NULL, 1, 1), (6, NULL, NULL, NULL, 1, NULL), (-1, 1, 1, NULL, 1, NULL), (10, 1, NULL, '2023-01-01', NULL, NULL), (16, 1, 1, NULL, NULL, 1), (2, NULL, NULL, '2019-01-01', 1, NULL), (16, -1, -1, '2019-01-02', NULL, 1), (13, -1, 0, '2019-01-02', 1, 1), (-1, 0, 1, '2019-01-01', 1, 1), (NULL, 1, 0, '2019-03-31', 1, 1), (6, 1, -1, '2023-01-02', 1, NULL), (9, NULL, 0, '2019-03-31', 1, 1), (13, 1, NULL, '2019-03-30', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(-1, None)
(13, 'default1')
(16, 'default1')
*/

-- Prediction Query
SELECT DISTINCT S.PRODUCT_ID, PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE NOT S.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') AND S.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31');

/*
Prediction Result:
*/