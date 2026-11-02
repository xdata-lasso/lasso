-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, 1), (0, 'default1', 1), (2, '2019-03-31', 1), (3, 'default2', 1), (4, '2019-01-01', 1), (5, 'default2', NULL), (6, '2019-03-31', 1), (7, '2019-01-01', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, NULL, 0, '2019-03-30', NULL, NULL), (0, 0, 0, '2019-04-01', NULL, 1), (NULL, NULL, 1, '2023-01-02', 1, NULL), (1, NULL, 1, '2019-03-30', NULL, 1), (5, NULL, 0, '2019-03-30', 1, 1), (1, 0, NULL, NULL, 1, NULL), (6, 0, 1, '2019-04-01', 1, NULL), (NULL, NULL, 0, '2023-01-02', 1, 1), (0, NULL, 0, '2019-03-30', NULL, NULL), (2, 1, NULL, '2018-12-31', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(1, None)
(5, 'default2')
*/

-- Prediction Query
WITH SOLD AS (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31'), NOT_SOLD AS (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT WHERE NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM NOT_SOLD) AND PRODUCT_ID IN (SELECT PRODUCT_ID FROM SOLD);

/*
Prediction Result:
*/