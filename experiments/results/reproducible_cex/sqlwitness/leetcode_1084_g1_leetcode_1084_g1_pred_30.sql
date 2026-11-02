-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-01-01', NULL), (0, 'default2', 1), (2, NULL, NULL), (3, 'default1', NULL), (4, '2019-03-31', 1), (5, 'default1', NULL), (6, '2019-01-01', 1), (7, 'default1', 1), (8, 'default2', 1), (9, NULL, NULL), (10, '2019-01-01', NULL), (11, 'default2', NULL), (12, NULL, 1), (13, NULL, NULL), (14, 'default1', NULL), (15, '2019-03-31', NULL), (16, 'default1', NULL), (17, NULL, NULL), (18, 'default2', 1), (19, '2019-01-01', 1), (20, NULL, 1), (21, 'default2', NULL), (22, '2019-01-01', NULL), (23, '2019-01-01', NULL), (24, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (18, 1, 0, '2019-01-01', NULL, NULL), (18, NULL, 0, '2019-04-01', 1, 1), (12, 0, 0, '2019-03-30', 1, NULL), (NULL, 0, NULL, '2023-01-02', 1, NULL), (10, 1, NULL, NULL, 1, 1), (18, 1, 0, '2018-12-31', NULL, NULL), (22, NULL, 0, '2018-12-31', 1, NULL), (3, 1, 0, '2019-04-01', NULL, 1), (11, 0, 0, '2019-03-30', NULL, NULL), (19, 0, 1, '2019-04-01', NULL, 1), (20, 1, 0, NULL, 1, 1), (11, NULL, 1, '2019-03-30', 1, 1), (16, 0, NULL, '2023-01-02', NULL, 1), (9, 0, 1, '2023-01-01', 1, 1), (17, NULL, 0, '2018-12-31', NULL, NULL), (15, 0, NULL, NULL, 1, NULL), (0, NULL, 0, '2019-04-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN SALES AS S USING (PRODUCT_ID) GROUP BY PRODUCT_ID HAVING MIN(S.SALE_DATE) >= '2019-01-01' AND MAX(S.SALE_DATE) <= '2019-03-31';

/*
Prediction Result:
(11, 'default2')
(12, None)
*/