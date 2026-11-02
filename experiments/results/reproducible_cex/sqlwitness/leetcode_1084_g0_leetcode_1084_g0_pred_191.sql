-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', 1), (1, '2019-01-01', NULL), (2, '2019-01-01', NULL), (3, NULL, NULL), (4, NULL, 1), (5, 'default2', 1), (6, '2019-01-01', NULL), (7, 'default2', 1), (8, 'default2', NULL), (9, 'default2', NULL), (10, '2019-01-01', 1), (11, 'default2', 1), (12, '2019-01-01', NULL), (13, 'default2', 1), (14, '2019-01-01', NULL), (15, NULL, NULL), (16, NULL, NULL), (17, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 1, 1, '2019-01-01', 1, NULL), (0, 0, NULL, '2019-03-30', NULL, NULL), (9, 1, 0, NULL, 1, NULL), (0, 0, 0, '2018-12-31', NULL, NULL), (15, 0, NULL, '2019-04-01', NULL, NULL), (12, 0, NULL, '2023-01-01', 1, 1), (15, NULL, NULL, '2019-04-01', NULL, NULL), (5, NULL, NULL, '2018-12-31', NULL, NULL), (NULL, 1, 1, '2023-01-02', NULL, 1), (2, 1, NULL, '2019-03-30', 1, NULL), (15, NULL, 0, NULL, 1, 1), (7, NULL, NULL, '2023-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(1, '2019-01-01')
(2, '2019-01-01')
*/

-- Prediction Query
SELECT DISTINCT S.PRODUCT_ID, PRODUCT_NAME FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID AND SALE_DATE >= '2019-01-01' AND SALE_DATE <= '2019-03-31' AND NOT S.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
*/