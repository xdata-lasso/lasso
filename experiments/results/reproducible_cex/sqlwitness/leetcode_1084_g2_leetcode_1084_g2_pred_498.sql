-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, NULL), (0, '2019-01-01', NULL), (-1, '2019-01-01', NULL), (2, '2019-03-31', NULL), (3, 'default2', NULL), (4, '2019-01-01', NULL), (5, '2019-03-31', NULL), (6, 'default2', NULL), (7, NULL, 1), (8, '2019-03-31', 1), (9, NULL, 1), (10, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 1, -1, '2019-03-30', 1, 1), (9, 0, NULL, '2019-01-01', 1, NULL), (6, NULL, NULL, '2019-03-31', 1, 1), (8, 1, 1, '2019-03-30', 1, 1), (-1, 1, 1, '2023-01-02', 1, NULL), (7, 1, 0, '2018-12-31', 1, 1), (6, 0, -1, NULL, 1, NULL), (-1, 1, 1, '2023-01-01', NULL, 1), (10, 1, NULL, NULL, NULL, NULL), (7, -1, 0, '2019-01-01', NULL, 1), (NULL, NULL, 1, '2019-01-02', 1, 1), (0, NULL, 0, '2019-03-30', NULL, 1), (NULL, -1, 1, '2019-01-01', NULL, 1), (6, NULL, NULL, NULL, 1, NULL), (1, 0, NULL, '2019-03-31', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(0, '2019-01-01')
(1, None)
(6, 'default2')
(8, '2019-03-31')
(9, None)
*/

-- Prediction Query
SELECT S.PRODUCT_ID, P.PRODUCT_NAME FROM (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MAX(SALE_DATE) <= '2019-03-31' AND MIN(SALE_DATE) >= '2019-01-01') AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID;

/*
Prediction Result:
(None, None)
(0, '2019-01-01')
(1, None)
(6, 'default2')
(8, '2019-03-31')
(9, None)
*/