-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, NULL, 2), (0, 'default1', 2), (1, 'iPhone', NULL), (-1, 'default2', 1), (3, NULL, NULL), (4, 'S8', 2), (5, 'S8', 1), (6, 'default2', 1), (7, 'default1', NULL), (8, 'S8', 2), (9, 'S8', NULL), (10, 'default2', 2), (11, 'S8', 1), (12, 'default2', 2), (13, 'default2', 1), (14, 'default1', 1), (15, 'default1', 1), (16, 'S8', 2), (17, 'default2', 2), (18, 'S8', NULL), (19, NULL, 1), (20, 'default2', 2), (21, 'default2', 2), (22, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (8, NULL, 1, NULL, 1, 1), (16, 1, 1, NULL, 2, 2), (16, 2, -1, '2023-01-01', 2, 2), (6, 2, 0, '2023-01-02', NULL, 1), (6, NULL, -1, '2023-01-01', NULL, 1), (1, -1, 2, '2023-01-02', 2, 1), (20, -1, 1, '2023-01-02', NULL, NULL), (3, -1, 0, '2023-01-02', NULL, 1), (11, 0, 0, '2023-01-02', 2, 1), (3, 2, -1, NULL, NULL, 1), (1, 0, NULL, NULL, 2, 2), (18, 0, -1, NULL, 2, NULL), (12, 2, NULL, NULL, 1, 1), (4, -1, 0, '2023-01-01', NULL, 1), (9, 0, NULL, '2023-01-01', NULL, 2), (13, 2, NULL, '2023-01-01', NULL, NULL), (21, 2, 2, NULL, NULL, 2);
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
WITH T1 AS (SELECT DISTINCT BUYER_ID FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8'), T2 AS (SELECT DISTINCT BUYER_ID FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'iPhone') SELECT T1.BUYER_ID FROM T1 WHERE NOT T1.BUYER_ID IN (SELECT * FROM T2);

/*
Prediction Result:
*/