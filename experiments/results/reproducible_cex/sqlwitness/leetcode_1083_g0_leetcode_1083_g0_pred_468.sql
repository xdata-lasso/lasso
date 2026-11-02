-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'S8', NULL), (1, NULL, 1), (2, NULL, NULL), (3, 'S8', NULL), (4, NULL, 1), (5, 'S8', NULL), (6, 'iPhone', NULL), (7, 'default2', NULL), (8, 'iPhone', 1), (9, 'iPhone', NULL), (10, 'default2', 1), (11, 'default2', 1), (12, NULL, 1), (13, NULL, NULL), (14, 'S8', NULL), (15, 'S8', 1), (16, 'S8', 1), (17, 'default1', 1), (18, NULL, NULL), (19, 'iPhone', 1), (20, 'default2', NULL), (21, 'iPhone', NULL), (22, 'S8', 1), (23, 'iPhone', NULL), (24, NULL, 1), (25, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (17, 0, 0, '2023-01-01', 1, NULL), (3, 1, NULL, NULL, NULL, 1), (4, NULL, 1, NULL, NULL, NULL), (22, 1, NULL, '2023-01-01', 1, 1), (NULL, 1, 0, '2023-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(None,)
*/

-- Prediction Query
WITH CTE AS (SELECT SALES.BUYER_ID, PRODUCT.* FROM SALES JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID) SELECT DISTINCT BUYER_ID FROM SALES WHERE BUYER_ID IN (SELECT BUYER_ID FROM CTE WHERE PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT BUYER_ID FROM CTE WHERE PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/