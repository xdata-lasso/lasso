-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', NULL), (-1, 'default1', 2), (0, 'S8', NULL), (2, 'default1', 2), (3, 'iPhone', 1), (4, NULL, NULL), (5, 'S8', NULL), (6, 'iPhone', 2), (7, 'iPhone', 2), (8, 'default1', 1), (9, 'S8', 2), (10, 'S8', 1), (11, 'default2', 2), (12, 'default2', 2), (13, 'iPhone', NULL), (14, 'S8', 1), (15, NULL, NULL), (16, 'S8', 2), (17, NULL, 1), (18, NULL, NULL), (19, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 1, -1, '2023-01-01', 1, NULL), (5, NULL, 0, NULL, 1, NULL), (0, 1, NULL, '2023-01-02', 2, 1), (6, 1, 0, NULL, NULL, 1), (0, 2, -1, '2023-01-01', 2, 1), (11, -1, -1, '2023-01-02', 1, NULL), (8, -1, -1, '2023-01-02', NULL, 2), (7, 1, 1, NULL, 1, NULL), (3, 2, NULL, NULL, 1, 2), (9, 1, NULL, '2023-01-02', NULL, 2), (18, 2, 2, '2023-01-02', 1, 1), (1, 2, 2, '2023-01-01', 2, NULL), (-1, 0, 2, '2023-01-02', 1, 1), (10, NULL, -1, '2023-01-02', 2, 2), (1, NULL, 2, '2023-01-02', NULL, 1), (7, -1, 1, NULL, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
*/

-- Prediction Query
WITH CTE1 AS (SELECT DISTINCT S.BUYER_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8'), CTE2 AS (SELECT DISTINCT S1.BUYER_ID FROM SALES AS S1 LEFT JOIN PRODUCT AS P ON P.PRODUCT_ID = S1.PRODUCT_ID WHERE P.PRODUCT_NAME = 'iPhone') SELECT DISTINCT C1.BUYER_ID FROM CTE1 AS C1 WHERE NOT C1.BUYER_ID IN (SELECT C2.* FROM CTE2 AS C2);

/*
Prediction Result:
*/