-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-01-01', 1), (1, '2019-01-01', 1), (2, '2019-01-01', NULL), (3, 'default1', 1), (4, '2019-01-01', NULL), (5, NULL, NULL), (6, '2019-01-01', 1), (7, '2019-01-01', 1), (8, '2019-03-31', NULL), (9, '2019-01-01', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 1, 1, '2019-01-01', NULL, 1), (9, 1, NULL, '2019-03-31', NULL, NULL), (1, 0, NULL, NULL, 1, 1), (7, 0, 0, NULL, NULL, 1), (2, 1, 0, '2019-03-31', 1, NULL), (NULL, 1, 0, '2019-03-31', 1, 1), (NULL, 0, NULL, '2023-01-02', 1, NULL), (NULL, 0, 0, '2023-01-01', NULL, 1), (7, 0, 0, '2023-01-01', NULL, 1), (9, 1, 0, '2023-01-01', 1, 1), (7, 1, NULL, '2018-12-31', NULL, 1), (6, 1, NULL, '2018-12-31', 1, 1), (8, 0, 0, NULL, 1, 1), (4, NULL, 0, '2018-12-31', NULL, 1);
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
SELECT DISTINCT PRODUCT_ID AS PRODUCT_ID, PRODUCT_NAME FROM PRODUCT WHERE PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') AND NOT PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
*/