-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', 1), (2, 'default2', 1), (-1, NULL, 2), (0, NULL, NULL), (3, 'iPhone', NULL), (4, NULL, NULL), (5, 'S8', NULL), (6, 'iPhone', 2), (7, 'iPhone', NULL), (8, 'default1', NULL), (9, NULL, NULL), (10, NULL, 1), (11, 'S8', 2), (12, 'iPhone', 1), (13, NULL, NULL), (14, 'default1', 1), (15, 'S8', 2), (16, NULL, NULL), (17, 'S8', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (17, 2, NULL, '2023-01-02', 1, 1), (17, 2, 1, NULL, NULL, NULL), (0, -1, 0, '2023-01-01', 2, 2), (12, NULL, 0, '2023-01-02', NULL, NULL), (12, 2, NULL, '2023-01-01', 2, 1), (14, 1, 0, NULL, NULL, NULL), (3, NULL, -1, NULL, 1, NULL), (12, NULL, 0, NULL, NULL, 1), (9, NULL, 2, '2023-01-01', NULL, 1), (9, NULL, 1, NULL, NULL, 2), (-1, 2, -1, '2023-01-01', NULL, 2), (9, NULL, NULL, '2023-01-01', 1, 2), (8, 1, 1, '2023-01-01', NULL, 1), (NULL, -1, -1, NULL, 1, 2), (15, -1, -1, '2023-01-01', 2, 1), (8, 2, -1, '2023-01-02', 1, 2), (9, 2, -1, NULL, NULL, 1), (0, -1, 2, '2023-01-01', NULL, NULL), (5, 0, 2, '2023-01-01', NULL, 2), (17, 2, 0, '2023-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.BUYER_ID FROM SALES AS T1 INNER JOIN PRODUCT AS T2 ON T1.PRODUCT_ID = T2.PRODUCT_ID GROUP BY T1.BUYER_ID HAVING SUM(CASE WHEN T2.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN T2.PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(1,)
(2,)
*/