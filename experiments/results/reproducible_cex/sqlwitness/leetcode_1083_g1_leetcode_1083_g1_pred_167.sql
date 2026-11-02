-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'iPhone', 2), (0, NULL, 1), (2, 'default2', NULL), (-1, 'default2', NULL), (3, 'iPhone', NULL), (4, 'S8', 1), (5, 'default1', 1), (6, 'default1', 1), (7, NULL, NULL), (8, 'S8', 1), (9, 'S8', 2), (10, NULL, NULL), (11, 'default2', 1), (12, 'iPhone', 1), (13, NULL, 2), (14, 'default1', 1), (15, 'iPhone', 2), (16, 'default2', NULL), (17, 'iPhone', NULL), (18, 'S8', NULL), (19, 'iPhone', NULL), (20, 'default2', 2), (21, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (8, 0, 0, '2023-01-02', NULL, 1), (15, 2, NULL, '2023-01-02', 2, NULL), (19, 2, NULL, NULL, NULL, NULL), (2, 0, -1, '2023-01-02', 1, 1), (11, 0, 2, '2023-01-02', 2, 2), (15, NULL, -1, NULL, 1, 2), (14, -1, 1, '2023-01-01', NULL, NULL), (18, 1, -1, '2023-01-02', NULL, 2), (15, 2, -1, NULL, 2, 1), (13, NULL, 1, '2023-01-01', 1, NULL), (0, 2, NULL, '2023-01-01', 2, 1), (8, NULL, -1, '2023-01-01', 2, 1), (6, -1, -1, NULL, 1, 1), (19, 2, NULL, '2023-01-01', 2, 2), (-1, -1, 2, '2023-01-01', 1, NULL), (17, NULL, 1, NULL, 2, NULL), (8, -1, 1, '2023-01-02', NULL, 1), (0, NULL, 2, '2023-01-02', 2, NULL), (NULL, 0, 0, '2023-01-01', 2, 2), (4, 0, -1, '2023-01-01', NULL, 1), (9, -1, NULL, '2023-01-01', 1, 2), (-1, -1, -1, '2023-01-01', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT DISTINCT C.BUYER_ID FROM SALES AS C LEFT JOIN PRODUCT AS G ON C.PRODUCT_ID = G.PRODUCT_ID LEFT JOIN (SELECT BUYER_ID, PRODUCT_NAME FROM SALES AS A LEFT JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone') AS D ON C.BUYER_ID = D.BUYER_ID WHERE D.PRODUCT_NAME IS NULL AND G.PRODUCT_NAME = 'S8';

/*
Prediction Result:
(0,)
(None,)
*/