-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-01-01', 1), (1, 'default2', 1), (2, '2019-03-31', NULL), (3, 'default2', 1), (4, 'default1', 1), (5, '2019-01-01', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 1, 1, '2019-01-02', 1, 1), (2, 0, 1, '2019-01-02', NULL, NULL), (NULL, NULL, 1, NULL, 1, NULL), (NULL, 1, NULL, '2018-12-31', NULL, NULL), (2, 1, 0, '2023-01-01', NULL, 1), (0, 0, 1, '2023-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(4, 'default1')
*/

-- Prediction Query
WITH PRODUCTS_SOLD_ON_PERIOD AS (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31'), PRODUCTS_NOT_SOLD_ON_PERIOD AS (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT WHERE NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCTS_NOT_SOLD_ON_PERIOD) AND PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCTS_SOLD_ON_PERIOD);

/*
Prediction Result:
*/