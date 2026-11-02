-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'S8', NULL), (-1, NULL, 1), (1, 'S8', 1), (0, 'S8', NULL), (3, 'default1', NULL), (4, 'S8', 1), (5, 'default1', 2), (6, 'default2', 1), (7, 'default1', 2), (8, 'S8', 1), (9, 'S8', NULL), (10, 'default1', 2), (11, 'S8', NULL), (12, 'default2', 2), (13, NULL, NULL), (14, 'iPhone', NULL), (15, 'default1', NULL), (16, NULL, 2), (17, 'iPhone', 2), (18, 'S8', 1), (19, 'iPhone', NULL), (20, 'default1', 1), (21, 'S8', 2), (22, NULL, NULL), (23, 'default2', NULL), (24, 'S8', NULL), (25, 'iPhone', 2), (26, 'default1', NULL), (27, 'default2', 2), (28, 'default2', 1), (29, 'S8', 1), (30, 'default1', NULL), (31, 'default2', 2), (32, 'iPhone', 2), (33, NULL, 2), (34, 'default1', 2), (35, 'iPhone', NULL), (36, 'iPhone', 2), (37, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 1, -1, NULL, 1, 2), (14, 1, 1, '2023-01-02', 1, 1), (19, 0, 0, '2023-01-01', 1, 1), (32, 1, NULL, '2023-01-02', 1, NULL), (14, 2, -1, NULL, 1, NULL), (7, 2, -1, NULL, NULL, 1), (19, -1, 1, '2023-01-01', 1, NULL), (20, -1, -1, NULL, 2, NULL), (23, 1, 0, NULL, 2, 2), (30, -1, 0, '2023-01-01', NULL, 2), (1, 0, -1, '2023-01-01', 1, 1), (8, 2, 1, NULL, 1, 1), (10, -1, -1, '2023-01-02', 2, 2), (24, 0, 0, '2023-01-02', 2, 2), (4, -1, -1, '2023-01-01', 2, 1), (27, -1, 2, NULL, 1, 1), (NULL, -1, NULL, '2023-01-02', NULL, NULL), (26, NULL, NULL, NULL, 2, 2), (35, -1, 1, '2023-01-01', 1, 2), (30, NULL, -1, '2023-01-01', NULL, 1), (31, 0, 2, NULL, 1, NULL), (25, NULL, 0, NULL, 1, 2), (19, 1, 0, '2023-01-01', 1, 1), (11, NULL, 2, '2023-01-02', 2, 2), (21, 0, NULL, NULL, 2, 2), (13, 0, 0, '2023-01-02', 1, NULL), (37, NULL, 2, '2023-01-02', 2, NULL), (10, NULL, 1, '2023-01-02', NULL, 1), (10, 0, -1, NULL, 2, 2), (2, 2, 0, '2023-01-01', NULL, 1), (22, NULL, 1, '2023-01-02', 2, 1), (18, 2, 2, '2023-01-01', 1, 2), (11, 1, NULL, '2023-01-02', NULL, NULL), (33, NULL, NULL, NULL, NULL, 2), (24, 2, -1, '2023-01-01', 1, 2), (8, 0, 2, '2023-01-02', NULL, 2), (35, 2, 1, NULL, 2, NULL), (1, -1, NULL, '2023-01-02', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(2,)
*/

-- Prediction Query
WITH T1 AS (SELECT SALES.PRODUCT_ID, SALES.BUYER_ID, PRODUCT.PRODUCT_NAME FROM SALES LEFT JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID) SELECT DISTINCT BUYER_ID FROM T1 WHERE NOT BUYER_ID IN (SELECT BUYER_ID FROM T1 WHERE PRODUCT_NAME = 'iPhone') AND PRODUCT_NAME = 'S8';

/*
Prediction Result:
*/