-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'default2', NULL), (0, 'default2', NULL), (1, 'S8', 2), (-1, NULL, 1), (3, 'default1', 2), (4, 'iPhone', 2), (5, 'S8', 2), (6, 'iPhone', 1), (7, 'iPhone', 2), (8, NULL, 1), (9, 'default1', 2), (10, 'default1', NULL), (11, 'iPhone', 1), (12, 'S8', NULL), (13, NULL, NULL), (14, 'iPhone', NULL), (15, 'iPhone', 2), (16, 'default1', 2), (17, 'default2', NULL), (18, 'iPhone', 1), (19, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (7, 2, -1, NULL, NULL, 1), (7, -1, 2, NULL, 2, 2), (9, 2, 0, '2023-01-01', NULL, NULL), (9, NULL, 1, '2023-01-02', 2, NULL), (14, -1, NULL, NULL, 1, 2), (5, NULL, 0, '2023-01-02', 2, 1), (15, 0, -1, '2023-01-02', NULL, 1), (-1, 0, 2, '2023-01-01', NULL, NULL), (7, 1, -1, '2023-01-01', 1, NULL), (12, NULL, 1, NULL, NULL, NULL), (-1, 2, 1, '2023-01-02', 1, NULL), (5, -1, 0, '2023-01-02', 1, NULL), (8, -1, NULL, '2023-01-01', 1, 1), (9, -1, 1, NULL, 2, 1), (18, -1, 2, NULL, NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM SALES JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID GROUP BY BUYER_ID HAVING (SUM(PRODUCT_NAME = 'S8') > 0 AND SUM(PRODUCT_NAME = 'iPhone') < 1);

/*
Prediction Result:
(0,)
(1,)
*/