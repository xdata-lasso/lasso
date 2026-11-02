-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'iPhone', 1), (2, 'default1', 1), (-1, 'iPhone', NULL), (0, 'S8', 2), (3, 'default1', NULL), (4, 'S8', 1), (5, 'iPhone', 2), (6, 'default1', NULL), (7, 'iPhone', 1), (8, 'iPhone', 2), (9, 'default1', NULL), (10, 'S8', NULL), (11, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, -1, 0, '2023-01-02', 1, 1), (8, NULL, NULL, '2023-01-01', 2, 1), (4, 2, NULL, '2023-01-01', 1, NULL), (8, NULL, 1, '2023-01-01', 1, 1), (7, 1, NULL, NULL, 1, NULL), (10, 1, NULL, '2023-01-02', NULL, 1), (5, 0, 2, '2023-01-02', 2, 1), (7, 1, -1, '2023-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH TEMP AS (SELECT S.BUYER_ID, SUM(CASE WHEN P.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8_FLAG, SUM(CASE WHEN P.PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IPHONE_FLAG FROM SALES AS S JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY S.BUYER_ID) SELECT DISTINCT BUYER_ID FROM TEMP WHERE S8_FLAG > 0 AND IPHONE_FLAG = 0;

/*
Prediction Result:
(0,)
*/