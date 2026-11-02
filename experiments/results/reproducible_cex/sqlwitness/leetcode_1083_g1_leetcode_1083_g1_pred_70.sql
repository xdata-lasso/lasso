-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'S8', 2), (0, 'iPhone', 1), (2, NULL, 2), (1, 'default1', 2), (3, 'iPhone', 2), (4, 'iPhone', 2), (5, 'default1', NULL), (6, 'default2', NULL), (7, 'S8', 1), (8, 'iPhone', 2), (9, 'iPhone', NULL), (10, 'S8', NULL), (11, 'S8', NULL), (12, NULL, NULL), (13, 'default2', 1), (14, NULL, NULL), (15, 'default1', 1), (16, 'default2', 2), (17, 'S8', NULL), (18, 'default2', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (9, 0, 1, '2023-01-01', NULL, 2), (17, NULL, NULL, '2023-01-01', 2, 2), (7, NULL, 0, NULL, 1, 2), (NULL, -1, 0, NULL, 1, 2), (-1, NULL, 2, '2023-01-01', 2, NULL), (-1, 2, -1, '2023-01-01', 1, 2), (2, 2, 0, '2023-01-01', 1, 2), (4, 1, 2, NULL, 2, NULL);
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
SELECT T1.BUYER_ID FROM SALES AS T1 INNER JOIN PRODUCT AS T2 ON T1.PRODUCT_ID = T2.PRODUCT_ID GROUP BY T1.BUYER_ID HAVING SUM(CASE WHEN T2.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN T2.PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(None,)
(-1,)
(0,)
*/