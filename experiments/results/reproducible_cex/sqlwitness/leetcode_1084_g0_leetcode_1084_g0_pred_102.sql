-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'default1', NULL), (1, '2019-01-01', 2), (2, 'default1', 2), (0, '2019-03-31', NULL), (3, '2019-03-31', 2), (4, 'default1', NULL), (5, '2019-01-01', 1), (6, NULL, 2), (7, NULL, 2), (8, '2019-03-31', NULL), (9, NULL, NULL), (10, NULL, 2), (11, '2019-03-31', 2), (12, '2019-03-31', 1), (13, 'default1', NULL), (14, '2019-03-31', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 0, 2, '2018-12-31', NULL, 1), (NULL, 2, 2, NULL, 1, NULL), (11, -1, 0, NULL, NULL, 2), (14, 1, 1, NULL, 2, 2), (5, NULL, NULL, '2023-01-02', NULL, 2), (6, 2, NULL, '2019-03-31', 2, 2), (NULL, NULL, NULL, '2019-01-02', NULL, 2), (11, -1, 2, '2019-03-30', 2, 1), (5, NULL, 2, '2019-01-02', 1, 1), (4, 1, 0, '2023-01-01', 1, 1), (NULL, 1, 1, '2019-01-02', 1, 2), (2, 1, 2, '2019-03-30', 2, 2), (4, 1, -1, '2019-03-30', 1, 2), (1, NULL, -1, '2023-01-02', 1, 1), (-1, NULL, 1, '2019-01-02', 2, 1), (9, NULL, 0, '2019-01-02', 2, NULL), (2, NULL, NULL, NULL, NULL, 2), (13, -1, 1, '2023-01-02', 2, 2), (5, 0, 1, '2019-03-31', 1, 2), (1, 0, NULL, '2019-01-01', NULL, 1), (6, 0, 2, '2019-01-02', 2, 2), (7, 1, NULL, '2019-01-02', NULL, 2), (13, -1, 2, '2019-03-31', 2, 2), (10, 2, 2, '2018-12-31', 2, 2), (0, -1, -1, '2019-04-01', NULL, 2), (0, 1, 2, '2019-01-02', NULL, 2), (13, 0, 2, '2023-01-01', NULL, 1), (3, -1, NULL, '2019-01-02', NULL, 1), (NULL, 0, 2, NULL, 2, 1), (0, 2, 2, '2023-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(-1, 'default1')
(2, 'default1')
(6, None)
(7, None)
(9, None)
(11, '2019-03-31')
*/

-- Prediction Query
WITH T1 AS (SELECT P.PRODUCT_NAME, P.PRODUCT_ID, S.SALE_DATE, CASE WHEN S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN 1 ELSE 0 END AS TEMP1 FROM PRODUCT AS P INNER JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID) SELECT DISTINCT PRODUCT_ID, PRODUCT_NAME FROM T1 WHERE TEMP1 = 1 AND NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM T1 WHERE TEMP1 = 0);

/*
Prediction Result:
(6, None)
(-1, 'default1')
(9, None)
(7, None)
*/