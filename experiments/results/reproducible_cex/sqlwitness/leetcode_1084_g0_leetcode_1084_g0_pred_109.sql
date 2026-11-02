-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-03-31', NULL), (0, NULL, NULL), (2, '2019-03-31', 1), (3, '2019-01-01', NULL), (4, '2019-03-31', 1), (5, '2019-04-01', 1), (6, '2019-01-01', 1), (7, '2019-01-01', NULL), (8, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, NULL, 1, '2018-12-31', NULL, 1), (1, 1, 0, '2019-01-02', 1, NULL), (4, NULL, 1, '2019-03-31', 1, 1), (7, 1, NULL, '2023-01-01', NULL, NULL), (1, 1, NULL, '2023-01-02', 1, NULL), (8, 0, 1, '2019-01-02', NULL, 1), (5, 1, 1, '2019-01-01', NULL, NULL), (2, 0, 1, '2019-03-31', 1, NULL), (5, 1, 0, '2019-01-01', NULL, 1), (7, 0, 1, '2019-03-31', 1, NULL), (NULL, NULL, NULL, '2019-04-02', 1, NULL), (6, 0, 0, '2018-12-31', NULL, 1), (6, 1, 0, '2018-12-31', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(2, '2019-03-31')
(4, '2019-03-31')
(5, '2019-04-01')
(8, 'default1')
*/

-- Prediction Query
WITH OTHER_THAN_2019_SPRING AS (SELECT DISTINCT (PRODUCT_ID) FROM SALES AS S WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31') SELECT DISTINCT (S.PRODUCT_ID), P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE SALE_DATE >= '2019-01-01' AND SALE_DATE < '2019-04-01' AND NOT S.PRODUCT_ID IN (SELECT * FROM OTHER_THAN_2019_SPRING);

/*
Prediction Result:
*/