-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, 1), (1, 'S8', NULL), (2, 'default1', 1), (3, 'iPhone', NULL), (4, NULL, NULL), (5, 'iPhone', NULL), (6, 'default2', 1), (7, 'iPhone', NULL), (8, NULL, 1), (9, 'S8', 1), (10, 'default1', NULL), (11, 'default2', NULL), (12, 'iPhone', NULL), (13, 'iPhone', NULL), (14, 'iPhone', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (8, NULL, 0, NULL, NULL, NULL), (4, NULL, 0, '2023-01-01', 1, 1), (6, NULL, 1, '2023-01-01', NULL, 1), (8, 1, NULL, '2023-01-02', NULL, 1), (1, NULL, 0, '2023-01-02', NULL, NULL), (2, 0, 1, '2023-01-01', 1, NULL), (2, 1, 1, '2023-01-02', NULL, NULL), (10, 0, NULL, '2023-01-02', NULL, 1), (0, 1, 0, NULL, 1, 1), (5, NULL, NULL, '2023-01-01', NULL, NULL), (10, 1, 1, '2023-01-01', 1, 1), (3, NULL, NULL, '2023-01-01', 1, NULL), (1, 0, 0, '2023-01-01', 1, 1), (8, 1, 1, NULL, NULL, NULL), (13, 0, 0, '2023-01-02', NULL, NULL), (13, 0, 1, '2023-01-01', NULL, NULL), (NULL, 0, NULL, '2023-01-02', NULL, NULL), (6, 1, NULL, NULL, NULL, NULL), (7, NULL, NULL, NULL, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT BUYER_ID FROM SALES WHERE PRODUCT_ID = (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'S8')), DEMO AS (SELECT DISTINCT BUYER_ID FROM SALES WHERE PRODUCT_ID = (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone')) SELECT CTE.BUYER_ID FROM CTE LEFT JOIN DEMO ON CTE.BUYER_ID = DEMO.BUYER_ID WHERE DEMO.BUYER_ID IS NULL;

/*
Prediction Result:
(0,)
*/