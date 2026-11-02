-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, '2019-03-31', NULL), (1, 'default1', 1), (0, 'default2', 2), (-1, 'default1', NULL), (3, 'default1', NULL), (4, 'default1', 1), (5, '2019-03-31', NULL), (6, 'default2', 1), (7, '2019-03-31', 2), (8, NULL, 1), (9, 'default1', 2), (10, NULL, 1), (11, '2019-03-31', 2), (12, 'default2', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 1, -1, '2019-01-01', 2, 2), (NULL, 2, 2, '2019-04-01', 2, NULL), (8, 1, 2, '2019-01-01', 2, NULL), (1, 2, 1, NULL, NULL, NULL), (9, 2, -1, '2019-04-01', NULL, 1), (-1, -1, NULL, '2019-04-01', 1, 2), (0, 2, -1, '2023-01-01', 1, NULL), (7, -1, 2, '2019-03-31', NULL, 1), (NULL, 1, 1, '2019-01-01', NULL, NULL), (8, -1, -1, '2023-01-02', NULL, NULL), (6, 0, 2, '2019-01-01', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(5, '2019-03-31')
(6, 'default2')
(7, '2019-03-31')
*/

-- Prediction Query
SELECT P.PRODUCT_ID, PRODUCT_NAME FROM PRODUCT AS P JOIN (SELECT PRODUCT_ID, SUM(FLAG) FROM (SELECT PRODUCT_ID, SALE_DATE, CASE WHEN SALE_DATE < '2019-01-01' THEN 1 WHEN SALE_DATE > '2019-03-31' THEN 1 ELSE 0 END AS FLAG FROM SALES) AS X GROUP BY PRODUCT_ID HAVING SUM(FLAG) = 0) AS Y ON P.PRODUCT_ID = Y.PRODUCT_ID;

/*
Prediction Result:
(1, 'default1')
(5, '2019-03-31')
(6, 'default2')
(7, '2019-03-31')
*/