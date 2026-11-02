-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'S8', 1), (1, 'default1', 1), (2, 'iPhone', NULL), (0, 'default2', 2), (3, NULL, 1), (4, 'S8', 1), (5, NULL, NULL), (6, 'default1', NULL), (7, 'default2', NULL), (8, NULL, 1), (9, 'S8', 1), (10, 'S8', 1), (11, 'default1', 1), (12, 'iPhone', NULL), (13, NULL, NULL), (14, 'default1', 1), (15, NULL, 2), (16, 'default2', 2), (17, 'default1', 2), (18, NULL, 1), (19, 'iPhone', 2), (20, 'S8', 1), (21, 'default1', 1), (22, 'default2', NULL), (23, 'S8', 1), (24, 'S8', NULL), (25, 'default2', 2), (26, 'S8', 2), (27, 'default1', NULL), (28, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (17, NULL, 1, NULL, NULL, 1), (1, 2, 0, '2023-01-02', 2, NULL), (24, NULL, 1, NULL, NULL, 2), (2, 1, 1, '2023-01-01', 1, NULL), (21, 2, 1, '2023-01-02', NULL, NULL), (2, 0, -1, NULL, 1, NULL), (-1, NULL, NULL, '2023-01-02', 1, NULL), (4, 2, 0, '2023-01-01', 1, 1), (22, 0, 0, '2023-01-02', NULL, 2), (23, NULL, 0, NULL, NULL, 1), (10, 2, 2, '2023-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(0,)
(2,)
*/

-- Prediction Query
SELECT BUYER_ID FROM SALES AS T1 INNER JOIN PRODUCT USING (PRODUCT_ID) GROUP BY BUYER_ID HAVING SUM(CASE WHEN PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(None,)
(0,)
(2,)
*/