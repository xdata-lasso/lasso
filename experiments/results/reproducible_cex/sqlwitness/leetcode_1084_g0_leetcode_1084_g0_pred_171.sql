-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-03-31', NULL), (1, '2019-01-01', NULL), (2, '2019-03-31', NULL), (3, 'default2', 1), (4, NULL, NULL), (5, '2019-03-31', NULL), (6, 'default1', 1), (7, NULL, NULL), (8, NULL, NULL), (9, 'default2', NULL), (10, 'default2', 1), (11, '2019-01-01', NULL), (12, NULL, 1), (13, '2019-01-01', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 1, 1, '2019-03-31', NULL, NULL), (10, NULL, 0, NULL, NULL, NULL), (1, 1, 1, '2019-01-01', 1, NULL), (9, 1, 0, NULL, NULL, NULL), (4, 0, 0, '2019-04-01', NULL, 1), (NULL, 1, NULL, '2019-01-01', 1, 1), (13, 0, 1, '2019-03-30', 1, 1), (NULL, NULL, 0, '2023-01-01', 1, NULL), (11, 1, 0, '2019-01-02', NULL, NULL), (0, 1, 0, '2023-01-01', NULL, 1), (1, 0, 1, '2023-01-01', NULL, 1), (NULL, 1, 0, '2019-01-01', NULL, NULL), (1, NULL, 1, '2023-01-01', NULL, 1), (4, 0, 1, '2019-01-02', 1, NULL), (10, NULL, NULL, '2018-12-31', 1, NULL), (NULL, 0, 1, '2023-01-02', NULL, 1), (9, NULL, 1, NULL, NULL, NULL), (5, NULL, 0, '2019-03-30', 1, 1), (9, 0, NULL, '2019-03-31', 1, 1), (1, 1, 1, '2018-12-31', 1, NULL), (11, 1, 1, '2019-03-31', NULL, 1), (13, 0, NULL, '2023-01-02', 1, 1), (12, 0, 0, '2019-04-01', 1, NULL), (12, 0, 1, '2019-03-30', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(3, 'default2')
(5, '2019-03-31')
(9, 'default2')
(11, '2019-01-01')
*/

-- Prediction Query
SELECT DISTINCT S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT S.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31' OR SALE_DATE < '2019-01-01');

/*
Prediction Result:
*/