-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'IPHONE ', 1), (0, NULL, 1), (2, 'default1', 1), (3, 'S8', NULL), (4, 'iPhone', 1), (5, 'default2', 1), (6, 'default1', 1), (7, 'default1', NULL), (8, 'default1', NULL), (9, 'default1', 1), (10, 'IPHONE ', 1), (11, 'iPhone', NULL), (12, 'S8', 1), (13, 'iPhone', 1), (14, 'default2', 1), (15, 'iPhone', NULL), (16, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 1, 0, NULL, 1, NULL), (5, 0, NULL, '2023-01-01', NULL, 1), (9, NULL, NULL, NULL, 1, 1), (2, 0, 1, '2023-01-02', NULL, NULL), (8, NULL, NULL, '2023-01-02', NULL, 1), (2, 1, 1, NULL, NULL, 1), (12, 1, 1, '2023-01-01', NULL, 1), (1, NULL, 0, NULL, NULL, 1), (1, 0, 1, NULL, 1, 1), (7, 1, 0, '2023-01-01', 1, NULL), (12, 1, 0, '2023-01-02', 1, 1), (2, 1, 0, NULL, NULL, 1), (13, NULL, 0, '2023-01-01', NULL, NULL), (10, 0, 1, NULL, 1, NULL), (8, 0, NULL, NULL, NULL, NULL), (3, 1, NULL, '2023-01-02', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8' AND NOT BUYER_ID IN (SELECT S.BUYER_ID FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'IPHONE ');

/*
Prediction Result:
*/