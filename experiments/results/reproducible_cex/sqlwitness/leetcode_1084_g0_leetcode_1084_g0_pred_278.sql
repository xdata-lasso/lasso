-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, '2019-01-01', NULL), (2, 'default1', 2), (0, '2019-03-31', 2), (1, NULL, 1), (3, '2019-03-31', 1), (4, '2019-03-31', 2), (5, 'default1', 2), (6, NULL, 2), (7, 'default2', 1), (8, '2019-03-31', 1), (9, NULL, 1), (10, '2019-01-01', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 0, NULL, '2023-01-01', NULL, NULL), (0, NULL, -1, '2019-03-30', 1, NULL), (9, 2, 1, '2023-01-01', 1, NULL), (0, NULL, -1, '2019-04-01', 2, NULL), (4, 2, 2, '2023-01-01', NULL, 2), (NULL, 1, -1, '2018-12-31', 1, 2), (8, 1, 0, NULL, NULL, NULL), (1, 0, NULL, NULL, NULL, 2), (8, 1, -1, '2023-01-02', 1, 1), (6, -1, 2, '2019-03-30', 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(6, None)
*/

-- Prediction Query
WITH SALESINFO AS (SELECT PRODUCT_ID, SUM(CASE WHEN SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31' THEN 1 ELSE 0 END) AS FLAG FROM SALES GROUP BY PRODUCT_ID) SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALESINFO WHERE FLAG = 0);

/*
Prediction Result:
(1, None)
(6, None)
*/