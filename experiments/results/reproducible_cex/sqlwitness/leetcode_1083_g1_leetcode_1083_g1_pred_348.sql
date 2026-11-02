-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'iPhone', 1), (0, 'default2', NULL), (2, 'S8', 1), (1, 'iPhone', NULL), (3, NULL, 1), (4, 'default2', 1), (5, 'default1', NULL), (6, 'S8', 1), (7, NULL, 1), (8, 'default2', 2), (9, 'S8', 1), (10, NULL, 1), (11, 'S8', NULL), (12, NULL, 2), (13, NULL, 2), (14, 'iPhone', 1), (15, 'iPhone', NULL), (16, 'default2', 1), (17, 'default1', 2), (18, 'S8', 2), (19, 'default1', NULL), (20, NULL, 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (14, NULL, 2, '2023-01-01', 2, NULL), (16, 0, -1, '2023-01-01', 2, 2), (3, -1, -1, '2023-01-02', 1, 1), (6, 2, -1, '2023-01-02', 1, NULL), (3, 0, -1, '2023-01-02', 2, 1), (10, 1, 2, '2023-01-01', NULL, 1), (3, 2, NULL, '2023-01-02', NULL, NULL), (16, NULL, -1, '2023-01-02', 2, 2), (14, 0, 1, NULL, NULL, 1), (1, 0, NULL, '2023-01-02', NULL, NULL), (9, NULL, NULL, '2023-01-01', NULL, NULL), (NULL, 1, NULL, '2023-01-02', 2, 2), (19, 2, 2, '2023-01-01', 2, NULL), (5, 0, -1, '2023-01-02', 1, 1), (6, 2, -1, '2023-01-02', 1, NULL), (12, 0, -1, '2023-01-01', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
*/

-- Prediction Query
WITH CTE AS (SELECT BUYER_ID, PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' OR PRODUCT_NAME = 'iPhone') SELECT DISTINCT BUYER_ID FROM CTE WHERE PRODUCT_NAME = 'S8' AND NOT BUYER_ID IN (SELECT BUYER_ID FROM CTE WHERE PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/