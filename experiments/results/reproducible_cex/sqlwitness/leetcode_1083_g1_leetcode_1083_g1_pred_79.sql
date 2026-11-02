-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', 2), (-1, 'default1', NULL), (1, NULL, NULL), (2, 'default2', 2), (3, 'iPhone', NULL), (4, NULL, 2), (5, 'iPhone', 2), (6, NULL, 2), (7, 'default1', 1), (8, 'iPhone', 2), (9, NULL, 1), (10, 'iPhone', NULL), (11, 'default1', 2), (12, 'S8', NULL), (13, 'S8', NULL), (14, 'S8', 1), (15, 'S8', 1), (16, 'iPhone', NULL), (17, NULL, 1), (18, 'default1', NULL), (19, NULL, NULL), (20, 'S8', 1), (21, NULL, NULL), (22, 'default2', NULL), (23, 'iPhone', 2), (24, 'default2', 2), (25, NULL, NULL), (26, NULL, 2), (27, 'iPhone', 2), (28, NULL, 1), (29, NULL, 1), (30, NULL, 1), (31, 'default1', NULL), (32, 'S8', 2), (33, 'default1', 1), (34, 'iPhone', NULL), (35, 'default2', 1), (36, NULL, NULL), (37, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 2, 1, NULL, NULL, 1), (NULL, NULL, 2, NULL, NULL, NULL), (35, 0, -1, NULL, NULL, 1), (NULL, 1, 0, '2023-01-02', NULL, 2), (1, 2, 0, NULL, 2, NULL), (8, 2, 0, NULL, 2, 1), (29, -1, 0, '2023-01-01', 1, 1), (16, NULL, 0, NULL, 2, 2), (37, NULL, 2, '2023-01-02', 1, NULL), (17, 2, 2, '2023-01-02', NULL, 1), (25, NULL, 2, NULL, 1, 2), (5, 0, 2, NULL, 1, 1), (15, NULL, 0, NULL, 1, 2), (26, NULL, NULL, '2023-01-01', 2, 2), (37, 1, 1, '2023-01-01', 1, NULL), (34, -1, 0, NULL, 2, 2), (15, -1, 2, '2023-01-01', 1, 1), (32, 1, 2, '2023-01-01', 1, NULL), (11, -1, 0, NULL, NULL, 2), (21, -1, 2, NULL, 2, 1), (4, 0, 1, '2023-01-02', NULL, 2), (26, 0, 0, '2023-01-01', 2, 2), (17, 0, NULL, '2023-01-01', NULL, 2), (19, 2, 2, '2023-01-01', NULL, 1), (36, -1, -1, '2023-01-02', 2, 1), (0, 2, NULL, '2023-01-02', 2, 1), (11, -1, NULL, '2023-01-01', NULL, NULL), (34, 2, 2, '2023-01-02', 2, 1), (4, NULL, 1, '2023-01-02', 2, 2), (28, -1, 2, '2023-01-02', 1, NULL), (12, -1, -1, NULL, NULL, 2), (1, NULL, 1, '2023-01-01', 1, 2), (35, 1, NULL, '2023-01-01', NULL, NULL), (27, 2, NULL, NULL, NULL, 2), (7, 0, -1, NULL, NULL, NULL), (13, 0, -1, '2023-01-01', 2, 1), (12, 1, NULL, NULL, 2, 1), (32, NULL, 2, '2023-01-02', 1, 1), (30, -1, 0, '2023-01-02', NULL, 1), (-1, -1, 0, NULL, 1, 2), (0, 1, 1, '2023-01-02', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
*/

-- Prediction Query
WITH BOUGHTS8 AS (SELECT BUYER_ID FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8'), BOUGHTIPHONE AS (SELECT BUYER_ID FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'iPhone') SELECT DISTINCT BUYER_ID FROM BOUGHTS8 WHERE NOT BUYER_ID IN (SELECT BUYER_ID FROM BOUGHTIPHONE);

/*
Prediction Result:
*/