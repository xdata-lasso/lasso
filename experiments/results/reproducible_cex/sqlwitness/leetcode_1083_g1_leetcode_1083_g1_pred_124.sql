-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'S8', 2), (0, 'default2', NULL), (1, 'default2', NULL), (-1, NULL, 1), (3, 'default1', 1), (4, NULL, 2), (5, 'S8', NULL), (6, NULL, 2), (7, 'default2', 1), (8, NULL, NULL), (9, 'iPhone', NULL), (10, 'S8', NULL), (11, NULL, 2), (12, 'S8', 2), (13, 'default2', 2), (14, 'default2', NULL), (15, 'default1', 2), (16, 'iPhone', NULL), (17, 'S8', NULL), (18, 'iPhone', NULL), (19, NULL, 1), (20, 'S8', NULL), (21, 'default2', NULL), (22, 'S8', NULL), (23, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (13, -1, 0, '2023-01-02', 2, 1), (9, NULL, 1, NULL, NULL, 2), (9, NULL, -1, '2023-01-01', NULL, NULL), (15, -1, 1, NULL, 2, 1), (13, 1, -1, '2023-01-02', 1, 2), (20, 2, 1, '2023-01-02', 1, NULL), (19, 0, 1, NULL, 2, 1), (18, 2, 1, '2023-01-01', 1, 2), (2, NULL, NULL, NULL, 2, 1), (20, 0, NULL, '2023-01-02', 2, NULL), (NULL, NULL, -1, '2023-01-02', NULL, 1), (-1, -1, NULL, NULL, 1, NULL), (23, -1, 0, NULL, 2, 1), (22, 0, NULL, NULL, 1, NULL), (15, 0, -1, NULL, 2, NULL), (22, NULL, 0, '2023-01-01', NULL, 1), (20, 1, 0, NULL, 1, 2), (-1, 0, 1, NULL, 1, 2), (3, -1, 0, '2023-01-01', NULL, 2), (4, 1, 0, '2023-01-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT BUYER_ID FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY BUYER_ID HAVING COUNT(IIF(P.PRODUCT_NAME = 'S8', 1, NULL)) > 0 AND COUNT(IIF(P.PRODUCT_NAME = 'iPhone', 1, NULL)) = 0;

/*
Prediction Result:
(None,)
(0,)
*/