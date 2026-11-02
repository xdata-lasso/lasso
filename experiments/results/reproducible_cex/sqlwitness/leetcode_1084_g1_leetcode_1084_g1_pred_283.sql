-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-03-31', 2), (2, 'default1', NULL), (1, 'default1', NULL), (3, '2019-03-31', 2), (4, '2019-03-31', NULL), (5, '2019-03-31', NULL), (6, '2019-01-01', 1), (7, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (7, 1, 0, '2019-01-02', 2, 1), (4, 0, 0, '2019-01-01', NULL, 2), (7, NULL, NULL, '2019-03-31', 2, NULL), (7, 2, 0, '2018-12-31', 1, 2), (0, 2, 0, '2019-03-30', NULL, NULL), (4, NULL, 1, '2019-03-31', 2, NULL), (4, 2, 0, '2019-01-01', 1, NULL), (5, 0, 1, '2023-01-01', 2, 1), (NULL, 0, 0, '2019-03-30', 1, 2), (2, 0, 1, '2019-01-02', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(4, '2019-03-31')
(0, '2019-03-31')
(2, 'default1')
*/

-- Prediction Query
WITH TEMP AS (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31') SELECT DISTINCT P.PRODUCT_ID, PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE SALE_DATE >= '2019-01-01' AND SALE_DATE <= '2019-03-31' AND NOT P.PRODUCT_ID IN (SELECT * FROM TEMP) ORDER BY 1, P.PRODUCT_ID NULLS LAST, PRODUCT_NAME NULLS LAST;

/*
Prediction Result:
(0, '2019-03-31')
(2, 'default1')
(4, '2019-03-31')
*/