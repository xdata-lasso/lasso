-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'default1', NULL), (0, 'S8', NULL), (1, NULL, 1), (2, 'default2', 1), (3, 'iPhone', NULL), (4, 'default2', NULL), (5, NULL, 1), (6, 'default2', 1), (7, 'default2', 1), (8, 'default2', 1), (9, 'default2', NULL), (10, NULL, NULL), (11, 'S8', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (11, 0, 1, '2023-01-01', NULL, NULL), (0, -1, NULL, '2023-01-01', NULL, 1), (8, 1, -1, '2023-01-02', NULL, NULL), (9, -1, 0, NULL, NULL, NULL), (2, NULL, 1, '2023-01-01', 1, 1), (1, 1, 1, '2023-01-02', NULL, NULL), (10, 1, 1, NULL, NULL, NULL), (1, -1, 0, '2023-01-02', NULL, NULL), (2, -1, 0, '2023-01-01', 1, 1), (3, 1, -1, '2023-01-01', 1, 1), (2, 1, 0, '2023-01-02', NULL, 1), (9, 0, -1, NULL, 1, 1), (8, 0, NULL, '2023-01-01', NULL, NULL), (8, 1, 1, '2023-01-01', 1, NULL), (8, 0, NULL, NULL, 1, NULL), (2, 0, 1, '2023-01-01', NULL, 1), (9, 1, 1, '2023-01-02', 1, NULL), (7, 1, 1, '2023-01-02', NULL, 1), (4, NULL, -1, '2023-01-01', 1, NULL), (10, 0, -1, '2023-01-01', 1, NULL), (2, -1, NULL, NULL, 1, NULL), (2, 1, NULL, '2023-01-02', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT BUYER_ID FROM PRODUCT JOIN SALES ON PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID GROUP BY BUYER_ID HAVING SUM(PRODUCT_NAME = 'S8') > 0 AND SUM(PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(None,)
(1,)
*/