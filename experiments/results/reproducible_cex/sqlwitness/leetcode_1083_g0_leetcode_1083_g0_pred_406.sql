-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default2', 1), (0, NULL, 1), (2, 'default1', NULL), (3, 'iPhone', NULL), (4, 'default1', NULL), (5, NULL, NULL), (6, 'iPhone', NULL), (7, 'default2', 1), (8, NULL, 1), (9, 'iPhone', 1), (10, NULL, 1), (11, 'S8', 1), (12, 'iPhone', NULL), (13, 'iPhone', 1), (14, 'default2', 1), (15, 'default2', NULL), (16, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 1, 0, NULL, 1, NULL), (1, NULL, 1, NULL, 1, NULL), (0, NULL, NULL, '2023-01-01', 1, 1), (3, 0, NULL, NULL, NULL, 1), (7, 1, 1, NULL, NULL, NULL), (5, 1, NULL, '2023-01-02', NULL, 1), (15, NULL, NULL, '2023-01-02', NULL, 1), (NULL, NULL, NULL, NULL, NULL, NULL), (0, NULL, 1, NULL, 1, 1), (8, 1, 1, NULL, 1, NULL), (11, 0, NULL, '2023-01-02', 1, 1), (8, 1, NULL, '2023-01-02', NULL, 1), (9, 1, 1, NULL, 1, NULL), (3, 0, 0, '2023-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH S8 AS (SELECT DISTINCT BUYER_ID FROM SALES LEFT JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8'), IPHONE AS (SELECT DISTINCT BUYER_ID FROM SALES LEFT JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone') SELECT S8.BUYER_ID FROM S8 LEFT JOIN IPHONE ON S8.BUYER_ID = IPHONE.BUYER_ID WHERE IPHONE.BUYER_ID IS NULL;

/*
Prediction Result:
(None,)
*/