-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'S8', NULL), (1, 'default1', 1), (2, 'default2', 2), (0, 'iPhone', 2), (3, 'default2', 2), (4, 'default2', NULL), (5, 'S8', 1), (6, 'iPhone', 1), (7, NULL, NULL), (8, 'default2', NULL), (9, NULL, NULL), (10, 'iPhone', NULL), (11, NULL, NULL), (12, 'default2', NULL), (13, 'S8', NULL), (14, NULL, NULL), (15, 'S8', 2), (16, NULL, 2), (17, 'iPhone', 2), (18, 'S8', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (13, -1, 0, '2023-01-01', 2, 1), (10, 2, NULL, '2023-01-02', 2, 2), (NULL, 0, NULL, '2023-01-02', 2, 1), (4, 0, 0, '2023-01-02', 2, NULL), (6, -1, 1, '2023-01-01', 2, NULL), (NULL, NULL, -1, '2023-01-02', 2, NULL), (3, 0, 2, NULL, 1, NULL), (11, 1, -1, '2023-01-02', 2, NULL), (17, 1, -1, '2023-01-01', 2, NULL), (9, 1, NULL, '2023-01-02', 2, 2), (17, 0, 1, '2023-01-01', 2, 2), (10, 0, 1, '2023-01-01', 1, 1), (14, 2, NULL, NULL, NULL, 2), (7, NULL, -1, '2023-01-01', 2, NULL), (3, 1, 0, '2023-01-01', NULL, 2), (18, NULL, 0, NULL, 1, 2), (1, 1, 2, NULL, 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT S.*, CASE WHEN P.PRODUCT_NAME = 'S8' THEN 0 WHEN P.PRODUCT_NAME = 'iPhone' THEN 1 ELSE NULL END AS N_ID FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID) SELECT DISTINCT BUYER_ID FROM CTE WHERE NOT N_ID IS NULL GROUP BY BUYER_ID HAVING SUM(N_ID) = 0;

/*
Prediction Result:
(0,)
*/