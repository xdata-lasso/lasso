-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'S8', 1), (0, 'default2', NULL), (-1, NULL, 1), (2, 'default2', NULL), (3, 'default2', 1), (4, 'default1', NULL), (5, 'S8', NULL), (6, 'S8', NULL), (7, NULL, 1), (8, 'default1', 1), (9, 'default2', NULL), (10, 'default2', 1), (11, 'default1', 1), (12, 'iPhone', NULL), (13, 'iPhone', 1), (14, NULL, NULL), (15, 'iPhone', 1), (16, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, -1, -1, '2023-01-02', 1, 1), (13, 1, -1, NULL, 1, 1), (-1, -1, 1, '2023-01-01', NULL, NULL), (11, 1, NULL, '2023-01-02', 1, NULL), (5, 1, -1, '2023-01-01', 1, 1), (15, 0, 1, NULL, NULL, NULL), (-1, NULL, NULL, '2023-01-01', 1, NULL), (3, 0, 1, '2023-01-02', 1, NULL), (15, 1, NULL, '2023-01-02', 1, NULL), (1, 0, 1, '2023-01-01', NULL, 1), (0, 1, 0, '2023-01-02', 1, NULL), (14, 0, 1, '2023-01-01', 1, NULL), (0, 1, 0, '2023-01-02', NULL, NULL), (9, NULL, NULL, '2023-01-01', NULL, 1), (8, 1, NULL, '2023-01-01', NULL, 1), (-1, 0, 0, '2023-01-02', 1, NULL), (8, 0, 0, '2023-01-02', NULL, 1), (0, 0, 1, '2023-01-02', 1, NULL), (14, 1, 1, '2023-01-01', NULL, NULL), (14, NULL, 1, '2023-01-02', 1, 1), (10, NULL, -1, '2023-01-02', NULL, NULL), (14, 1, NULL, NULL, NULL, NULL), (-1, -1, 1, NULL, NULL, NULL), (1, 1, 0, '2023-01-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM SALES JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID GROUP BY BUYER_ID HAVING SUM(PRODUCT_NAME = 'S8') > 0 AND SUM(PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(0,)
*/