-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default2', 1), (-1, NULL, 2), (0, 'default2', 1), (2, 'iPhone', NULL), (3, NULL, 1), (4, NULL, 1), (5, 'iPhone', NULL), (6, 'S8', NULL), (7, 'default2', 2), (8, NULL, 2), (9, 'S8', NULL), (10, 'S8', NULL), (11, 'default2', 1), (12, NULL, 1), (13, 'S8', 2), (14, 'default1', 1), (15, NULL, NULL), (16, 'default2', NULL), (17, 'default2', 1), (18, 'default2', NULL), (19, 'default2', 2), (20, 'iPhone', 2), (21, NULL, 2), (22, 'iPhone', 1), (23, 'default2', 1), (24, NULL, NULL), (25, 'iPhone', 1), (26, 'default1', NULL), (27, 'default1', NULL), (28, 'default1', 2), (29, 'iPhone', NULL), (30, 'S8', 1), (31, 'S8', NULL), (32, 'iPhone', NULL), (33, NULL, 1), (34, NULL, 2), (35, 'default1', 1), (36, 'default2', 1), (37, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 0, NULL, '2023-01-02', 2, NULL), (10, 1, 0, '2023-01-01', NULL, 2), (22, 0, 2, '2023-01-02', NULL, 2), (24, NULL, 2, NULL, 2, NULL), (26, 1, -1, '2023-01-01', 2, NULL), (5, -1, NULL, '2023-01-02', 2, 2), (13, 1, 0, '2023-01-02', 1, NULL), (22, 0, NULL, '2023-01-02', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES WHERE BUYER_ID IN (SELECT BUYER_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT DISTINCT BUYER_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/