-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'S8', 1), (0, 'default1', NULL), (2, 'S8', NULL), (3, 'S8', 1), (4, 'iPhone', 1), (5, 'iPhone', NULL), (6, 'default1', NULL), (7, 'default2', NULL), (8, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (8, NULL, 0, '2023-01-01', 1, NULL), (6, 1, NULL, '2023-01-01', NULL, 1), (NULL, NULL, 1, NULL, 1, NULL), (6, 0, 1, '2023-01-02', NULL, 1), (1, NULL, 1, NULL, 1, 1), (7, 0, NULL, '2023-01-01', NULL, 1), (6, 0, 0, '2023-01-02', 1, 1), (3, 1, 1, '2023-01-02', NULL, NULL), (4, 0, NULL, '2023-01-01', 1, 1), (1, 1, 1, '2023-01-01', 1, NULL), (0, 0, 1, '2023-01-02', NULL, 1), (7, 0, 0, '2023-01-02', NULL, NULL), (3, 1, 1, '2023-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH S8 AS (SELECT A.BUYER_ID, A.PRODUCT_ID, B.PRODUCT_NAME FROM SALES AS A JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID AND B.PRODUCT_NAME = 'S8'), IP AS (SELECT A.BUYER_ID, A.PRODUCT_ID, B.PRODUCT_NAME FROM SALES AS A JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID AND B.PRODUCT_NAME = 'iPhone'), S8_B AS (SELECT DISTINCT (BUYER_ID) AS BUYER_ID FROM S8), IP_B AS (SELECT DISTINCT (BUYER_ID) AS BUYER_ID FROM IP) SELECT A.BUYER_ID FROM S8_B AS A LEFT JOIN IP_B AS B ON A.BUYER_ID = B.BUYER_ID WHERE B.BUYER_ID IS NULL;

/*
Prediction Result:
(1,)
*/