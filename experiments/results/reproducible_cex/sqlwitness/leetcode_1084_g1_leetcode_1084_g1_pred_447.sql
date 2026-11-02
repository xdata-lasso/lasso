-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-03-31', NULL), (1, NULL, NULL), (2, '2019-03-31', NULL), (3, '2019-01-01', 1), (4, NULL, NULL), (5, '2019-03-31', NULL), (6, 'default2', 1), (7, '2019-03-31', 1), (8, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 1, 1, '2023-01-02', 1, NULL), (4, 0, 1, '2023-01-02', 1, NULL), (NULL, 0, 1, '2019-04-01', NULL, NULL), (5, NULL, 1, '2019-03-31', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
WITH SALES_NOT_IN_TIME AS (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < DATE('2019-01-01') OR SALE_DATE > DATE('2019-03-31')) SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S LEFT JOIN SALES_NOT_IN_TIME AS SN ON S.PRODUCT_ID = SN.PRODUCT_ID JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE SN.PRODUCT_ID IS NULL;

/*
Prediction Result:
(5, '2019-03-31')
*/