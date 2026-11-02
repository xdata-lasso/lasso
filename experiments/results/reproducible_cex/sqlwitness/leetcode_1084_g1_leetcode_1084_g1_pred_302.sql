-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-01-01', 1), (0, 'default2', 1), (2, NULL, 1), (3, 'default1', NULL), (4, 'default1', 1), (5, 'default1', 1), (6, '2019-01-01', NULL), (7, '2019-03-31', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 0, 1, '2019-01-01', NULL, NULL), (3, 1, 1, NULL, 1, NULL), (4, NULL, 1, '2019-03-31', NULL, 1), (6, NULL, 1, '2019-01-01', NULL, NULL), (0, NULL, NULL, '2018-12-31', NULL, NULL), (NULL, 0, 1, '2019-03-31', NULL, NULL), (2, NULL, 1, '2019-01-02', 1, 1), (5, NULL, NULL, '2019-03-31', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(3, 'default1')
(4, 'default1')
(6, '2019-01-01')
(2, None)
(5, 'default1')
*/

-- Prediction Query
WITH PRODUCT_DATES AS (SELECT P.PRODUCT_ID, P.PRODUCT_NAME, MIN(S.SALE_DATE) AS FIRST_DATE, MAX(S.SALE_DATE) AS LAST_DATE FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID) SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT_DATES WHERE FIRST_DATE >= '2019-01-01' AND FIRST_DATE <= '2019-03-31' AND LAST_DATE >= '2019-01-01' AND LAST_DATE <= '2019-03-31';

/*
Prediction Result:
(2, None)
(4, 'default1')
(5, 'default1')
(6, '2019-01-01')
*/