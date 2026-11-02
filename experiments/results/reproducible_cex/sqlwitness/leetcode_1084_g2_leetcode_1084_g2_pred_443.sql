-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, NULL, 1), (1, 'default2', 1), (0, NULL, NULL), (2, 'default2', 1), (3, 'default1', NULL), (4, 'default2', NULL), (5, '2019-01-01', 1), (6, 'default2', 1), (7, NULL, 1), (8, 'default2', NULL), (9, '2019-03-31', 1), (10, 'default2', 1), (11, 'default1', 1), (12, '2019-01-01', NULL), (13, '2019-03-31', 1), (14, 'default2', NULL), (15, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (11, -1, 0, '2019-03-31', NULL, NULL), (3, -1, NULL, '2019-01-02', 1, NULL), (12, NULL, NULL, '2019-01-01', NULL, 1), (2, NULL, NULL, '2018-12-31', 1, NULL), (9, 0, NULL, '2019-04-01', 1, NULL), (6, 1, 1, '2019-03-30', NULL, 1), (1, 0, 1, '2019-01-01', 1, 1), (13, 0, 1, '2023-01-01', 1, NULL), (-1, NULL, 0, '2019-04-01', 1, NULL), (NULL, 0, NULL, '2019-04-01', 1, 1), (15, 1, -1, '2019-01-01', 1, NULL), (NULL, -1, NULL, '2019-04-01', NULL, NULL), (14, -1, 1, '2019-01-01', 1, 1), (1, 0, -1, '2018-12-31', NULL, NULL), (0, -1, 0, '2019-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(0, None)
(3, 'default1')
(6, 'default2')
(11, 'default1')
(12, '2019-01-01')
(14, 'default2')
(15, 'default2')
*/

-- Prediction Query
SELECT DISTINCT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT JOIN SALES USING (PRODUCT_ID) WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
*/