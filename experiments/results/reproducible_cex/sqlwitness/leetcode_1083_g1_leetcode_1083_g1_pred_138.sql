-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'S8', 2), (2, NULL, 2), (0, 'iPhone', NULL), (-1, NULL, 1), (3, 'S8', NULL), (4, NULL, 1), (5, 'S8', 2), (6, 'S8', NULL), (7, 'iPhone', 2), (8, 'S8', 1), (9, NULL, 2), (10, 'default1', NULL), (11, 'S8', NULL), (12, 'default2', NULL), (13, 'default2', 1), (14, 'S8', 2), (15, 'S8', NULL), (16, 'default2', NULL), (17, 'iPhone', 1), (18, 'default1', 1), (19, NULL, 2), (20, 'iPhone', 1), (21, NULL, 1), (22, 'default2', NULL), (23, NULL, NULL), (24, NULL, 1), (25, 'default1', NULL), (26, 'S8', NULL), (27, NULL, 2), (28, NULL, 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, -1, -1, NULL, 1, NULL), (19, -1, 0, NULL, NULL, 2), (22, 1, NULL, NULL, 2, NULL), (0, NULL, 2, '2023-01-01', 2, 2), (5, 0, NULL, '2023-01-02', NULL, NULL), (16, 2, -1, '2023-01-01', 1, NULL), (9, 0, NULL, NULL, NULL, NULL), (28, 1, -1, '2023-01-01', 1, 1), (15, NULL, -1, '2023-01-02', 1, NULL), (11, NULL, 0, NULL, 2, 2), (12, 0, 0, '2023-01-01', 1, 1), (16, 1, 0, '2023-01-02', NULL, NULL), (2, 0, 1, '2023-01-01', NULL, 2), (15, 2, NULL, '2023-01-01', 1, 2), (24, 2, 0, '2023-01-01', NULL, 1), (NULL, NULL, -1, NULL, 2, NULL), (8, NULL, NULL, '2023-01-02', NULL, 2), (-1, 1, NULL, '2023-01-02', 2, 2), (14, 2, 0, '2023-01-02', 1, 1), (15, 1, 0, NULL, NULL, NULL);
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
SELECT BUYER_ID FROM (SELECT BUYER_ID, (CASE WHEN PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8, (CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IPHONE FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID) AS Z GROUP BY 1 HAVING SUM(S8) > 0 AND SUM(IPHONE) = 0;

/*
Prediction Result:
(None,)
(-1,)
(0,)
*/