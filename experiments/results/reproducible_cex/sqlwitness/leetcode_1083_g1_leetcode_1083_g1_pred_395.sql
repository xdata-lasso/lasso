-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'default2', NULL), (-1, 'S8', NULL), (0, 'default2', 2), (1, 'S8', 1), (3, NULL, 2), (4, NULL, NULL), (5, 'iPhone', NULL), (6, 'default1', 2), (7, 'S8', NULL), (8, 'default2', NULL), (9, 'iPhone', 1), (10, 'S8', NULL), (11, 'S8', 1), (12, 'S8', 1), (13, 'default2', 1), (14, 'default1', NULL), (15, NULL, NULL), (16, 'iPhone', 2), (17, 'default2', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (16, 2, 2, '2023-01-02', 2, NULL), (9, -1, 0, '2023-01-01', 2, NULL), (10, 2, 2, '2023-01-01', NULL, 2), (7, 0, 0, '2023-01-02', NULL, NULL), (14, NULL, 1, NULL, 2, NULL), (14, NULL, 1, '2023-01-01', NULL, 2), (3, 1, 2, '2023-01-01', 1, NULL), (NULL, NULL, 2, '2023-01-01', 2, NULL), (8, NULL, 0, '2023-01-02', 2, 2), (9, -1, -1, '2023-01-01', NULL, NULL), (17, -1, 0, '2023-01-02', NULL, NULL), (3, 1, NULL, '2023-01-01', 1, 2), (16, NULL, 2, '2023-01-01', 1, 1), (NULL, -1, -1, NULL, NULL, 1), (17, 0, 1, '2023-01-01', NULL, 2), (15, -1, -1, '2023-01-01', NULL, 2), (15, 1, 2, NULL, 2, 2), (12, -1, NULL, NULL, 1, NULL), (5, 0, 2, NULL, 1, NULL), (5, 1, -1, NULL, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM SALES JOIN PRODUCT USING (PRODUCT_ID) GROUP BY 1 HAVING SUM(PRODUCT_NAME = 'S8') >= 1 AND SUM(PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(None,)
*/