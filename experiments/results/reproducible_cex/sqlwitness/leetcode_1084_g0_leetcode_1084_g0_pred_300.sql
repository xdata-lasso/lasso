-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-04-01', 1), (1, '2019-01-01', NULL), (2, '2019-04-01', 1), (3, 'default1', 1), (4, 'default1', 1), (5, '2019-03-31', 1), (6, 'default2', 1), (7, 'default2', 1), (8, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 1, 1, '2023-01-01', NULL, 1), (2, NULL, 0, '2019-04-01', NULL, 1), (4, NULL, 0, NULL, 1, NULL), (4, 0, 0, '2019-04-02', NULL, NULL), (2, 1, 0, '2019-04-01', 1, NULL), (8, NULL, NULL, '2018-12-31', NULL, NULL), (4, NULL, 1, '2019-01-02', NULL, NULL), (4, 0, NULL, '2018-12-31', 1, 1), (7, NULL, NULL, '2023-01-01', NULL, NULL), (5, 0, 1, '2019-04-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P WHERE P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES AS S GROUP BY S.PRODUCT_ID HAVING MAX(S.SALE_DATE) BETWEEN '2019-01-01' AND '2019-04-01' AND MIN(S.SALE_DATE) BETWEEN '2019-01-01' AND '2019-04-01');

/*
Prediction Result:
(2, '2019-04-01')
(5, '2019-03-31')
*/