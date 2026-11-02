-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-01-01', 1), (2, 'default1', 2), (1, '2019-01-01', 1), (3, 'default1', NULL), (4, 'default1', NULL), (5, 'default2', 1), (6, 'default1', 2), (7, '2019-03-31', 1), (8, 'default1', NULL), (9, 'default2', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 0, 2, '2019-04-01', NULL, 2), (2, 0, NULL, '2019-03-30', 2, 1), (0, 0, 1, '2019-03-31', NULL, 1), (0, 0, NULL, '2023-01-02', 2, 1), (4, NULL, NULL, NULL, 2, 1), (6, 0, 2, NULL, 1, NULL), (9, NULL, 0, '2019-03-30', 2, 2), (0, 1, 0, '2023-01-02', 2, 1), (6, 2, 2, '2019-03-31', 2, 2), (4, 0, 2, NULL, 2, 2), (3, 0, 1, NULL, 2, NULL), (4, 1, 1, '2019-04-01', NULL, 2), (9, 0, 0, NULL, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(6, 'default1')
(9, 'default2')
(3, 'default1')
*/

-- Prediction Query
WITH MIN_MAX AS (SELECT S.PRODUCT_ID, P.PRODUCT_NAME, MIN(SALE_DATE) AS MIN_SALE, MAX(SALE_DATE) AS MAX_SALE FROM SALES AS S INNER JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY 1) SELECT MM.PRODUCT_ID, MM.PRODUCT_NAME FROM MIN_MAX AS MM WHERE MM.MIN_SALE BETWEEN '2019-01-01' AND '2019-03-31' AND MM.MAX_SALE BETWEEN '2019-01-01' AND '2019-03-31';

/*
Prediction Result:
(6, 'default1')
(9, 'default2')
*/