-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'S8', 1), (1, 'default2', 1), (2, 'S8', 1), (3, NULL, 1), (4, 'default2', 1), (5, 'default1', 1), (6, 'default1', 1), (7, 'default2', 1), (8, 'S8', 1), (9, 'default2', 1), (10, 'default2', NULL), (11, 'S8', 1), (12, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (12, NULL, 0, NULL, 1, NULL), (10, 1, 0, NULL, NULL, 1), (12, NULL, 1, '2023-01-01', 1, NULL), (11, 0, 0, '2023-01-02', 1, 1), (2, 0, NULL, NULL, 1, NULL), (3, NULL, NULL, NULL, 1, 1), (7, 0, 0, '2023-01-02', NULL, NULL), (0, NULL, 1, '2023-01-02', NULL, 1), (9, NULL, NULL, '2023-01-02', 1, NULL), (2, 0, 0, NULL, NULL, 1), (NULL, NULL, 0, '2023-01-02', 1, 1), (0, NULL, 0, '2023-01-02', 1, 1), (10, 1, NULL, '2023-01-02', NULL, 1), (6, 1, 1, '2023-01-02', 1, 1), (7, NULL, 0, '2023-01-01', 1, NULL), (NULL, 1, 1, NULL, NULL, 1), (3, 1, 0, '2023-01-01', 1, 1), (11, NULL, 0, NULL, NULL, 1), (3, 1, 1, '2023-01-02', NULL, 1), (4, 1, NULL, '2023-01-02', 1, NULL), (0, NULL, NULL, '2023-01-02', 1, 1), (2, 0, NULL, NULL, 1, NULL), (11, 0, NULL, '2023-01-01', NULL, 1), (3, 1, 0, '2023-01-01', 1, NULL), (11, 0, NULL, '2023-01-01', NULL, NULL), (NULL, 0, 1, '2023-01-01', NULL, NULL), (9, NULL, 1, '2023-01-02', NULL, 1), (0, 0, 1, NULL, 1, 1), (6, 0, NULL, '2023-01-02', NULL, 1), (6, NULL, 0, '2023-01-02', 1, 1), (1, 0, 1, '2023-01-02', 1, NULL), (4, 1, 0, NULL, NULL, NULL), (10, NULL, NULL, NULL, 1, NULL), (3, NULL, 0, NULL, NULL, NULL), (5, 0, 0, '2023-01-01', 1, NULL), (1, 1, NULL, '2023-01-02', 1, 1), (8, 0, NULL, '2023-01-02', NULL, 1), (1, NULL, 0, NULL, NULL, 1), (6, 0, NULL, '2023-01-02', 1, NULL), (8, 0, 1, '2023-01-02', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(0,)
(None,)
(1,)
*/

-- Prediction Query
WITH CTE AS (SELECT S.BUYER_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID) SELECT DISTINCT BUYER_ID FROM CTE WHERE BUYER_ID IN (SELECT BUYER_ID FROM CTE WHERE PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT BUYER_ID FROM CTE WHERE PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
(0,)
(1,)
*/