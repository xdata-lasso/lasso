-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', NULL), (0, NULL, 1), (2, '2019-01-01', NULL), (3, '2019-01-01', 1), (4, NULL, NULL), (5, 'default1', 1), (6, 'default2', 1), (7, '2019-03-31', NULL), (8, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, NULL, 1, '2023-01-01', 1, NULL), (3, NULL, NULL, '2019-04-01', 1, 1), (2, 0, NULL, '2023-01-01', NULL, 1), (NULL, 0, 0, '2023-01-02', NULL, NULL), (8, 1, 1, '2019-04-01', 1, NULL), (4, 1, 1, '2019-01-02', 1, NULL), (5, 0, 0, '2019-03-30', 1, NULL), (4, 1, NULL, NULL, NULL, 1), (8, 1, 1, '2019-04-01', 1, 1), (3, 1, 0, '2023-01-01', 1, 1), (0, 0, 0, '2019-01-02', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(4, None)
(5, 'default1')
*/

-- Prediction Query
SELECT DISTINCT (S.PRODUCT_ID), P.PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID WHERE S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT P.PRODUCT_ID IN (SELECT P.PRODUCT_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID WHERE NOT S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31');

/*
Prediction Result:
*/