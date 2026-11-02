-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', 1), (1, '2019-03-31', 1), (2, '2019-03-31', 1), (3, NULL, 1), (4, 'default2', 1), (5, 'default1', NULL), (6, '2019-03-31', 1), (7, 'default1', NULL), (8, '2019-01-01', 1), (9, '2019-03-31', 1), (10, '2019-03-31', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, NULL, NULL, '2018-12-31', 1, 1), (5, NULL, NULL, '2019-01-01', 1, 1), (5, NULL, 1, NULL, 1, NULL), (0, 0, NULL, NULL, 1, NULL), (0, NULL, 0, '2023-01-01', NULL, 1), (3, NULL, 0, '2019-03-31', 1, NULL), (3, 1, 1, '2019-04-01', NULL, 1), (5, 1, 0, '2019-03-31', 1, 1), (NULL, NULL, 0, '2019-01-02', 1, 1), (NULL, 0, 1, '2023-01-01', NULL, 1), (7, 0, 0, '2019-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
WITH TEMP_TABLE AS (SELECT S.PRODUCT_ID, P.PRODUCT_NAME, S.SALE_DATE FROM PRODUCT AS P INNER JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID) SELECT DISTINCT PRODUCT_ID, PRODUCT_NAME FROM TEMP_TABLE WHERE SALE_DATE >= '2019-01-01' AND SALE_DATE <= '2019-03-31' AND NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM TEMP_TABLE WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
(7, 'default1')
*/