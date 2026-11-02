-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'default1', 2), (0, 'S8', NULL), (1, 'default2', NULL), (-1, 'default1', 1), (3, 'iPhone', NULL), (4, 'iPhone', NULL), (5, 'iPhone', NULL), (6, 'iPhone', 1), (7, 'S8', 2), (8, 'iPhone', 2), (9, 'S8', NULL), (10, 'iPhone', 1), (11, 'default1', 2), (12, NULL, 2), (13, 'S8', NULL), (14, 'S8', 1), (15, 'S8', NULL), (16, 'default2', 1), (17, NULL, 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (-1, NULL, -1, NULL, 1, 1), (15, -1, 2, NULL, 1, 2), (11, 2, 2, '2023-01-01', 2, NULL), (6, 2, 2, '2023-01-02', 2, NULL), (1, 0, 0, '2023-01-02', 2, NULL), (1, 2, 0, NULL, 2, 2), (10, 1, 2, '2023-01-02', 1, 1), (15, 1, 2, NULL, 1, 1), (7, 0, 0, '2023-01-01', 1, 1), (13, -1, NULL, '2023-01-01', NULL, 1), (12, NULL, NULL, NULL, 1, 2), (5, -1, NULL, NULL, 2, 1), (12, 1, 1, '2023-01-02', 1, NULL), (11, -1, 2, NULL, NULL, NULL), (6, 1, 1, NULL, 1, 2), (13, 1, 2, '2023-01-01', 1, 2), (2, 1, 1, '2023-01-01', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(0,)
*/

-- Prediction Query
WITH CTE AS (SELECT A.BUYER_ID FROM SALES AS A INNER JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID AND PRODUCT_NAME = 'S8'), CTE1 AS (SELECT A.BUYER_ID FROM SALES AS A INNER JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID AND PRODUCT_NAME = 'iPhone') SELECT DISTINCT BUYER_ID FROM CTE AS A WHERE NOT BUYER_ID IN (SELECT BUYER_ID FROM CTE1);

/*
Prediction Result:
*/