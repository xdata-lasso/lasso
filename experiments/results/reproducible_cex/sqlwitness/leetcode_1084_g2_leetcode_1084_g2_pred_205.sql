-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-1-1', 1), (-1, '2019-3-31', 1), (0, 'default1', 1), (2, '2019-1-1', 1), (3, '2019-01-01', NULL), (4, NULL, NULL), (5, 'default2', 1), (6, '2019-01-01', 1), (7, '2019-03-31', 1), (8, '2019-3-31', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 1, 0, '2023-01-01', NULL, NULL), (5, NULL, 0, '2019-01-02', 1, NULL), (5, 1, NULL, '2019-01-01', NULL, 1), (3, NULL, 0, '2019-03-31', NULL, NULL), (8, NULL, 1, '2019-01-02', 1, 1), (7, 1, -1, '2019-03-31', 1, NULL), (8, 1, 1, '2023-01-02', 1, 1), (6, NULL, 1, '2019-03-31', NULL, 1), (-1, NULL, -1, '2018-12-31', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(3, '2019-01-01')
(5, 'default2')
(6, '2019-01-01')
(7, '2019-03-31')
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P CROSS JOIN SALES AS S WHERE P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID, P.PRODUCT_NAME HAVING MIN(S.SALE_DATE) >= '2019-1-1' AND MAX(S.SALE_DATE) <= '2019-3-31';

/*
Prediction Result:
*/