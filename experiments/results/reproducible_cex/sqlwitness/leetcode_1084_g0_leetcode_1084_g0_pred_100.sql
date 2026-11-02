-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', NULL), (1, 'default2', 1), (2, '2019-01-01', 1), (3, '2019-03-31', NULL), (4, '2019-01-01', NULL), (5, NULL, 1), (6, NULL, 1), (7, 'default1', 1), (8, NULL, 1), (9, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (9, 1, NULL, '2023-01-01', 1, NULL), (4, 0, 0, '2023-01-01', NULL, NULL), (5, NULL, NULL, '2023-01-02', 1, 1), (5, 1, NULL, '2019-03-30', NULL, NULL), (7, 1, 0, '2019-01-01', NULL, NULL), (2, 0, 1, '2019-04-01', NULL, 1), (6, 0, 1, '2019-03-30', NULL, 1), (9, 0, 0, '2018-12-31', NULL, 1), (NULL, NULL, 0, '2019-03-31', NULL, 1), (0, 0, 1, '2023-01-01', 1, NULL), (6, 0, NULL, '2019-04-01', NULL, 1), (4, 0, 0, '2018-12-31', 1, 1), (5, NULL, NULL, '2019-03-31', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(7, 'default1')
*/

-- Prediction Query
WITH NT1 AS (SELECT PRODUCT.PRODUCT_ID, PRODUCT.PRODUCT_NAME, SALES.SALE_DATE FROM SALES LEFT JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID) SELECT PRODUCT_ID, PRODUCT_NAME FROM NT1 GROUP BY PRODUCT_ID HAVING MIN(NT1.SALE_DATE) >= '2019-01-01' AND MAX(NT1.SALE_DATE) <= '2019-03-31';

/*
Prediction Result:
(None, None)
(7, 'default1')
*/