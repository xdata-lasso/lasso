-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, 2), (1, NULL, 2), (-1, 'S8', 1), (2, 'iPhone', NULL), (3, 'default2', 1), (4, 'default1', 2), (5, 'iPhone', 2), (6, 'default1', 2), (7, 'default1', 2), (8, NULL, 2), (9, NULL, 2), (10, 'default2', 2), (11, 'default1', 1), (12, 'default1', NULL), (13, NULL, 2), (14, 'default2', 1), (15, 'iPhone', 1), (16, 'iPhone', NULL), (17, 'S8', NULL), (18, 'iPhone', NULL), (19, 'iPhone', 2), (20, 'S8', 1), (21, NULL, 1), (22, 'iPhone', 1), (23, 'iPhone', NULL), (24, 'default1', 1), (25, 'default1', 1), (26, NULL, 2), (27, 'default2', 2), (28, 'iPhone', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, -1, NULL, '2023-01-01', 2, 1), (-1, -1, NULL, NULL, NULL, 1), (28, -1, 0, NULL, NULL, 2), (5, NULL, 2, '2023-01-02', 2, 2), (1, NULL, -1, NULL, 2, 1), (25, 1, NULL, '2023-01-02', NULL, NULL), (14, NULL, -1, '2023-01-02', NULL, 2), (22, 1, -1, '2023-01-01', 1, 2), (12, 1, -1, '2023-01-01', 2, 1), (2, NULL, 0, '2023-01-01', NULL, 2), (24, 0, 0, '2023-01-01', NULL, 2), (3, 2, -1, '2023-01-01', 1, 1), (8, 2, 0, NULL, 2, NULL), (-1, 1, NULL, '2023-01-01', 2, 1), (0, 0, NULL, '2023-01-01', 1, 2), (13, -1, -1, '2023-01-01', 1, NULL), (24, 2, 1, '2023-01-02', NULL, 2), (4, 2, 2, '2023-01-01', NULL, 2), (2, 1, 0, '2023-01-01', NULL, NULL), (17, -1, 0, '2023-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM PRODUCT JOIN SALES USING (PRODUCT_ID) WHERE PRODUCT_NAME = 'iPhone' OR PRODUCT_NAME = 'S8' GROUP BY BUYER_ID HAVING SUM(IIF(PRODUCT_NAME = 'iPhone', 1, 0)) = 0;

/*
Prediction Result:
(None,)
*/