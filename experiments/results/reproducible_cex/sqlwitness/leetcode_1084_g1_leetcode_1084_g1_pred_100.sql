-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-03-31', NULL), (1, '2019-01-01', 1), (2, NULL, 1), (3, '2019-03-31', NULL), (4, 'default1', 1), (5, NULL, NULL), (6, '2019-01-01', 1), (7, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 0, 1, '2019-03-30', NULL, NULL), (6, 1, 1, '2019-01-01', NULL, 1), (0, 0, 0, '2019-04-01', 1, 1), (3, 1, 0, '2018-12-31', 1, 1), (0, NULL, 1, '2019-01-01', NULL, 1), (4, 1, NULL, '2019-03-30', NULL, 1), (6, 0, 1, '2023-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(4, 'default1')
*/

-- Prediction Query
WITH NT1 AS (SELECT PRODUCT.PRODUCT_ID, PRODUCT.PRODUCT_NAME, SALES.SALE_DATE FROM SALES LEFT JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID) SELECT PRODUCT_ID, PRODUCT_NAME FROM NT1 GROUP BY PRODUCT_ID HAVING MIN(NT1.SALE_DATE) >= '2019-01-01' AND MAX(NT1.SALE_DATE) <= '2019-03-31';

/*
Prediction Result:
(None, None)
(4, 'default1')
*/