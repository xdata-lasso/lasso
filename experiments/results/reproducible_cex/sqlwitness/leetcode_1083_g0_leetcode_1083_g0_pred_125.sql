-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'S8', 2), (1, 'iPhone', NULL), (0, 'iPhone', NULL), (-1, 'S8', NULL), (3, 'default1', 2), (4, NULL, NULL), (5, 'default2', 1), (6, 'iPhone', 2), (7, 'default2', 1), (8, 'S8', 2), (9, 'default1', NULL), (10, 'default2', 2), (11, 'default2', 2), (12, 'S8', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 0, 1, '2023-01-01', NULL, NULL), (-1, 0, NULL, '2023-01-02', 2, 2), (12, NULL, 2, '2023-01-01', NULL, NULL), (3, 1, 1, '2023-01-02', 2, 1), (8, NULL, 2, '2023-01-02', 2, 1), (12, 1, 2, NULL, 1, 1), (2, 1, 1, '2023-01-02', NULL, 1), (NULL, 1, 1, NULL, NULL, 2), (0, NULL, 2, '2023-01-02', NULL, 1), (6, 0, NULL, NULL, 2, 1), (-1, 2, NULL, NULL, NULL, 1), (9, NULL, -1, '2023-01-01', 1, NULL), (10, 0, NULL, '2023-01-01', NULL, 1), (2, -1, 0, '2023-01-01', 2, NULL), (0, 1, 1, '2023-01-02', 1, 1), (6, 0, 2, '2023-01-02', NULL, NULL), (7, 2, NULL, NULL, 2, NULL), (0, 0, 2, '2023-01-01', 2, 1), (8, 1, -1, '2023-01-02', 2, 2), (-1, 0, 1, '2023-01-01', 1, NULL), (9, NULL, 1, NULL, NULL, 2), (7, -1, NULL, '2023-01-01', NULL, 2), (12, 1, 1, '2023-01-02', 1, 2), (12, NULL, -1, '2023-01-01', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM SALES JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID GROUP BY BUYER_ID HAVING SUM(IIF(PRODUCT_NAME = 'S8', 1, 0)) >= 1 AND SUM(IIF(PRODUCT_NAME = 'iPhone', 1, 0)) = 0;

/*
Prediction Result:
(-1,)
(0,)
*/