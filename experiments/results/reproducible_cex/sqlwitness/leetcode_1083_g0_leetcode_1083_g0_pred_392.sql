-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'default2', 2), (1, 'default2', 2), (2, 'default2', 1), (0, 'default1', 1), (3, 'iPhone', 2), (4, NULL, 2), (5, 'default2', NULL), (6, 'S8', 1), (7, 'iPhone', NULL), (8, NULL, NULL), (9, NULL, NULL), (10, 'default1', 2), (11, NULL, 2), (12, NULL, 2), (13, 'S8', 1), (14, 'S8', NULL), (15, 'S8', NULL), (16, NULL, 1), (17, 'S8', NULL), (18, NULL, NULL), (19, 'iPhone', NULL), (20, 'S8', 1), (21, 'default1', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (16, 2, -1, '2023-01-01', 1, NULL), (21, 2, NULL, NULL, NULL, 2), (20, NULL, -1, '2023-01-02', NULL, 1), (7, NULL, 2, NULL, 1, NULL), (NULL, 1, NULL, '2023-01-01', NULL, 2), (-1, 2, NULL, NULL, NULL, 2), (10, NULL, NULL, '2023-01-01', NULL, NULL), (11, 0, 2, '2023-01-02', 2, NULL), (21, 1, 0, '2023-01-02', 2, NULL), (15, -1, 1, NULL, NULL, 2), (6, NULL, NULL, '2023-01-02', NULL, NULL), (19, 1, NULL, NULL, 1, 1), (16, 2, -1, '2023-01-02', 2, 1), (NULL, 0, 0, '2023-01-02', 2, 2), (10, -1, 1, NULL, 1, 2), (15, NULL, NULL, '2023-01-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT A.BUYER_ID FROM SALES AS A INNER JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID GROUP BY A.BUYER_ID HAVING SUM(IIF(B.PRODUCT_NAME = 'S8', 1, 0)) > 0 AND SUM(IIF(B.PRODUCT_NAME = 'iPhone', 1, 0)) = 0;

/*
Prediction Result:
(-1,)
(1,)
*/