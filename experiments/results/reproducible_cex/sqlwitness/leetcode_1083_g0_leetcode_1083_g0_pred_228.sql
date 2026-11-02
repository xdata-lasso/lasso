-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'S8', NULL), (0, 'S8', NULL), (2, NULL, NULL), (3, 'default1', NULL), (4, NULL, NULL), (5, 'default1', 1), (6, NULL, 1), (7, 'default2', 1), (8, NULL, 1), (9, 'S8', NULL), (10, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 1, 1, '2023-01-01', 1, NULL), (9, NULL, 1, NULL, 1, NULL), (8, 0, 1, '2023-01-01', NULL, NULL), (3, NULL, 1, '2023-01-01', 1, 1), (10, 1, 1, '2023-01-01', NULL, 1), (9, NULL, NULL, '2023-01-01', NULL, NULL), (9, 1, 1, '2023-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(1,)
(None,)
*/

-- Prediction Query
WITH S8 AS (SELECT DISTINCT (SALES.BUYER_ID) AS BUYER FROM SALES JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8'), IPHONE AS (SELECT DISTINCT (SALES.BUYER_ID) AS BUYER FROM SALES JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone') SELECT DISTINCT (BUYER_ID) FROM SALES WHERE BUYER_ID IN (SELECT * FROM S8) AND NOT BUYER_ID IN (SELECT * FROM IPHONE);

/*
Prediction Result:
(1,)
*/