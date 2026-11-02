-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-03-31', NULL), (1, 'default1', NULL), (2, '2019-01-01', 1), (3, 'default2', 1), (4, 'default1', 1), (5, NULL, 1), (6, 'default1', NULL), (7, 'default1', NULL), (8, NULL, NULL), (9, '2019-01-01', 1), (10, 'default2', NULL), (11, NULL, 1), (12, '2019-03-31', 1), (13, '2019-01-01', NULL), (14, NULL, NULL), (15, 'default2', NULL), (16, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 0, NULL, '2019-03-31', 1, NULL), (2, NULL, NULL, '2019-01-02', 1, 1), (3, NULL, 1, '2019-01-01', NULL, 1), (9, 1, NULL, NULL, NULL, NULL), (3, 1, 1, NULL, NULL, NULL), (15, 0, 0, '2018-12-31', NULL, 1), (16, 1, 0, '2019-03-31', 1, 1), (NULL, 0, 1, '2023-01-02', NULL, 1), (4, 1, 1, '2023-01-01', 1, 1), (0, 0, NULL, '2019-01-01', 1, NULL), (16, NULL, 1, '2023-01-01', 1, NULL), (9, NULL, 0, '2018-12-31', 1, NULL), (15, 0, 0, '2023-01-01', NULL, 1), (11, 0, 0, NULL, NULL, NULL), (7, NULL, NULL, '2019-04-01', 1, NULL), (10, 1, 1, '2019-01-02', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(0, '2019-03-31')
(2, '2019-01-01')
(3, 'default2')
(10, 'default2')
*/

-- Prediction Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
*/