-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, 1), (0, 'default1', 2), (-1, 'default1', 1), (2, 'default1', 2), (3, 'S8', 1), (4, NULL, NULL), (5, 'iPhone', 1), (6, 'S8', 1), (7, NULL, NULL), (8, 'iPhone', NULL), (9, 'default1', 1), (10, 'S8', 2), (11, 'iPhone', 2), (12, 'default1', 1), (13, 'S8', 2), (14, NULL, 2), (15, 'default1', 2), (16, 'iPhone', 2), (17, 'default1', 2), (18, 'S8', 2), (19, 'default2', 1), (20, 'iPhone', 2), (21, 'S8', NULL), (22, 'iPhone', 2), (23, 'S8', 2), (24, 'S8', 2), (25, 'S8', NULL), (26, 'default1', 1), (27, 'default1', 1), (28, 'S8', NULL), (29, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (21, 1, -1, '2023-01-02', 1, 2), (13, 0, -1, '2023-01-02', 2, 2), (-1, -1, NULL, '2023-01-01', NULL, 2), (11, 1, -1, '2023-01-01', 2, 2), (26, 2, -1, NULL, 1, NULL), (0, 2, -1, '2023-01-02', NULL, 1), (8, 2, NULL, '2023-01-02', 1, 2), (26, NULL, 2, '2023-01-02', NULL, 1), (24, -1, 0, NULL, NULL, 1), (13, 1, 1, '2023-01-02', 2, NULL), (3, 2, -1, '2023-01-01', 1, NULL), (15, -1, NULL, '2023-01-01', 1, 2), (15, -1, -1, NULL, 1, NULL), (25, 1, NULL, '2023-01-02', 2, NULL), (-1, NULL, 2, NULL, 1, 2), (1, -1, 2, '2023-01-02', 2, NULL), (20, NULL, 2, '2023-01-01', 1, NULL), (24, NULL, NULL, '2023-01-02', NULL, NULL), (10, 1, 2, '2023-01-02', 2, 2), (0, 2, 0, '2023-01-01', 2, NULL), (1, 2, 1, '2023-01-02', 1, NULL), (11, 0, 0, '2023-01-01', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(1,)
*/

-- Prediction Query
WITH T1 AS (SELECT DISTINCT BUYER_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone') SELECT DISTINCT BUYER_ID FROM SALES AS S LEFT JOIN PRODUCT AS P USING (PRODUCT_ID) WHERE P.PRODUCT_NAME = 'S8' AND NOT BUYER_ID IN (SELECT * FROM T1);

/*
Prediction Result:
*/