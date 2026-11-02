-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'S8', NULL), (0, 'iPhone', NULL), (-1, 'default1', 2), (1, 'iPhone', 2), (3, 'default2', NULL), (4, 'iPhone', NULL), (5, NULL, 2), (6, 'default2', NULL), (7, NULL, NULL), (8, 'iPhone', 2), (9, 'iPhone', NULL), (10, 'iPhone', 1), (11, 'default1', NULL), (12, NULL, NULL), (13, 'S8', 1), (14, NULL, 1), (15, NULL, 1), (16, NULL, 2), (17, 'S8', 2), (18, 'default1', NULL), (19, 'default2', NULL), (20, 'iPhone', 2), (21, 'S8', NULL), (22, 'default1', NULL), (23, NULL, 2), (24, 'iPhone', 1), (25, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (23, 2, 2, NULL, NULL, 1), (17, 0, NULL, '2023-01-02', 1, 1), (16, 0, 2, NULL, 2, NULL), (25, 2, 1, '2023-01-02', 2, NULL), (-1, NULL, 0, '2023-01-02', 2, 1), (16, -1, 0, NULL, 1, 1), (13, 1, 1, '2023-01-02', NULL, 2), (6, -1, -1, '2023-01-01', 1, NULL), (8, 0, 0, '2023-01-02', 1, 2), (7, NULL, 0, '2023-01-02', 1, NULL), (9, NULL, -1, NULL, 1, 2), (7, 0, 1, NULL, 1, 1), (4, 2, NULL, '2023-01-01', 2, NULL), (17, 0, 2, '2023-01-01', 1, NULL), (12, 1, 1, '2023-01-02', 1, 2), (7, 0, NULL, '2023-01-02', 1, 1), (-1, -1, NULL, '2023-01-01', NULL, 2), (2, -1, -1, NULL, NULL, 2), (6, NULL, 0, NULL, 1, 2), (23, NULL, 2, NULL, NULL, NULL), (4, NULL, 0, '2023-01-02', 2, 1), (1, 0, NULL, NULL, 1, 2), (23, 2, 2, '2023-01-01', NULL, 2), (25, 0, -1, '2023-01-01', 1, 1), (0, NULL, -1, '2023-01-01', NULL, NULL), (0, NULL, 1, '2023-01-02', NULL, NULL), (2, 0, 1, '2023-01-01', 1, NULL), (18, NULL, 0, '2023-01-01', 1, 2), (13, NULL, 1, NULL, 1, 2), (9, -1, -1, NULL, 2, NULL), (NULL, 0, 2, '2023-01-02', NULL, 1), (12, 1, 2, '2023-01-01', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY S.BUYER_ID HAVING MAX(PRODUCT_NAME = 'S8') = 1 AND MAX(PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(2,)
*/