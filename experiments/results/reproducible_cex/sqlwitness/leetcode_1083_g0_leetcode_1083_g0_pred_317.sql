-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default2', NULL), (0, NULL, 1), (2, 'default2', 1), (3, 'iPhone', 1), (4, NULL, 1), (5, NULL, NULL), (6, 'default1', NULL), (7, 'S8', 1), (8, 'iPhone', NULL), (9, 'iPhone', NULL), (10, 'default1', NULL), (11, 'S8', NULL), (12, 'default1', NULL), (13, NULL, NULL), (14, NULL, 1), (15, NULL, 1), (16, NULL, NULL), (17, NULL, 1), (18, 'iPhone', 1), (19, 'default2', NULL), (20, NULL, 1), (21, 'default2', 1), (22, 'default2', 1), (23, 'default2', NULL), (24, 'default1', 1), (25, 'iPhone', NULL), (26, 'default1', 1), (27, 'default2', NULL), (28, 'iPhone', 1), (29, 'iPhone', 1), (30, 'iPhone', NULL), (31, 'default2', 1), (32, 'S8', NULL), (33, 'default2', 1), (34, 'S8', NULL), (35, 'default1', 1), (36, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 1, 1, NULL, 1, NULL), (0, 0, NULL, '2023-01-02', 1, 1), (24, 1, NULL, NULL, 1, 1), (15, 1, 1, '2023-01-01', NULL, NULL), (17, NULL, 1, '2023-01-02', NULL, 1), (2, 1, NULL, NULL, NULL, 1), (32, NULL, 1, NULL, NULL, 1), (9, NULL, 1, '2023-01-02', NULL, 1), (30, 0, 0, '2023-01-02', 1, 1), (32, 0, 0, '2023-01-02', 1, NULL), (2, NULL, 0, '2023-01-01', NULL, NULL), (29, 0, 0, '2023-01-01', 1, NULL), (10, NULL, 1, NULL, NULL, NULL), (18, NULL, 1, '2023-01-02', 1, 1), (32, 1, 0, '2023-01-01', NULL, 1), (NULL, 1, 0, NULL, 1, NULL), (33, NULL, 1, '2023-01-02', NULL, NULL), (1, NULL, 0, '2023-01-02', NULL, NULL), (0, 0, 1, NULL, 1, 1), (2, 1, 1, '2023-01-01', NULL, 1), (31, 1, 1, '2023-01-02', NULL, 1), (4, NULL, 1, NULL, NULL, 1), (10, 0, NULL, '2023-01-01', 1, 1), (36, 0, NULL, '2023-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES AS S INNER JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT BUYER_ID IN (SELECT BUYER_ID FROM SALES WHERE PRODUCT_ID = (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone'));

/*
Prediction Result:
(0,)
*/