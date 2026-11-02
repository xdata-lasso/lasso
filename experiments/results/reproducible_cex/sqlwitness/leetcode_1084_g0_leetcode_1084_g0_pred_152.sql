-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-01-01', 1), (1, 'default1', 1), (2, 'default2', NULL), (3, '2019-01-01', 1), (4, '2019-01-01', NULL), (5, 'default2', NULL), (6, 'default2', NULL), (7, 'default2', NULL), (8, 'default2', 1), (9, 'default2', 1), (10, 'default1', NULL), (11, '2019-03-31', 1), (12, 'default1', NULL), (13, NULL, 1), (14, '2019-03-31', 1), (15, '2019-03-31', 1), (16, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (11, NULL, 0, '2019-01-02', 1, NULL), (1, 1, NULL, NULL, NULL, NULL), (11, NULL, NULL, '2023-01-01', 1, NULL), (3, 0, NULL, NULL, NULL, NULL), (0, 1, 1, '2019-03-30', 1, NULL), (16, NULL, NULL, '2019-03-31', 1, NULL), (10, 1, 0, '2019-04-01', NULL, NULL), (NULL, 1, 0, '2019-01-01', NULL, 1), (0, 1, NULL, '2023-01-02', 1, 1), (NULL, 1, 0, '2019-03-31', NULL, 1), (5, 0, NULL, '2023-01-01', NULL, 1), (9, 0, 1, '2019-04-01', NULL, 1), (13, NULL, NULL, '2019-03-31', 1, NULL), (0, 0, 0, '2019-04-01', NULL, NULL), (12, 0, 0, '2023-01-02', 1, NULL), (16, 0, 0, '2018-12-31', 1, NULL), (2, 1, NULL, '2023-01-02', NULL, NULL), (12, 0, NULL, NULL, 1, NULL), (13, NULL, NULL, '2018-12-31', NULL, 1), (1, 1, 0, NULL, NULL, NULL), (0, 0, 0, '2019-01-01', 1, 1), (NULL, 1, 0, '2018-12-31', NULL, NULL), (0, NULL, 0, '2023-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT P.PRODUCT_ID FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE (S.SALE_DATE > '2019-03-31' OR S.SALE_DATE < '2019-01-01'));

/*
Prediction Result:
(1, 'default1')
(3, '2019-01-01')
*/