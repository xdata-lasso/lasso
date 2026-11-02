-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, 2), (1, 'default2', 1), (2, 'default2', 2), (-1, 'S8', 2), (3, 'default1', NULL), (4, 'default1', 1), (5, 'default1', 2), (6, NULL, 2), (7, 'S8', NULL), (8, 'default2', 2), (9, 'default2', 2), (10, 'default1', 1), (11, 'default1', 1), (12, NULL, 1), (13, 'S8', 1), (14, NULL, 1), (15, NULL, NULL), (16, NULL, 2), (17, NULL, 1), (18, 'S8', 1), (19, 'S8', NULL), (20, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 0, 1, '2023-01-02', 1, 2), (9, -1, 0, '2023-01-02', 2, 1), (15, NULL, NULL, NULL, 1, 2), (6, -1, 1, '2023-01-01', 1, 1), (5, 0, 2, NULL, NULL, 2), (3, 2, -1, '2023-01-02', 2, 2), (3, -1, 1, '2023-01-02', NULL, 1), (13, 0, NULL, '2023-01-02', NULL, 1), (-1, NULL, NULL, '2023-01-02', NULL, 1), (15, 1, 2, '2023-01-02', 2, 1), (9, -1, 0, '2023-01-01', NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT B.BUYER_ID FROM PRODUCT AS A JOIN SALES AS B ON A.PRODUCT_ID = B.PRODUCT_ID GROUP BY B.BUYER_ID HAVING SUM(A.PRODUCT_NAME = 'S8') > 0 AND SUM(A.PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(None,)
*/