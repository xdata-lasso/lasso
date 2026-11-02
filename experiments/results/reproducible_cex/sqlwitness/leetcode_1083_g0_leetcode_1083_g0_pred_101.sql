-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, NULL), (0, 'default2', NULL), (2, 'default1', NULL), (3, 'default1', NULL), (4, NULL, 1), (5, 'default1', 1), (6, 'default1', 1), (7, NULL, NULL), (8, 'default2', NULL), (9, 'default2', NULL), (10, NULL, 1), (11, 'default2', 1), (12, 'iPhone', 1), (13, 'default2', NULL), (14, 'default2', NULL), (15, 'S8', NULL), (16, 'iPhone', 1), (17, 'S8', 1), (18, 'S8', NULL), (19, 'iPhone', NULL), (20, 'default1', NULL), (21, 'default1', NULL), (22, 'S8', NULL), (23, 'S8', NULL), (24, NULL, NULL), (25, 'iPhone', NULL), (26, 'default1', NULL), (27, 'default2', 1), (28, NULL, NULL), (29, 'iPhone', 1), (30, 'S8', 1), (31, 'S8', 1), (32, 'iPhone', 1), (33, 'S8', 1), (34, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (17, 0, NULL, '2023-01-01', 1, 1), (34, 1, 1, NULL, NULL, 1), (18, 1, NULL, NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(None,)
*/

-- Prediction Query
WITH TEMP AS (SELECT * FROM PRODUCT AS P JOIN SALES AS S USING (PRODUCT_ID)) SELECT DISTINCT BUYER_ID FROM SALES WHERE BUYER_ID IN (SELECT BUYER_ID FROM TEMP WHERE PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT BUYER_ID FROM TEMP WHERE PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/