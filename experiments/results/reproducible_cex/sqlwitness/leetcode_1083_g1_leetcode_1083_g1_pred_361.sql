-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'iPhone', 1), (-1, 'S8', 2), (2, 'S8', NULL), (0, 'iPhone', 1), (3, NULL, 2), (4, NULL, 2), (5, 'default1', NULL), (6, 'S8', NULL), (7, 'iPhone', NULL), (8, 'default1', 2), (9, NULL, NULL), (10, NULL, 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 2, 0, NULL, NULL, NULL), (5, 1, 1, NULL, NULL, NULL), (10, 1, 1, '2023-01-01', 2, NULL), (NULL, 0, 2, NULL, 1, NULL), (NULL, 0, NULL, '2023-01-02', 2, 1), (1, -1, 0, NULL, 1, 2), (8, 2, NULL, NULL, 2, NULL), (4, 0, NULL, '2023-01-01', NULL, 2), (5, 2, NULL, '2023-01-02', 1, 2), (5, 1, 1, NULL, 2, 2), (6, 2, -1, '2023-01-02', NULL, NULL), (5, 1, 0, '2023-01-01', 2, 1), (4, -1, 1, NULL, 1, 2), (8, -1, NULL, '2023-01-02', 1, 1), (-1, 0, 1, '2023-01-02', NULL, NULL), (7, 1, NULL, '2023-01-02', 2, 1), (6, NULL, 0, '2023-01-01', NULL, 2), (2, NULL, 0, NULL, NULL, 1), (2, 0, 0, NULL, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
(1,)
*/

-- Prediction Query
WITH T AS (SELECT BUYER_ID, PRODUCT_NAME FROM SALES AS T1 JOIN PRODUCT AS T2 ON T1.PRODUCT_ID = T2.PRODUCT_ID WHERE PRODUCT_NAME IN ('S8', 'iPhone')) SELECT DISTINCT BUYER_ID FROM T WHERE BUYER_ID IN (SELECT BUYER_ID FROM T WHERE PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT BUYER_ID FROM T WHERE PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/