-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default2', 1), (0, 'iPhone', NULL), (2, 'default2', NULL), (3, 'S8', 1), (4, 'default2', NULL), (5, 'default1', NULL), (6, 'default2', 1), (7, 'S8', NULL), (8, 'iPhone', NULL), (9, NULL, NULL), (10, 'default1', 1), (11, NULL, 1), (12, 'default1', 1), (13, 'S8', NULL), (14, 'S8', NULL), (15, 'default1', 1), (16, 'S8', NULL), (17, 'S8', NULL), (18, 'iPhone', NULL), (19, 'default2', NULL), (20, 'S8', 1), (21, 'iPhone', NULL), (22, NULL, 1), (23, 'iPhone', NULL), (24, 'S8', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 1, 1, '2023-01-02', NULL, NULL), (NULL, NULL, 1, NULL, NULL, NULL), (12, 1, NULL, NULL, NULL, NULL), (13, 1, NULL, NULL, 1, NULL), (13, NULL, NULL, '2023-01-01', NULL, NULL), (2, 0, 0, '2023-01-02', NULL, NULL), (22, NULL, 1, '2023-01-01', 1, NULL), (4, NULL, NULL, NULL, NULL, NULL), (11, 0, 0, '2023-01-02', NULL, NULL), (NULL, 0, NULL, '2023-01-02', 1, 1), (18, 1, 1, '2023-01-01', NULL, NULL), (15, NULL, NULL, NULL, 1, NULL), (6, NULL, 0, '2023-01-01', 1, NULL), (5, 1, NULL, NULL, 1, NULL), (19, 0, NULL, '2023-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH CTE1 AS (SELECT S.BUYER_ID, P.PRODUCT_NAME FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE PRODUCT_NAME = 'S8'), CTE2 AS (SELECT S.BUYER_ID AS OTHER, P.PRODUCT_NAME FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone') SELECT BUYER_ID FROM CTE1 AS C1 LEFT JOIN CTE2 AS C2 ON C1.BUYER_ID = C2.OTHER WHERE OTHER IS NULL GROUP BY BUYER_ID;

/*
Prediction Result:
(None,)
*/