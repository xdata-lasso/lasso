-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'iPhone', 1), (1, 'default1', 2), (-1, 'S8', 2), (2, NULL, 2), (3, NULL, NULL), (4, 'iPhone', 1), (5, NULL, 2), (6, 'default1', 2), (7, 'default1', 2), (8, 'S8', 2), (9, 'S8', NULL), (10, 'default2', NULL), (11, 'default1', NULL), (12, 'iPhone', 2), (13, 'iPhone', 2), (14, 'S8', NULL), (15, 'default2', 2), (16, 'iPhone', 1), (17, NULL, NULL), (18, 'default2', 2), (19, 'iPhone', NULL), (20, 'default2', NULL), (21, NULL, NULL), (22, NULL, NULL), (23, 'default2', 1), (24, 'default2', NULL), (25, 'default2', 2), (26, NULL, NULL), (27, 'iPhone', 2), (28, 'default2', 2), (29, 'iPhone', NULL), (30, 'S8', 2), (31, 'iPhone', 1), (32, 'iPhone', NULL), (33, 'default1', NULL), (34, 'S8', 1), (35, NULL, NULL), (36, 'S8', 1), (37, 'S8', NULL), (38, 'default2', NULL), (39, 'default1', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (30, 1, -1, NULL, 2, 1), (20, 1, 2, '2023-01-01', 2, NULL), (27, 1, NULL, NULL, NULL, NULL), (24, -1, 2, '2023-01-01', NULL, NULL), (5, 0, 2, '2023-01-01', NULL, 1), (35, NULL, -1, NULL, 2, NULL), (13, 0, 1, NULL, 2, NULL), (35, 2, 2, '2023-01-02', NULL, 2), (-1, 0, 1, NULL, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
*/

-- Prediction Query
WITH IPHONE AS (SELECT DISTINCT BUYER_ID FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'iPhone') SELECT DISTINCT BUYER_ID FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8' AND NOT BUYER_ID IN (SELECT BUYER_ID FROM IPHONE);

/*
Prediction Result:
*/