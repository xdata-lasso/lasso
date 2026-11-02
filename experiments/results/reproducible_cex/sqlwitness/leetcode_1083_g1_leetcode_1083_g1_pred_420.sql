-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'S8', NULL), (-1, 'default2', NULL), (1, 'S8', 2), (0, 'default1', NULL), (3, NULL, 1), (4, 'default1', NULL), (5, 'S8', 1), (6, 'default2', 2), (7, 'default2', 1), (8, 'default2', NULL), (9, 'default1', NULL), (10, 'S8', NULL), (11, 'S8', NULL), (12, 'iPhone', NULL), (13, NULL, NULL), (14, 'default1', 1), (15, 'iPhone', 1), (16, 'default1', NULL), (17, NULL, NULL), (18, 'default1', 1), (19, 'default2', 2), (20, 'S8', 2), (21, NULL, 2), (22, NULL, 2), (23, 'iPhone', 2), (24, 'default2', NULL), (25, 'S8', 2), (26, 'default1', 1), (27, NULL, 1), (28, 'iPhone', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (12, 0, 2, NULL, 2, 1), (21, 1, 2, '2023-01-01', 1, 1), (10, -1, -1, '2023-01-02', 1, 2), (17, 2, -1, NULL, 1, 2), (10, 2, 0, '2023-01-01', NULL, NULL), (-1, -1, 2, '2023-01-01', 2, 1), (1, -1, 2, '2023-01-02', 1, 1), (28, 0, 2, NULL, NULL, 1), (9, NULL, -1, '2023-01-02', NULL, 2), (15, 0, NULL, '2023-01-01', 2, NULL), (NULL, -1, NULL, '2023-01-02', 2, NULL), (17, -1, 1, '2023-01-01', 2, NULL), (16, 2, 1, '2023-01-01', NULL, 1), (25, NULL, -1, '2023-01-02', NULL, NULL), (26, 2, 2, '2023-01-02', 1, NULL), (20, 2, -1, '2023-01-02', 2, 2), (24, 0, 1, '2023-01-02', NULL, 1), (6, -1, -1, NULL, 1, NULL), (0, 0, NULL, NULL, 2, 2), (11, 0, 0, NULL, 2, 2), (0, -1, 2, NULL, 2, 1), (NULL, 1, 1, NULL, NULL, NULL), (18, 0, 0, '2023-01-02', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
(0,)
*/

-- Prediction Query
WITH CTE AS (SELECT S.BUYER_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' OR PRODUCT_NAME = 'iPhone') SELECT DISTINCT BUYER_ID FROM SALES WHERE BUYER_ID IN (SELECT BUYER_ID FROM CTE WHERE PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT BUYER_ID FROM CTE WHERE PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/