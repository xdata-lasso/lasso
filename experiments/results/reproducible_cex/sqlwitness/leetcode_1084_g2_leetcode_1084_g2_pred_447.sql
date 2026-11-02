-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, '2019-03-31', NULL), (0, 'default2', NULL), (1, NULL, NULL), (2, '2019-03-31', 1), (3, '2019-01-01', 1), (4, 'default2', NULL), (5, 'default2', NULL), (6, 'default1', NULL), (7, '2019-03-31', NULL), (8, '2019-03-31', 1), (9, '2019-01-01', NULL), (10, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 0, -1, '2019-04-01', NULL, NULL), (0, 0, -1, NULL, NULL, NULL), (8, 1, 1, NULL, 1, 1), (0, NULL, 0, NULL, 1, NULL), (NULL, 0, 1, '2023-01-02', NULL, 1), (0, 1, -1, '2019-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(0, 'default2')
*/

-- Prediction Query
WITH SALES_NOT_IN_TIME AS (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < DATE('2019-01-01') OR SALE_DATE > DATE('2019-03-31')) SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S LEFT JOIN SALES_NOT_IN_TIME AS SN ON S.PRODUCT_ID = SN.PRODUCT_ID JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE SN.PRODUCT_ID IS NULL;

/*
Prediction Result:
(0, 'default2')
(8, '2019-03-31')
*/