-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', 1), (2, 'S8', 2), (-1, NULL, NULL), (1, 'default2', 2), (3, 'S8', NULL), (4, 'S8', 2), (5, 'default1', NULL), (6, 'iPhone', 1), (7, 'iPhone', 2), (8, 'S8', 2), (9, 'S8', 1), (10, NULL, 1), (11, NULL, NULL), (12, 'S8', 1), (13, 'S8', 2), (14, 'default1', 1), (15, NULL, NULL), (16, 'default2', 1), (17, 'S8', 2), (18, 'S8', 2), (19, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (8, 2, -1, '2023-01-02', NULL, NULL), (11, 1, 2, '2023-01-02', 1, 2), (6, 1, 0, NULL, 2, NULL), (15, 2, 1, '2023-01-02', 2, 2), (10, -1, -1, NULL, NULL, 1), (0, 0, -1, '2023-01-02', 2, NULL), (18, -1, NULL, NULL, 1, 1), (8, 2, NULL, '2023-01-01', 2, NULL), (7, 0, 1, NULL, 2, 1), (NULL, -1, -1, '2023-01-02', 2, NULL), (3, 1, 1, NULL, 1, NULL), (4, -1, 0, NULL, NULL, NULL), (1, -1, 2, NULL, 2, 2), (17, 1, 1, '2023-01-02', NULL, 2), (7, NULL, 1, '2023-01-01', NULL, 1), (5, -1, 0, '2023-01-01', NULL, 2), (10, 2, 1, '2023-01-02', 2, 2), (9, 0, 0, '2023-01-01', 1, 1), (-1, 2, NULL, NULL, 2, 1), (3, 1, 2, '2023-01-02', NULL, NULL), (10, 0, -1, '2023-01-02', 2, NULL), (15, -1, -1, '2023-01-01', 2, 2), (4, 0, NULL, '2023-01-01', 2, 2), (8, 0, -1, '2023-01-01', 1, 1), (8, NULL, NULL, '2023-01-02', NULL, NULL), (11, 0, 2, NULL, NULL, NULL), (6, 0, NULL, '2023-01-01', 1, 2), (11, 1, NULL, NULL, NULL, NULL), (16, 2, NULL, '2023-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
(2,)
*/

-- Prediction Query
WITH TEMP AS (SELECT * FROM PRODUCT JOIN SALES USING (PRODUCT_ID)) SELECT DISTINCT BUYER_ID FROM SALES WHERE BUYER_ID IN (SELECT BUYER_ID FROM TEMP WHERE PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT BUYER_ID FROM TEMP WHERE PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/