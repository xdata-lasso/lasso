-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', 1), (2, '2019-01-01', NULL), (1, 'default2', 2), (-1, '2019-01-01', 1), (3, '2019-03-31', 2), (4, NULL, 1), (5, NULL, NULL), (6, '2019-01-01', 2), (7, '2019-01-01', 2), (8, '2019-03-31', NULL), (9, '2019-03-31', NULL), (10, 'default2', NULL), (11, '2019-03-31', NULL), (12, NULL, NULL), (13, '2019-03-31', 1), (14, 'default2', 1), (15, '2019-03-31', 2), (16, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (9, 0, 1, '2019-01-01', NULL, NULL), (8, -1, 0, '2019-04-01', NULL, NULL), (7, NULL, 2, '2023-01-02', NULL, NULL), (11, 2, -1, NULL, NULL, 1), (-1, NULL, -1, '2019-03-31', 2, 1), (NULL, NULL, 0, '2023-01-01', NULL, 2), (3, NULL, 0, '2023-01-01', 1, 2), (NULL, 0, -1, NULL, 2, 1), (16, 1, -1, '2023-01-01', NULL, 1), (-1, 1, -1, '2019-03-30', NULL, 1), (13, 1, 0, '2019-01-01', 2, 1), (1, 1, -1, '2019-01-02', 1, 2), (-1, NULL, 0, '2019-03-30', NULL, 1), (0, NULL, 1, '2019-03-30', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(-1, '2019-01-01')
(0, 'default2')
(1, 'default2')
(9, '2019-03-31')
(13, '2019-03-31')
*/

-- Prediction Query
SELECT S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY S.PRODUCT_ID, P.PRODUCT_NAME HAVING MAX(IIF(NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31', 1, 0)) = 0;

/*
Prediction Result:
(-1, '2019-01-01')
(0, 'default2')
(1, 'default2')
(9, '2019-03-31')
(11, '2019-03-31')
(13, '2019-03-31')
*/