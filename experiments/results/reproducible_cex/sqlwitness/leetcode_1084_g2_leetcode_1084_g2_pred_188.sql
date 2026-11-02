-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, '2019-03-31', 1), (0, 'default2', 1), (1, 'default1', 1), (2, 'default2', 1), (3, 'default1', NULL), (4, '2019-03-31', NULL), (5, '2019-01-01', 1), (6, '2019-01-01', NULL), (7, 'default1', NULL), (8, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 0, -1, '2018-12-31', NULL, 1), (7, -1, -1, '2023-01-02', NULL, 1), (5, 0, -1, '2023-01-01', 1, NULL), (1, NULL, NULL, NULL, NULL, NULL), (2, -1, 1, '2018-12-31', NULL, 1), (-1, 0, -1, '2023-01-02', NULL, NULL), (6, 0, NULL, '2019-03-31', 1, NULL), (7, NULL, -1, '2023-01-01', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(6, '2019-01-01')
*/

-- Prediction Query
SELECT DISTINCT S.PRODUCT_ID, PRODUCT_NAME FROM SALES AS S LEFT JOIN (SELECT PRODUCT_ID, BUYER_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') AS S1 USING (PRODUCT_ID) INNER JOIN PRODUCT USING (PRODUCT_ID) WHERE S1.PRODUCT_ID IS NULL;

/*
Prediction Result:
(1, 'default1')
(6, '2019-01-01')
*/