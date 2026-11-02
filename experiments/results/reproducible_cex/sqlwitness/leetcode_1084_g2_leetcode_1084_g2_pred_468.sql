-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'default2', 1), (0, 'default2', 1), (1, '2019-03-31', 1), (2, '2019-01-01', 1), (3, 'default2', 1), (4, NULL, NULL), (5, 'default1', 2), (6, '2019-01-01', NULL), (7, '2019-01-01', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, NULL, NULL, '2019-01-02', NULL, 1), (-1, -1, -1, '2019-01-02', NULL, 2), (1, 1, 1, '2018-12-31', NULL, NULL), (5, 2, -1, '2023-01-02', 1, NULL), (6, NULL, -1, '2019-04-01', 2, NULL), (3, 1, 0, '2019-01-02', 2, NULL), (2, 0, 2, NULL, 2, NULL), (3, 0, NULL, '2019-01-02', 1, NULL), (0, 2, NULL, '2019-03-30', 2, 1), (3, NULL, 2, '2019-01-01', 1, NULL), (0, 1, 1, '2023-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(-1, 'default2')
(3, 'default2')
*/

-- Prediction Query
SELECT P.PRODUCT_ID, PRODUCT_NAME FROM PRODUCT AS P JOIN (SELECT PRODUCT_ID, SUM(FLAG) FROM (SELECT PRODUCT_ID, SALE_DATE, CASE WHEN SALE_DATE < '2019-01-01' THEN 1 WHEN SALE_DATE > '2019-03-31' THEN 1 ELSE 0 END AS FLAG FROM SALES) AS X GROUP BY PRODUCT_ID HAVING SUM(FLAG) = 0) AS Y ON P.PRODUCT_ID = Y.PRODUCT_ID;

/*
Prediction Result:
(-1, 'default2')
(2, '2019-01-01')
(3, 'default2')
*/