-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, NULL, NULL), (0, 'default2', 1), (1, '2019-03-31', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 0, 1, '2019-03-31', 1, 1), (NULL, 1, 1, '2023-01-01', NULL, NULL), (-1, 1, -1, '2019-01-02', 1, NULL), (-1, NULL, -1, '2023-01-01', NULL, NULL), (1, 0, -1, '2018-12-31', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(0, 'default2')
*/

-- Prediction Query
WITH SALES_LIST AS (SELECT S.PRODUCT_ID, S.SALE_DATE, P.PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID) SELECT DISTINCT PRODUCT_ID, PRODUCT_NAME FROM SALES_LIST WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES_LIST WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31');

/*
Prediction Result:
*/