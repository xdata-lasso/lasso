-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', NULL), (1, 'default1', 1), (2, 'iPhone', NULL), (-1, 'default1', NULL), (3, NULL, 1), (4, 'default1', 1), (5, 'default1', NULL), (6, 'S8', NULL), (7, 'default1', 1), (8, 'default2', 2), (9, 'iPhone', NULL), (10, 'S8', NULL), (11, 'default2', 1), (12, 'S8', 2), (13, 'S8', NULL), (14, 'default1', 1), (15, 'iPhone', 1), (16, NULL, 1), (17, 'iPhone', 2), (18, 'default1', 1), (19, 'default1', 2), (20, NULL, 1), (21, NULL, 2), (22, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (21, 0, 2, NULL, 2, 2), (12, 0, NULL, '2023-01-01', 1, 2), (NULL, 1, 0, '2023-01-01', NULL, 2), (5, 0, NULL, '2023-01-01', 2, NULL), (8, 2, 2, '2023-01-01', 2, 2), (0, NULL, -1, '2023-01-02', 1, 2), (-1, -1, 1, '2023-01-02', 2, 2), (13, NULL, 2, NULL, NULL, NULL), (22, 2, 1, NULL, 2, 1), (16, 2, -1, NULL, 1, NULL), (18, -1, 2, '2023-01-01', NULL, 1), (17, 0, 0, '2023-01-02', 2, NULL), (12, -1, 2, NULL, 2, NULL), (9, NULL, 1, '2023-01-02', 1, 2), (6, 0, 2, NULL, 2, 2), (18, 0, -1, '2023-01-01', NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT DISTINCT S.BUYER_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY S.BUYER_ID HAVING SUM(CASE WHEN P.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) >= 1 AND SUM(CASE WHEN P.PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(None,)
(2,)
*/