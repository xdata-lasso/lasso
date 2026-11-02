-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, 1), (0, 'default2', NULL), (2, NULL, 1), (3, NULL, 1), (4, NULL, 1), (5, 'default1', 1), (6, NULL, NULL), (7, NULL, 1), (8, NULL, NULL), (9, '2019-04-01', NULL), (10, '2019-04-01', NULL), (11, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 0, NULL, '2018-12-31', 1, NULL), (10, NULL, 0, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(10, '2019-04-01')
*/

-- Prediction Query
WITH OTHER_THAN_2019_SPRING AS (SELECT DISTINCT (PRODUCT_ID) FROM SALES AS S WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31') SELECT DISTINCT (S.PRODUCT_ID), P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE SALE_DATE >= '2019-01-01' AND SALE_DATE < '2019-04-01' AND NOT S.PRODUCT_ID IN (SELECT * FROM OTHER_THAN_2019_SPRING);

/*
Prediction Result:
*/