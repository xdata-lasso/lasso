-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', 1), (0, 'default1', NULL), (2, NULL, 1), (3, 'iPhone', NULL), (4, 'default2', 1), (5, 'iPhone', NULL), (6, 'default1', 1), (7, 'S8', NULL), (8, 'default1', 1), (9, 'S8', 1), (10, 'default2', 1), (11, 'default1', 1), (12, 'default2', NULL), (13, 'iPhone', NULL), (14, NULL, NULL), (15, 'S8', NULL), (16, 'default2', NULL), (17, 'S8', 1), (18, NULL, NULL), (19, NULL, NULL), (20, 'default2', NULL), (21, 'default2', 1), (22, 'iPhone', 1), (23, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, NULL, 0, '2023-01-01', NULL, 1), (23, 1, 1, NULL, 1, NULL), (15, 1, NULL, '2023-01-02', NULL, 1), (18, 0, 0, '2023-01-01', 1, 1), (14, NULL, 1, '2023-01-02', NULL, 1), (0, NULL, 0, '2023-01-01', NULL, NULL), (17, NULL, 0, '2023-01-02', NULL, 1), (23, 1, 1, NULL, 1, 1), (19, 1, 0, NULL, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(None,)
(0,)
*/

-- Prediction Query
WITH CTE AS (SELECT A.SELLER_ID, A.PRODUCT_ID, B.PRODUCT_NAME, B.UNIT_PRICE, A.BUYER_ID, A.SALE_DATE, A.QUANTITY, A.PRICE FROM SALES AS A JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID) SELECT DISTINCT BUYER_ID FROM CTE WHERE BUYER_ID IN (SELECT BUYER_ID FROM CTE WHERE PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT BUYER_ID FROM CTE WHERE PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
(0,)
*/