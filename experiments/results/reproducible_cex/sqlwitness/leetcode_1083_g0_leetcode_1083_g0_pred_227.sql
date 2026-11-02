-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, 1), (1, 'iPhone', 1), (2, 'default2', NULL), (3, 'S8', NULL), (4, 'iPhone', 1), (5, NULL, NULL), (6, 'default1', NULL), (7, 'iPhone', NULL), (8, NULL, 1), (9, 'default1', NULL), (10, NULL, NULL), (11, 'default1', 1), (12, 'iPhone', NULL), (13, 'default2', 1), (14, 'default2', 1), (15, 'S8', NULL), (16, 'S8', NULL), (17, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (15, 0, 1, '2023-01-02', NULL, NULL), (4, NULL, NULL, NULL, 1, 1), (15, 0, 0, '2023-01-02', 1, NULL), (9, 0, 0, NULL, NULL, 1), (14, NULL, NULL, '2023-01-02', 1, NULL), (15, 1, 1, '2023-01-02', 1, 1), (9, 1, NULL, '2023-01-01', NULL, 1), (5, 1, NULL, NULL, 1, 1), (10, NULL, 0, '2023-01-02', 1, 1), (4, 1, NULL, NULL, 1, NULL), (13, 0, NULL, '2023-01-01', 1, NULL), (17, 0, NULL, '2023-01-02', 1, 1), (NULL, 1, 0, '2023-01-02', 1, 1), (4, 0, 0, '2023-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH S8 AS (SELECT BUYER_ID FROM SALES INNER JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8'), IPHONE AS (SELECT BUYER_ID FROM SALES INNER JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone') SELECT DISTINCT S8.BUYER_ID FROM S8 LEFT JOIN IPHONE ON S8.BUYER_ID = IPHONE.BUYER_ID WHERE IPHONE.BUYER_ID IS NULL;

/*
Prediction Result:
(1,)
*/