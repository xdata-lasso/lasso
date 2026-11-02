-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'iPhone', 2), (0, 'iPhone', 1), (2, 'default1', 2), (1, 'default1', NULL), (3, NULL, 2), (4, 'S8', NULL), (5, 'iPhone', 2), (6, 'default2', NULL), (7, 'S8', NULL), (8, NULL, NULL), (9, 'default1', 1), (10, 'S8', NULL), (11, NULL, 1), (12, 'S8', 2), (13, 'iPhone', NULL), (14, NULL, 2), (15, 'iPhone', NULL), (16, 'default2', NULL), (17, 'iPhone', 2), (18, 'default2', 1), (19, 'S8', NULL), (20, 'default2', NULL), (21, 'default2', 1), (22, 'default2', NULL), (23, 'S8', 2), (24, 'default1', NULL), (25, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (19, 0, 0, '2023-01-01', 2, 2), (-1, 0, 2, NULL, NULL, NULL), (21, 0, -1, NULL, 2, NULL), (8, NULL, -1, '2023-01-01', 1, 2), (16, -1, 2, '2023-01-02', 1, 1), (10, NULL, 1, '2023-01-02', 2, 1), (2, 1, 0, '2023-01-02', 2, 1), (19, 2, 0, '2023-01-01', NULL, 2), (0, 1, -1, NULL, 1, NULL), (17, 2, NULL, NULL, NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM (SELECT BUYER_ID, SUM(CASE WHEN PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8, SUM(CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IPHONE FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY BUYER_ID) AS X WHERE S8 > 0 AND IPHONE = 0;

/*
Prediction Result:
(0,)
(1,)
*/