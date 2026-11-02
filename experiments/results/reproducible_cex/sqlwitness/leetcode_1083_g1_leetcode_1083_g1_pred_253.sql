-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', NULL), (2, 'iPhone', 2), (0, 'S8', 2), (-1, 'iPhone', 1), (3, 'S8', 2), (4, 'default2', NULL), (5, 'default1', 2), (6, 'default2', 2), (7, 'S8', 2), (8, 'default1', 1), (9, 'default2', NULL), (10, 'default2', 1), (11, 'default2', 2), (12, 'default2', NULL), (13, 'default1', NULL), (14, 'iPhone', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 0, 0, NULL, 2, 1), (7, NULL, NULL, '2023-01-01', 2, 2), (6, 2, 2, '2023-01-01', NULL, NULL), (4, NULL, -1, NULL, 2, 1), (13, NULL, -1, '2023-01-02', 1, NULL), (0, NULL, 0, NULL, 1, 1), (6, NULL, 1, '2023-01-01', 1, 1), (2, 2, NULL, '2023-01-02', 2, NULL), (0, -1, 2, NULL, 1, NULL), (9, 0, 2, NULL, 1, 1), (14, 0, 1, '2023-01-01', 2, NULL), (7, -1, -1, NULL, 1, 2), (4, 1, NULL, '2023-01-01', 1, 1), (0, 0, NULL, '2023-01-02', 2, 2), (11, NULL, NULL, '2023-01-01', 2, 2), (2, 0, 0, NULL, 1, 2), (-1, 0, 2, NULL, 1, 2), (4, NULL, 0, '2023-01-01', 1, 2), (2, 2, 1, '2023-01-01', 1, 1), (10, 2, 2, '2023-01-01', 2, 1), (NULL, 0, -1, NULL, 2, 1), (7, 0, NULL, '2023-01-01', NULL, 2), (12, NULL, 1, '2023-01-02', NULL, 1), (7, 1, -1, NULL, 2, 1), (2, -1, NULL, '2023-01-01', NULL, NULL), (6, 1, 2, '2023-01-01', NULL, 2), (0, 1, NULL, '2023-01-01', 2, 2), (-1, NULL, 0, '2023-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
*/

-- Prediction Query
WITH TB1 AS (SELECT S.BUYER_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID) SELECT DISTINCT BUYER_ID FROM TB1 WHERE PRODUCT_NAME = 'S8' AND NOT BUYER_ID IN (SELECT BUYER_ID FROM TB1 WHERE PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/