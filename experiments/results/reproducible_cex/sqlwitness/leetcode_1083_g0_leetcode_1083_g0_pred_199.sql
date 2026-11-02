-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'S8', 1), (0, 'default2', NULL), (2, 'default1', 1), (3, 'S8', NULL), (4, 'iPhone', NULL), (5, 'S8', 1), (6, 'S8', NULL), (7, NULL, NULL), (8, NULL, NULL), (9, 'default1', 1), (10, NULL, 1), (11, 'default2', NULL), (12, 'default2', NULL), (13, 'S8', 1), (14, 'default2', 1), (15, NULL, 1), (16, 'default2', 1), (17, 'S8', NULL), (18, 'default1', NULL), (19, 'default2', 1), (20, 'default2', NULL), (21, 'S8', 1), (22, 'default2', NULL), (23, 'iPhone', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (19, 0, 0, NULL, NULL, NULL), (22, 0, NULL, '2023-01-01', 1, NULL), (4, 0, 1, '2023-01-02', 1, 1), (12, NULL, NULL, NULL, 1, NULL), (20, 1, 1, '2023-01-01', NULL, 1), (19, NULL, NULL, NULL, NULL, 1), (18, 0, NULL, '2023-01-01', 1, NULL), (11, NULL, NULL, '2023-01-01', 1, 1), (7, 1, 1, '2023-01-01', 1, 1), (17, 1, 1, '2023-01-01', NULL, NULL), (20, 0, 1, NULL, NULL, NULL), (21, 0, 1, '2023-01-02', NULL, NULL), (23, 1, 1, '2023-01-01', 1, NULL), (7, NULL, 1, '2023-01-01', 1, 1), (20, 1, 1, '2023-01-01', 1, 1), (1, NULL, NULL, NULL, 1, 1), (12, NULL, 0, '2023-01-01', NULL, 1), (1, NULL, 0, NULL, 1, NULL), (14, 1, 0, '2023-01-01', NULL, NULL), (NULL, NULL, 1, '2023-01-01', NULL, 1), (0, 0, NULL, NULL, 1, NULL), (NULL, NULL, 1, NULL, 1, 1), (17, 1, 1, NULL, 1, 1), (6, 0, 0, NULL, 1, NULL), (12, NULL, 0, '2023-01-02', 1, 1), (5, NULL, 1, '2023-01-01', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(0,)
*/

-- Prediction Query
WITH BOUGHT_S8 AS (SELECT DISTINCT BUYER_ID, PRODUCT_ID FROM SALES WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'S8')) SELECT BUYER_ID FROM BOUGHT_S8 WHERE NOT BUYER_ID IN (SELECT BUYER_ID FROM SALES WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone'));

/*
Prediction Result:
(0,)
(0,)
*/