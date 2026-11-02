-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', 2), (-1, 'default2', NULL), (2, 'default1', 1), (0, 'default2', 2), (3, 'default1', 2), (4, '%S8%', 2), (5, 'iPhone', 2), (6, 'default2', 2), (7, '%S8%', 1), (8, NULL, NULL), (9, 'default2', 1), (10, NULL, 1), (11, '%IPHONE%', NULL), (12, 'default2', NULL), (13, 'iPhone', 2), (14, 'S8', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 1, 1, NULL, 1, 1), (6, 1, 1, '2023-01-01', 2, NULL), (NULL, NULL, NULL, NULL, 1, NULL), (8, 0, NULL, NULL, 2, NULL), (7, 2, 0, NULL, 2, NULL), (-1, 0, NULL, NULL, 1, NULL), (1, 2, -1, '2023-01-01', 1, 1), (4, NULL, NULL, '2023-01-01', NULL, 1), (10, -1, 0, '2023-01-01', NULL, NULL), (7, 2, 1, NULL, 2, 1), (11, 2, 2, '2023-01-01', 2, NULL), (5, NULL, -1, NULL, 1, 1), (0, 0, 1, '2023-01-02', 1, 1), (13, -1, 1, '2023-01-01', 2, 1), (6, NULL, 1, '2023-01-01', 1, NULL), (6, 2, -1, '2023-01-01', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT S.BUYER_ID, GROUP_CONCAT(P.PRODUCT_NAME) AS PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY S.BUYER_ID) SELECT BUYER_ID FROM CTE WHERE PRODUCT_NAME LIKE '%S8%' AND PRODUCT_NAME NOT LIKE '%IPHONE%';

/*
Prediction Result:
(None,)
(0,)
*/