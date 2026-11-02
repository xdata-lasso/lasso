-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, NULL, 2), (-1, NULL, 1), (1, 'S8', 2), (0, 'default2', NULL), (3, 'default1', NULL), (4, NULL, 1), (5, 'iPhone', 2), (6, NULL, NULL), (7, 'default2', 1), (8, 'iPhone', 2), (9, 'default1', 1), (10, 'iPhone', NULL), (11, 'S8', 2), (12, 'default1', NULL), (13, NULL, 1), (14, 'default1', 2), (15, NULL, 2), (16, 'default2', NULL), (17, 'S8', 1), (18, 'default1', NULL), (19, NULL, 1), (20, 'default2', 2), (21, 'iPhone', NULL), (22, 'default2', NULL), (23, 'S8', 1), (24, 'default2', 2), (25, 'S8', NULL), (26, 'default2', NULL), (27, 'iPhone', 1), (28, 'default1', 2), (29, 'S8', 1), (30, 'default1', 1), (31, 'default2', NULL), (32, 'S8', NULL), (33, 'S8', NULL), (34, 'iPhone', NULL), (35, NULL, 1), (36, 'default2', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (32, -1, NULL, NULL, NULL, 1), (32, 1, 2, '2023-01-02', 2, NULL), (10, -1, NULL, NULL, 2, 1), (34, -1, -1, '2023-01-02', NULL, 2), (30, 0, 0, NULL, NULL, 1), (25, NULL, 0, '2023-01-01', 1, 2), (13, 1, 2, '2023-01-02', 1, 2), (6, 2, -1, '2023-01-01', 1, 2), (30, 1, 0, '2023-01-01', NULL, 2), (30, NULL, 2, NULL, 1, NULL), (25, 0, 0, NULL, NULL, 2), (1, -1, -1, '2023-01-02', 1, NULL), (31, 1, NULL, '2023-01-02', 2, 2), (29, 0, 1, NULL, NULL, 1), (11, NULL, 1, NULL, 2, 1), (21, 1, 0, '2023-01-02', 1, NULL), (12, -1, 1, '2023-01-01', 2, 2), (7, 1, 0, '2023-01-01', NULL, 2), (20, 0, 1, '2023-01-02', 1, 1), (17, 0, 2, NULL, 2, 1), (8, 1, 2, NULL, 1, NULL), (-1, -1, NULL, '2023-01-02', 2, 2), (11, 1, NULL, '2023-01-02', 2, 1), (4, 1, 1, '2023-01-02', 2, NULL), (29, -1, 0, '2023-01-02', NULL, 2), (5, 0, -1, '2023-01-02', NULL, 2), (9, -1, 2, NULL, 2, NULL), (29, 2, 2, '2023-01-01', NULL, NULL), (35, 2, 1, NULL, NULL, 2), (5, 1, 2, '2023-01-02', 2, NULL), (28, NULL, 0, NULL, 2, NULL), (19, 1, 2, '2023-01-02', 2, NULL), (29, -1, 1, NULL, 1, NULL), (NULL, 1, NULL, NULL, 2, 2), (5, 2, -1, NULL, 2, 2), (28, 2, 1, '2023-01-02', 2, 1), (8, 1, NULL, NULL, 2, 2), (6, 1, -1, '2023-01-02', 1, 2), (19, 0, -1, '2023-01-01', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE BUYER_ID IN (SELECT S.BUYER_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT S.BUYER_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/