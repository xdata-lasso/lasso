-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'iPhone', NULL), (0, 'iPhone', 1), (2, 'default1', 1), (3, 'S8', 1), (4, 'iPhone', NULL), (5, 'iPhone', NULL), (6, 'default2', NULL), (7, 'S8', 1), (8, 'iPhone', NULL), (9, 'iPhone', 1), (10, 'default2', NULL), (11, 'default1', 1), (12, 'default1', 1), (13, 'iPhone', 1), (14, 'iPhone', 1), (15, 'iPhone', 1), (16, 'default1', 1), (17, NULL, 1), (18, 'S8', NULL), (19, 'default1', NULL), (20, 'S8', 1), (21, 'iPhone', 1), (22, 'S8', NULL), (23, 'default2', NULL), (24, 'S8', 1), (25, 'iPhone', 1), (26, 'iPhone', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (25, 0, NULL, '2023-01-01', NULL, 1), (7, 0, NULL, '2023-01-02', NULL, 1), (23, 1, 0, NULL, 1, 1), (23, 0, NULL, '2023-01-02', NULL, NULL), (NULL, 1, NULL, '2023-01-01', 1, 1), (22, NULL, NULL, NULL, 1, 1), (6, 0, 1, '2023-01-02', 1, 1), (17, 1, 1, '2023-01-02', 1, NULL), (25, NULL, NULL, '2023-01-01', NULL, NULL), (3, 0, 1, '2023-01-01', NULL, 1), (22, NULL, 0, '2023-01-01', NULL, NULL), (5, NULL, 1, NULL, NULL, NULL), (12, NULL, 0, '2023-01-02', NULL, 1), (25, 1, NULL, '2023-01-02', NULL, 1), (5, 0, 1, '2023-01-02', NULL, 1), (19, NULL, 0, '2023-01-02', 1, NULL), (24, NULL, 1, '2023-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH CTE1 AS (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'S8'), CTE2 AS (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone'), CTE3 AS (SELECT DISTINCT BUYER_ID FROM SALES AS S JOIN CTE1 ON CTE1.PRODUCT_ID = S.PRODUCT_ID), CTE4 AS (SELECT DISTINCT BUYER_ID FROM SALES AS S JOIN CTE2 ON CTE2.PRODUCT_ID = S.PRODUCT_ID) SELECT CTE3.BUYER_ID FROM CTE3 LEFT JOIN CTE4 ON CTE3.BUYER_ID = CTE4.BUYER_ID WHERE CTE4.BUYER_ID IS NULL;

/*
Prediction Result:
(None,)
(0,)
*/