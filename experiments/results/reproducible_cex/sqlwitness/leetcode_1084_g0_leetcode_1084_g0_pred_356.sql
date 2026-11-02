-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-01-01', NULL), (0, '2019-01-01', 1), (2, 'default1', NULL), (3, '2019-03-31', NULL), (4, '2019-03-31', NULL), (5, NULL, NULL), (6, '2019-03-31', 1), (7, 'default1', NULL), (8, 'default2', NULL), (9, 'default1', 1), (10, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (9, 1, NULL, '2019-04-01', 1, 1), (10, 0, 0, '2019-04-01', 1, NULL), (1, 0, 0, '2019-03-31', NULL, NULL), (6, 1, 0, NULL, 1, NULL), (5, 0, 0, NULL, 1, NULL), (9, 1, NULL, '2023-01-01', 1, NULL), (8, NULL, 1, '2019-01-01', 1, NULL), (0, NULL, 1, '2019-04-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(1, '2019-01-01')
(8, 'default2')
*/

-- Prediction Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P NATURAL JOIN SALES AS S WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31');

/*
Prediction Result:
(1, '2019-01-01')
(6, '2019-03-31')
(5, None)
(8, 'default2')
*/