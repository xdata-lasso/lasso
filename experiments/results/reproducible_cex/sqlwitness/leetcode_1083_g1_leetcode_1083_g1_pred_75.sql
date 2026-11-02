-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'iPhone', 1), (1, NULL, 1), (-1, NULL, 2), (0, NULL, NULL), (3, NULL, 1), (4, NULL, NULL), (5, 'iPhone', 1), (6, 'default1', NULL), (7, 'default2', NULL), (8, 'iPhone', NULL), (9, 'S8', NULL), (10, 'S8', NULL), (11, 'default2', NULL), (12, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, NULL, 2, '2023-01-01', 1, 2), (2, -1, 0, NULL, NULL, 2), (4, 2, NULL, NULL, NULL, 1), (5, 1, NULL, '2023-01-01', 1, NULL), (-1, 2, 2, '2023-01-01', 1, NULL), (0, 1, NULL, '2023-01-01', NULL, NULL), (4, 0, 2, '2023-01-02', NULL, 2), (2, 1, 2, '2023-01-02', NULL, 1), (0, NULL, 0, '2023-01-02', NULL, 1), (3, 1, 1, NULL, 1, 2), (12, 1, 1, '2023-01-01', 2, 1), (11, -1, 0, '2023-01-01', NULL, 1), (9, -1, 1, '2023-01-02', 1, 1), (2, 0, NULL, NULL, NULL, 2), (10, 2, NULL, '2023-01-02', 1, NULL), (6, 1, 2, '2023-01-01', 2, 1), (-1, 0, NULL, '2023-01-01', 2, 2), (3, 2, 2, '2023-01-02', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT T3.BUYER_ID FROM SALES AS T3 JOIN PRODUCT AS T4 ON T3.PRODUCT_ID = T4.PRODUCT_ID WHERE T4.PRODUCT_NAME = 'S8' AND NOT T3.BUYER_ID IN (SELECT T1.BUYER_ID FROM SALES AS T1 LEFT JOIN PRODUCT AS T2 ON T1.PRODUCT_ID = T2.PRODUCT_ID WHERE T2.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/