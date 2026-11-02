-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, 1), (0, 'S8', 1), (2, 'S8', 2), (-1, 'default2', NULL), (3, 'S8', 2), (4, 'default1', 1), (5, 'default2', 1), (6, 'iPhone', 1), (7, 'S8', 2), (8, 'default1', 1), (9, 'default2', NULL), (10, 'S8', 1), (11, 'default1', 2), (12, 'S8', 2), (13, NULL, 1), (14, 'S8', 2), (15, NULL, 2), (16, 'default1', NULL), (17, 'iPhone', 1), (18, 'default2', 1), (19, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 1, -1, '2023-01-02', NULL, 2), (NULL, -1, -1, '2023-01-01', NULL, NULL), (2, 0, 0, NULL, 1, 1), (8, -1, 0, NULL, 1, NULL), (2, 2, 1, NULL, 2, NULL), (7, -1, NULL, '2023-01-01', 1, 2), (18, 0, -1, '2023-01-02', NULL, NULL), (-1, NULL, -1, '2023-01-02', NULL, 2), (13, 0, 2, '2023-01-01', 1, NULL), (6, 2, 1, '2023-01-02', NULL, NULL), (9, 1, 2, NULL, 1, NULL), (11, 1, -1, NULL, 2, 1), (1, 1, 2, NULL, NULL, 1), (4, NULL, 1, '2023-01-02', NULL, 1), (5, 2, 1, NULL, 2, 2), (14, 2, 2, '2023-01-02', 2, NULL), (10, 1, 0, '2023-01-02', 2, 2), (17, 0, NULL, NULL, 1, 2), (14, 0, 1, '2023-01-02', NULL, 1), (10, -1, NULL, '2023-01-01', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(0,)
(2,)
*/

-- Prediction Query
WITH A AS (SELECT PRODUCT_NAME, BUYER_ID FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID), B AS (SELECT DISTINCT BUYER_ID FROM A WHERE PRODUCT_NAME = 'iPhone') SELECT DISTINCT BUYER_ID FROM A WHERE PRODUCT_NAME = 'S8' AND NOT BUYER_ID IN (SELECT * FROM B);

/*
Prediction Result:
*/