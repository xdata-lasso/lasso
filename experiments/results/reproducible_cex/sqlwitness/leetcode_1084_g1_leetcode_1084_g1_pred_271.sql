-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', 1), (0, 'default1', 1), (2, NULL, NULL), (3, '2019-03-31', 1), (4, '2019-01-01', 1), (5, NULL, 1), (6, '2019-03-31', 1), (7, '2019-03-31', NULL), (8, NULL, 1), (9, 'default2', NULL), (10, '2019-01-01', NULL), (11, 'default2', NULL), (12, 'default2', NULL), (13, '2019-01-01', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 0, NULL, '2019-03-30', 1, NULL), (1, 0, 1, NULL, 1, 1), (NULL, 0, 1, '2019-03-31', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(4, '2019-01-01')
(1, 'default1')
*/

-- Prediction Query
WITH PRODUCT_SOLD_SPRING AS (SELECT PRODUCT_ID, MIN(SALE_DATE) AS START_DATE, MAX(SALE_DATE) AS END_DATE FROM SALES GROUP BY PRODUCT_ID) SELECT S.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT_SOLD_SPRING AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE START_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND END_DATE BETWEEN '2019-01-01' AND '2019-03-31';

/*
Prediction Result:
(4, '2019-01-01')
*/