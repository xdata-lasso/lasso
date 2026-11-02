-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, '2019-01-01', NULL), (1, NULL, NULL), (0, '2019-01-01', NULL), (2, 'default2', 1), (3, 'default1', NULL), (4, 'default2', 1), (5, 'default2', 1), (6, '2019-01-01', 1), (7, '2019-03-31', 1), (8, 'default1', NULL), (9, NULL, NULL), (10, '2019-03-31', 1), (11, 'default2', NULL), (12, NULL, 1), (13, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (13, -1, 0, '2023-01-02', 1, NULL), (7, 1, 0, '2019-03-31', NULL, 1), (3, NULL, 1, '2018-12-31', 1, 1), (11, -1, -1, '2019-03-30', NULL, NULL), (7, NULL, 0, '2023-01-02', NULL, NULL), (10, 1, 0, '2023-01-01', NULL, NULL), (1, 0, 0, '2019-03-30', NULL, NULL), (NULL, 1, 0, '2018-12-31', NULL, 1), (0, NULL, NULL, '2019-03-30', 1, 1), (3, 1, 0, '2018-12-31', NULL, NULL), (13, NULL, 1, '2019-04-01', NULL, NULL), (NULL, NULL, NULL, '2019-03-30', NULL, NULL), (-1, -1, 0, '2019-03-31', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(-1, '2019-01-01')
(0, '2019-01-01')
(1, None)
(11, 'default2')
*/

-- Prediction Query
WITH TMP AS (SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') SELECT PRODUCT_ID, PRODUCT_NAME FROM TMP WHERE NOT PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID AS PRODUCT_ID FROM SALES WHERE CAST((JULIANDAY(SALE_DATE) - JULIANDAY('2019-01-01')) AS INTEGER) < 0 OR CAST((JULIANDAY(SALE_DATE) - JULIANDAY('2019-03-31')) AS INTEGER) > 0);

/*
Prediction Result:
*/