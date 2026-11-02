-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-03-31', NULL), (0, NULL, NULL), (-1, NULL, NULL), (2, ' 2019-01-01', 1), (3, 'default1', NULL), (4, ' 2019-01-01', 1), (5, '2019-03-31', 1), (6, 'default1', 1), (7, '2019-01-01', 1), (8, '2019-03-31', NULL), (9, 'default2', NULL), (10, '2019-01-01', 1), (11, NULL, 1), (12, '2019-03-31', NULL), (13, '2019-03-31', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 0, NULL, '2019-04-01', NULL, NULL), (2, NULL, 1, '2019-01-02', NULL, 1), (5, -1, NULL, '2018-12-31', NULL, NULL), (5, 1, -1, '2023-01-02', NULL, 1), (2, 0, 0, '2018-12-31', NULL, 1), (3, 0, -1, '2019-03-31', 1, 1), (1, 0, 0, '2018-12-31', NULL, 1), (8, NULL, 0, '2023-01-02', 1, 1), (2, 1, NULL, '2023-01-02', 1, NULL), (2, NULL, 1, '2019-04-01', NULL, 1), (8, 1, NULL, '2023-01-01', 1, NULL), (2, NULL, -1, '2019-03-31', 1, NULL), (11, 0, -1, '2019-01-01', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(3, 'default1')
(11, None)
*/

-- Prediction Query
SELECT S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY S.PRODUCT_ID HAVING ' 2019-01-01' <= MIN(S.SALE_DATE) AND MAX(S.SALE_DATE) <= '2019-03-31';

/*
Prediction Result:
(1, '2019-03-31')
(3, 'default1')
(11, None)
*/