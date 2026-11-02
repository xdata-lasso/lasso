-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', NULL), (0, 'default2', 1), (-1, 'default2', NULL), (2, 'S8', 2), (3, 'S8', 2), (4, 'iPhone', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 0, 1, NULL, 1, NULL), (4, NULL, 0, NULL, 1, 1), (0, 2, NULL, NULL, NULL, 2), (NULL, 1, -1, '2023-01-01', 2, NULL), (2, 2, 0, NULL, NULL, 1), (2, 0, NULL, '2023-01-02', NULL, 2), (-1, 2, -1, NULL, 2, 1), (1, -1, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH SALES_EXPANDED AS (SELECT S.*, P.PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID), SUMMARY AS (SELECT SE.BUYER_ID, MAX(CASE WHEN SE.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8, MAX(CASE WHEN SE.PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IPHONE FROM SALES_EXPANDED AS SE GROUP BY SE.BUYER_ID) SELECT BUYER_ID FROM SUMMARY WHERE IPHONE = 0 AND S8 = 1;

/*
Prediction Result:
(None,)
*/