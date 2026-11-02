-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', 1), (1, NULL, 2), (-1, 'default1', 1), (2, NULL, 1), (3, 'iPhone', NULL), (4, 'iPhone', 1), (5, NULL, 1), (6, 'default1', 1), (7, 'default2', 1), (8, 'default1', NULL), (9, 'S8', 1), (10, NULL, 2), (11, 'iPhone', 1), (12, 'iPhone', 2), (13, 'default1', 2), (14, 'default2', 1), (15, 'S8', 1), (16, 'S8', NULL), (17, NULL, 2), (18, 'default1', NULL), (19, NULL, 2), (20, NULL, 1), (21, 'S8', NULL), (22, 'iPhone', NULL), (23, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 1, 1, NULL, NULL, NULL), (17, -1, -1, '2023-01-02', 1, 1), (16, 0, -1, '2023-01-01', 1, 1), (17, NULL, NULL, '2023-01-02', NULL, NULL), (23, 1, NULL, NULL, NULL, 1), (1, -1, 0, '2023-01-02', 2, 2), (7, NULL, 1, '2023-01-01', 1, 1), (19, 1, -1, '2023-01-02', 2, 1), (14, NULL, 1, '2023-01-02', 2, 1), (21, -1, 2, NULL, 1, 2), (15, -1, 0, '2023-01-02', 2, NULL), (21, 1, 1, NULL, NULL, NULL), (7, 0, -1, NULL, NULL, 1), (11, NULL, 2, '2023-01-01', 1, NULL), (21, 1, 0, NULL, 2, 2), (13, -1, 1, '2023-01-01', 1, 2), (21, 1, 2, '2023-01-01', 1, 2), (9, NULL, -1, '2023-01-02', 2, NULL), (10, 2, NULL, '2023-01-01', 2, 1), (6, -1, NULL, '2023-01-02', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
(0,)
(1,)
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM PRODUCT AS P JOIN SALES AS S ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY 1 HAVING SUM(PRODUCT_NAME = 'S8') > 0 AND SUM(PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(None,)
(-1,)
(0,)
(1,)
*/