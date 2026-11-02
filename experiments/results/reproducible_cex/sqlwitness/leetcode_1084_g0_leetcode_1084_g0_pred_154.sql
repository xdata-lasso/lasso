-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-04-01', NULL), (1, '2019-01-01', NULL), (2, 'default2', NULL), (3, '2019-04-01', 1), (4, NULL, 1), (5, '2019-01-01', NULL), (6, '2019-01-01', NULL), (7, '2019-04-01', NULL), (8, NULL, 1), (9, '2019-04-01', NULL), (10, '2019-03-31', 1), (11, NULL, 1), (12, NULL, NULL), (13, '2019-04-01', NULL), (14, '2019-01-01', 1), (15, NULL, NULL), (16, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 1, 0, '2018-12-30', 1, NULL), (4, 0, 1, '2018-12-31', 1, 1), (0, 0, NULL, '2019-01-02', NULL, 1), (1, 1, 1, '2023-01-02', NULL, 1), (6, 0, 1, '2019-01-02', NULL, NULL), (13, 1, NULL, '2019-01-02', NULL, NULL), (16, 0, 0, '2023-01-02', 1, NULL), (15, NULL, 1, '2023-01-01', 1, NULL), (2, 1, 0, '2019-04-02', NULL, NULL), (NULL, 1, 1, '2023-01-01', 1, NULL), (15, 0, NULL, '2019-03-31', 1, 1), (15, 0, 1, '2019-01-01', NULL, 1), (NULL, 1, NULL, NULL, 1, 1), (4, NULL, 1, '2023-01-02', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(6, '2019-01-01')
(13, '2019-04-01')
*/

-- Prediction Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT P.PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE >= '2019-04-01' OR SALE_DATE <= '2018-12-31') ORDER BY P.PRODUCT_ID, P.PRODUCT_NAME NULLS LAST;

/*
Prediction Result:
*/