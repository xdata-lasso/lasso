-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, 1), (1, '2019-03-31', NULL), (2, 'default2', 1), (3, NULL, 1), (4, 'default1', NULL), (5, 'default1', NULL), (6, 'default2', NULL), (7, 'default1', NULL), (8, '2019-01-01', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 1, 1, '2019-03-30', 1, 1), (8, 0, 1, '2019-04-01', NULL, NULL), (7, 1, 1, '2019-03-31', NULL, NULL), (2, NULL, NULL, '2019-03-31', NULL, 1), (6, NULL, 1, '2019-03-31', NULL, 1), (NULL, NULL, NULL, '2023-01-02', NULL, NULL), (NULL, NULL, 1, '2019-01-02', NULL, NULL), (1, NULL, 1, '2018-12-31', NULL, 1), (5, 0, 1, '2023-01-02', 1, NULL), (6, NULL, 1, '2019-03-31', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(2, 'default2')
(6, 'default2')
(7, 'default1')
*/

-- Prediction Query
SELECT DISTINCT (S.PRODUCT_ID), PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT S.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') AND SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' ORDER BY S.PRODUCT_ID, (S.PRODUCT_ID) NULLS LAST, PRODUCT_NAME NULLS LAST;

/*
Prediction Result:
*/