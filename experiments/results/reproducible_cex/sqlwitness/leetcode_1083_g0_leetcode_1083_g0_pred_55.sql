-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, 1), (0, 'default2', NULL), (2, 'iPhone', 1), (3, 'S8', 2), (4, 'default2', 1), (5, 'S8', 1), (6, 'S8', 1), (7, 'iPhone', 1), (8, 'default2', 2), (9, 'default1', 1), (10, 'iPhone', 2), (11, 'default1', 1), (12, 'default1', NULL), (13, 'default2', NULL), (14, 'default2', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 1, NULL, '2023-01-01', NULL, 2), (9, 2, 1, '2023-01-01', NULL, 2), (9, NULL, 2, NULL, 1, 2), (5, 0, NULL, '2023-01-01', NULL, NULL), (0, NULL, 1, '2023-01-02', NULL, NULL), (8, 2, NULL, NULL, 2, 1), (NULL, 1, 1, '2023-01-01', 2, NULL), (3, 2, 0, '2023-01-02', 2, 1), (NULL, 1, 0, '2023-01-02', 2, 1), (11, NULL, 0, '2023-01-02', 1, 2), (6, 1, NULL, NULL, 2, 2), (10, 1, 2, '2023-01-02', 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT BUYER_ID FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE PRODUCT_NAME IN ('S8', 'iPhone') GROUP BY BUYER_ID HAVING COUNT(DISTINCT PRODUCT_NAME) = 1 AND MIN(PRODUCT_NAME) = 'S8';

/*
Prediction Result:
(None,)
(0,)
*/