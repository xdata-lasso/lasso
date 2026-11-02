-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, NULL), (1, 'S8', NULL), (2, 'default2', 1), (3, NULL, NULL), (4, 'default2', 1), (5, NULL, 1), (6, 'S8', NULL), (7, 'S8', NULL), (8, 'S8', NULL), (9, NULL, 1), (10, 'default1', 1), (11, NULL, 1), (12, 'default2', 1), (13, NULL, 1), (14, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (11, NULL, 0, '2023-01-01', NULL, 1), (14, NULL, NULL, '2023-01-01', 1, 1), (4, 1, NULL, '2023-01-02', NULL, 1), (12, NULL, 0, '2023-01-01', 1, NULL), (1, 0, 0, '2023-01-01', 1, NULL), (5, 0, 1, '2023-01-01', 1, 1), (NULL, NULL, NULL, '2023-01-01', 1, 1), (6, 0, NULL, '2023-01-02', NULL, 1), (2, 0, 1, '2023-01-02', NULL, NULL), (0, 0, 1, NULL, 1, 1), (14, NULL, NULL, '2023-01-02', NULL, 1), (10, 0, 1, NULL, 1, 1), (10, 1, NULL, '2023-01-02', NULL, 1), (10, 1, NULL, '2023-01-02', NULL, 1), (4, NULL, NULL, '2023-01-01', NULL, NULL), (0, 0, 0, '2023-01-02', 1, NULL), (10, 1, 1, '2023-01-02', 1, 1), (5, 1, 1, NULL, NULL, NULL), (3, 1, 1, '2023-01-01', NULL, NULL), (2, 0, NULL, '2023-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(0,)
(None,)
*/

-- Prediction Query
WITH T1 AS (SELECT SALES.BUYER_ID, PRODUCT.PRODUCT_NAME FROM SALES LEFT OUTER JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE (PRODUCT_NAME = 'S8') OR (PRODUCT_NAME = 'iPhone')), T2 AS (SELECT BUYER_ID FROM T1 WHERE PRODUCT_NAME = 'S8'), T3 AS (SELECT BUYER_ID FROM T1 WHERE PRODUCT_NAME = 'iPhone') SELECT DISTINCT BUYER_ID FROM T2 WHERE NOT BUYER_ID IN (SELECT * FROM T3) ORDER BY BUYER_ID;

/*
Prediction Result:
(None,)
(0,)
*/