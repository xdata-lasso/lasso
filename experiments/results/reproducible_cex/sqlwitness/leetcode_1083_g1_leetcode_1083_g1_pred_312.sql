-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', 1), (2, '1', 1), (1, 'S8', NULL), (-1, '1', 2), (3, 'iPhone', 1), (4, 'default2', 2), (5, '0', 1), (6, 'S8', 2), (7, NULL, 1), (8, '1', 2), (9, '0', 2), (10, 'S8', 1), (11, 'default2', 2), (12, '1', 2), (13, 'iPhone', 2), (14, 'S8', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, NULL, NULL, '2023-01-01', 1, NULL), (4, NULL, 1, '2023-01-01', 2, NULL), (1, NULL, 2, '2023-01-01', 2, NULL), (14, 1, 0, '2026-10-01', 1, 2), (3, 0, -1, NULL, 1, 1), (14, 0, NULL, NULL, 2, 2);
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
WITH CTE1 AS (SELECT S.BUYER_ID, SUM(CASE WHEN P.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8_FLG, SUM(CASE WHEN P.PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IPHONE_FLG FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY S.BUYER_ID) SELECT BUYER_ID FROM CTE1 WHERE S8_FLG >= '1' AND IPHONE_FLG = '0';

/*
Prediction Result:
*/